report 50032 "Total Sales Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/TotalSalesReport.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = WHERE(Number = FILTER(1 ..));
            column(DocNo; TempSalesLine."Document No.")
            {
            }

            column(CusNo; TempSalesLine."Sell-to Customer No.")
            {
            }
            column(BuCode; TempSalesLine."Shortcut Dimension 1 Code")
            {
            }
            column(OprCode; TempSalesLine."Shortcut Dimension 2 Code")
            {
            }
            column(SOAmt; TempSalesLine.Amount)
            {
            }
            column(CusName; TempSalesLine."Description 2")
            {
            }
            column(InvAmt; TempSalesLine."Amount Including VAT")
            {
            }
            column(CredAmt; TempSalesLine."VAT Amount")
            {
            }
            column(SP; TempSalesLine."Bill-to Customer No.")
            {
            }
            column(ComName; ComRec.Name)
            {
            }
            column(TxtFilter; TxtFilter)
            {
            }
            column(STDate; STDate)
            {
            }
            column(EDDate; EDDate)
            {
            }
            column(BUCodeTxt; BUCode)
            {
            }
            column(OprCodeTxt; OprCode)
            {
            }
            column(CusCode; CusCode)
            {
            }
            column(SPCode; SPCode)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempSalesLine.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempSalesLine.NEXT = 0 THEN
                        CurrReport.BREAK;
                IF TempSalesLine."Sell-to Customer No." = '' THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            var
                ExRate: Decimal;
                SalesLine: Record "Sales Line";
                ExRate1: Decimal;
                SalesCredLine: Record "Sales Cr.Memo Line";
                SalesCredHeddRec: Record "Sales Cr.Memo Header";
            begin
                TempSalesLine.RESET;
                TempSalesLine.DELETEALL;
                IF STDate = 0D THEN
                    ERROR('Starting date must have a value');
                IF EDDate = 0D THEN
                    ERROR('Ending date must have a value');
                ComRec.GET;
                TxtFilter := GETFILTERS;
                SalesHedd.RESET;
                SalesCredHedd.RESET;
                SalesInvHedd.RESET;
                SoAmt := 0;
                IF (STDate <> 0D) AND (EDDate <> 0D) THEN BEGIN
                    SalesInvHedd.SETRANGE("Posting Date", STDate, EDDate);
                    SalesCredHedd.SETRANGE("Posting Date", STDate, EDDate);
                    SalesHedd.SETRANGE("Order Date", STDate, EDDate);
                END;
                IF BUCode <> '' THEN BEGIN
                    SalesInvHedd.SETFILTER("Shortcut Dimension 1 Code", BUCode);
                    SalesCredHedd.SETFILTER("Shortcut Dimension 1 Code", BUCode);
                    SalesHedd.SETRANGE("Shortcut Dimension 1 Code", BUCode);
                END;
                IF OprCode <> '' THEN BEGIN
                    SalesInvHedd.SETFILTER("Shortcut Dimension 2 Code", OprCode);
                    SalesCredHedd.SETFILTER("Shortcut Dimension 2 Code", OprCode);
                    SalesHedd.SETRANGE("Shortcut Dimension 2 Code", OprCode);
                END;
                IF CusCode <> '' THEN BEGIN
                    SalesInvHedd.SETFILTER("Sell-to Customer No.", CusCode);
                    SalesCredHedd.SETFILTER("Sell-to Customer No.", CusCode);
                    SalesHedd.SETRANGE("Sell-to Customer No.", CusCode);
                END;
                IF SPCode <> '' THEN BEGIN
                    SalesInvHedd.SETFILTER("Salesperson Code", SPCode);
                    SalesCredHedd.SETFILTER("Salesperson Code", SPCode);
                    SalesHedd.SETRANGE("Salesperson Code", SPCode);
                END;

                TempSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                SalesHedd.SETRANGE("Document Type", SalesHedd."Document Type"::Order);
                SalesHedd.SETFILTER(Status, 'Released|Pending Approval');
                IF SalesHedd.FINDSET THEN BEGIN
                    REPEAT
                        IF SalesHedd."Currency Code" <> '' THEN
                            ExRate := 1 / SalesHedd."Currency Factor"
                        ELSE
                            ExRate := 1;

                        SalesLine.SETRANGE("Document Type", SalesHedd."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHedd."No.");
                        SalesLine.SETFILTER(SalesLine."No.", '<>%1', '');
                        SalesLine.SETFILTER(Quantity, '<>%1', 0);
                        IF SalesLine.FINDSET THEN BEGIN
                            REPEAT
                                SoAmt := (((SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Outstanding Quantity")) * ExRate;
                                TempSalesLine.INIT;
                                TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
                                TempSalesLine."Document No." := SalesHedd."No.";
                                TempSalesLine."Line No." := TempSalesLine."Line No." + 10000;
                                TempSalesLine."Shortcut Dimension 1 Code" := SalesHedd."Shortcut Dimension 1 Code";
                                TempSalesLine."Shortcut Dimension 2 Code" := SalesHedd."Shortcut Dimension 2 Code";
                                TempSalesLine."Sell-to Customer No." := SalesHedd."Sell-to Customer No.";
                                TempSalesLine."Description 2" := SalesHedd."Sell-to Customer Name";
                                TempSalesLine."Bill-to Customer No." := SalesHedd."Salesperson Code";
                                //SalesHedd.CALCFIELDS(SalesHedd."Amount Including VAT");
                                TempSalesLine.Amount := SoAmt;
                                TempSalesLine.INSERT;
                            UNTIL SalesLine.NEXT = 0;
                        END;
                    UNTIL SalesHedd.NEXT = 0;
                END;
                SalesInvHedd.SETRANGE("Debit Note", FALSE);
                IF SalesInvHedd.FINDSET THEN
                    REPEAT
                        IF SalesInvHedd."Currency Code" <> '' THEN
                            ExRate := 1 / SalesInvHedd."Currency Factor"
                        ELSE
                            ExRate := 1;
                        TempSalesLine.INIT;
                        TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
                        TempSalesLine."Document No." := SalesInvHedd."No.";
                        TempSalesLine."Line No." := TempSalesLine."Line No." + 10000;
                        TempSalesLine."Shortcut Dimension 1 Code" := SalesInvHedd."Shortcut Dimension 1 Code";
                        TempSalesLine."Shortcut Dimension 2 Code" := SalesInvHedd."Shortcut Dimension 2 Code";
                        TempSalesLine."Sell-to Customer No." := SalesInvHedd."Sell-to Customer No.";
                        TempSalesLine."Description 2" := SalesInvHedd."Sell-to Customer Name";
                        TempSalesLine."Bill-to Customer No." := SalesInvHedd."Salesperson Code";
                        SalesInvHedd.CALCFIELDS(SalesInvHedd."Amount Including VAT");
                        TempSalesLine."Amount Including VAT" := SalesInvHedd."Amount Including VAT" * ExRate;
                        TempSalesLine.INSERT;
                    UNTIL SalesInvHedd.NEXT = 0;

                IF SalesCredHedd.FINDSET THEN
                    REPEAT
                        IF SalesCredHedd."Currency Code" <> '' THEN
                            ExRate := 1 / SalesCredHedd."Currency Factor"
                        ELSE
                            ExRate := 1;
                        SalesCredLine.RESET;
                        SalesCredLine.SETRANGE("Document No.", SalesCredHedd."No.");
                        SalesCredLine.SETRANGE(Type, SalesCredLine.Type::Item);
                        IF SalesCredLine.FINDSET THEN BEGIN
                            REPEAT
                                SalesCredHeddRec.GET(SalesCredLine."Document No.");
                                TempSalesLine.INIT;
                                TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
                                TempSalesLine."Document No." := SalesCredHeddRec."No.";
                                TempSalesLine."Line No." := TempSalesLine."Line No." + 10000;
                                TempSalesLine."Shortcut Dimension 1 Code" := SalesCredHeddRec."Shortcut Dimension 1 Code";
                                TempSalesLine."Shortcut Dimension 2 Code" := SalesCredHeddRec."Shortcut Dimension 2 Code";
                                TempSalesLine."Sell-to Customer No." := SalesCredHeddRec."Sell-to Customer No.";
                                TempSalesLine."Description 2" := SalesCredHeddRec."Sell-to Customer Name";
                                TempSalesLine."Bill-to Customer No." := SalesCredHeddRec."Salesperson Code";
                                SalesCredHeddRec.CALCFIELDS(SalesCredHeddRec."Amount Including VAT");
                                TempSalesLine."VAT Amount" := SalesCredLine."Amount Including VAT" * ExRate;
                                TempSalesLine.INSERT;
                            UNTIL SalesCredLine.NEXT = 0;
                        END;
                    UNTIL SalesCredHedd.NEXT = 0;
                //IF (NOT SalesHedd.FINDSET) AND (NOT SalesCredHedd.FINDSET) AND (NOT SalesInvHedd.FINDSET) THEN
                //CurrReport.SKIP;
                //IF TempSalesLine."Shortcut Dimension 1 Code" = '' THEN
                //CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(STDate; STDate)
                {
                    Caption = 'Start Date';
                }
                field(EDDate; EDDate)
                {
                    Caption = 'End Date';
                }
                field(BUCode; BUCode)
                {
                    Caption = 'BU Code';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                }
                field(OprCode; OprCode)
                {
                    Caption = 'Operation Code';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                }
                field(CusCode; CusCode)
                {
                    Caption = 'Customer Code';
                    TableRelation = Customer;
                }
                field(SPCode; SPCode)
                {
                    Caption = 'Sales Person';
                    TableRelation = "Salesperson/Purchaser";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var

        ComRec: Record "company information";
        SalesInvHedd: Record "Sales Invoice Header";
        SalesHedd: Record "Sales Header";
        SalesCredHedd: Record "Sales Cr.Memo Header";
        TempSalesLine: Record "Sales Line" Temporary;
        InvAmt: Decimal;
        SoAmt: Decimal;
        CredAmt: Decimal;
        TxtFilter: Text[100];
        STDate: Date;
        EDDate: Date;
        BUCode: Code[20];
        OprCode: Code[20];
        CusCode: Code[20];
        SPCode: Code[20];
}

