report 50063 "Allocated Receipt Listing"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/AllocatedReceiptListing.rdl';
    Caption = 'Allocated Receipt Listing';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Payment | ' '),
                                      Reversed = FILTER(false),
                                      "Bal. Account Type" = FILTER("G/L Account" | "Bank Account"),
                                      "Source Code" = FILTER('CASHRECJNL' | 'PD-Cheque'/*PD-CHQ*/));
            RequestFilterFields = "Posting Date", "Customer No.", "Document No.", "Salesperson Code", "Payment Method Code", "Global Dimension 1 Code", "Global Dimension 2 Code";
            column(Date; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(receipt_no; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(cheque_no; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(customer_no; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(customer_name; CusRec.Name)
            {
            }
            column(posting_group; CusRec."Customer Posting Group")
            {
            }
            column(amountLCY; "Amount (LCY)")
            {
            }
            column(Payment_code; ValFormat)
            {
            }
            column(DocDate; CusLegEntRec."Document Date")
            {
            }
            column(com_name; ComRec.Name)
            {
            }
            column(com_address; ComRec.Address)
            {
            }
            column(com_city; ComRec.City)
            {
            }
            column(com_phone; ComRec."Phone No.")
            {
            }
            column(com_fax; ComRec."Fax No.")
            {
            }
            column(TotalAmt; Subtotal)
            {
            }
            column(GroupBy; GroupBy)
            {
            }
            column(GroupByNo; GroupByNo)
            {
            }
            column(GroupByName; GroupByName)
            {
            }
            column(TxtFilter; TxtFilter)
            {
            }
            column(OriginalAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Original Amt. (LCY)")
            {
            }
            column(POM; "Cust. Ledger Entry"."Payment Method Code")
            {
            }
            column(TempReceiptNo; "Cust. Ledger Entry"."Temp. Receipt No.")
            {
            }
            dataitem(DataItem20; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(TempDocType; CusLedEntryApp."Document Type")
                {
                }
                column(TempDocNo; CusLedEntryApp."Document No.")
                {
                }
                column(TempDocDate; CusLedEntryApp."Document Date")
                {
                }
                column(BuCode; CusLedEntryApp."Global Dimension 1 Code")
                {
                }
                column(SP_code; CusLedEntryApp."Salesperson Code")
                {
                }
                column(Dimension_Name; CusLedEntryApp."Global Dimension 2 Code")
                {
                }
                column(DateRage; Range)
                {
                }
                column(Variance; Variance)
                {
                }
                column(PayAppAmt; PayAmount)
                {
                }
                column(DisAmt; DisAmount)
                {
                }

                trigger OnAfterGetRecord()
                var
                    PayTermCode: Record "Payment Terms";
                    StDate: Date;
                    EdDate: Date;
                    DelCusLedEntry: Record "Detailed Cust. Ledg. Entry";
                    SalesInvLine: Record "Sales Invoice Line";
                begin
                    IF NOT DirectPay THEN BEGIN
                        IF CusLedEntryApp.FINDFIRST THEN
                            CusLedEntryApp.NEXT(Inx);
                        Inx := Inx + 1;
                        IF CusLedEntryApp."Document Date" <> 0D THEN //RJ
                            Range := "Cust. Ledger Entry"."Posting Date" - CusLedEntryApp."Document Date";
                        //
                        Variance := 0;
                        IF PayTermCode.GET(CusRec."Payment Terms Code") THEN BEGIN
                            StDate := CALCDATE('<' + FORMAT(PayTermCode."Due Date Calculation") + '>', TODAY);
                            EdDate := CALCDATE('<' + FORMAT(Range) + 'D>', TODAY);
                            //Variance := EdDate - StDate;
                            Variance := StDate - EdDate;
                        END;
                        PayAmount := 0;
                        DelCusLedEntry.RESET;
                        DelCusLedEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type",
                            "Document Type", "Document No.");
                        DelCusLedEntry.SETRANGE("Cust. Ledger Entry No.", CusLedEntryApp."Entry No.");
                        DelCusLedEntry.SETRANGE("Entry Type", DelCusLedEntry."Entry Type"::Application);
                        DelCusLedEntry.SETRANGE("Document Type", DelCusLedEntry."Document Type"::Payment);
                        DelCusLedEntry.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                        DelCusLedEntry.CALCSUMS("Amount (LCY)");
                        PayAmount := DelCusLedEntry."Amount (LCY)";
                        //
                        DisAmount := 0;
                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", CusLedEntryApp."Document No.");
                        SalesInvLine.CALCSUMS("Line Discount Amount");
                        DisAmount := SalesInvLine."Line Discount Amount";
                    END
                    ELSE BEGIN
                        Range := 0;
                        Variance := 0;
                        DisAmount := 0;
                        PayAmount := "Cust. Ledger Entry"."Amount (LCY)";
                        ;
                    END;
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, CusLedEntryApp."Global Dimension 2 Code");
                    IF DimensionValue.FINDFIRST THEN;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT DirectPay THEN BEGIN
                        SETRANGE(Number, 1, CusLedEntryApp.COUNT);
                        Inx := 0;
                    END
                    ELSE
                        SETRANGE(Number, 1, 1);
                end;
            }

            trigger OnAfterGetRecord()
            var
                PayTermCode: Record "Payment Terms";
                NewString: Code[20];
                CustMange: Codeunit "Get Apply Entries";
            begin
                SlsPesnRec.RESET;
                SlsPesnRec.SETRANGE(Code, "Cust. Ledger Entry"."Salesperson Code");
                IF SlsPesnRec.FINDFIRST THEN;
                /*
                TemCusLedEntry.DELETEALL;
                CLEAR(TemCusLedEntry);
                CusLegEntRec.RESET;
                CusLegEntRec.SETRANGE("Closed by Entry No.","Entry No.");
                IF CusLegEntRec.FINDSET THEN
                REPEAT
                  TemCusLedEntry.TRANSFERFIELDS(CusLegEntRec);
                  TemCusLedEntry.INSERT;
                UNTIL CusLegEntRec.NEXT =0;
                */
                IF CusRec.GET("Customer No.") THEN;
                CustMange.GetAppliedEntries("Cust. Ledger Entry", CusLedEntryApp);
                ValFormat := '';
                IF PayTermCode.GET(CusRec."Payment Terms Code") THEN
                    ValFormat := DELCHR(FORMAT(PayTermCode."Due Date Calculation"), '=', 'D');
                Subtotal := Subtotal + "Amount (LCY)";
                IF CusLedEntryApp.COUNT = 0 THEN
                    DirectPay := TRUE
                ELSE
                    DirectPay := FALSE;
                CASE GroupBy OF
                    GroupBy::None:
                        BEGIN
                            GroupByNo := '';
                            GroupByName := '';
                        END;
                    GroupBy::"Sales Rep":
                        BEGIN
                            GroupByNo := CusRec."Salesperson Code";
                            GroupByName := SlsPesnRec.Name;  //ToDo
                        END;
                    GroupBy::Customer:
                        BEGIN
                            GroupByNo := CusRec."No.";
                            GroupByName := CusRec.Name;
                        END;
                    GroupBy::"Customer Group":
                        BEGIN
                            GroupByNo := CusRec."Customer Posting Group";
                            GroupByName := ''; //ToDo
                        END;
                END;

            end;

            trigger OnPreDataItem()
            begin
                IF ComRec.GET THEN;
                TxtFilter := GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(GroupBy; GroupBy)
                {
                    Caption = 'GroupBy';
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
        CusRec: Record Customer;
        CusLegEntRec: Record "Cust. Ledger Entry";
        PaymentRec: Record "Payment Terms";
        DimensionValue: Record "Dimension Value";
        ValFormat: Text[10];
        Range: Integer;
        Variance: Integer;
        ComRec: Record "Company Information";
        Subtotal: Decimal;
        Postingdate: Date;
        TemCusLedEntry: Record "Cust. Ledger Entry" temporary;
        Inx: Integer;
        CusLedEntryApp: Record "Cust. Ledger Entry";
        PayAmount: Decimal;
        DisAmount: Decimal;
        DirectPay: Boolean;
        GroupBy: Option "None","Sales Rep",Customer,"Customer Group";
        GroupByNo: Code[20];
        GroupByName: Text[120];
        TxtFilter: Text[150];
        SlsPesnRec: Record "Salesperson/Purchaser";
}

