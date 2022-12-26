report 50042 "Customer-Order Detail With Qty"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CustomerOrderDetailWithQty.rdl';
    Caption = 'Customer - Order Detail';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Priority;
            column(ShipmentPeriodDate; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(CustTableCapCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(SalesOrderLineFilter; STRSUBSTNO(Text001, SalesLineFilter))
            {
            }
            column(SalesLineFilter; SalesLineFilter)
            {
            }
            column(No_Customer; "No.")
            {
                IncludeCaption = true;
            }
            column(Name_Customer; Name)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(CustOrderDetailCaption; CustOrderDetailCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(AllAmtAreInLCYCaption; AllAmtAreInLCYCaptionLbl)
            {
            }
            column(ShipmentDateCaption; ShipmentDateCaptionLbl)
            {
            }
            column(QtyOnBackOrderCaption; QtyOnBackOrderCaptionLbl)
            {
            }
            column(OutstandingOrdersCaption; OutstandingOrdersCaptionLbl)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Bill-to Customer No." = FIELD("No."),
                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Document Type", "Bill-to Customer No.", "Currency Code")
                                    WHERE("Document Type" = CONST(Order),
                                          "Outstanding Quantity" = FILTER(<> 0));
                RequestFilterFields = "Shipment Date", Status;
                RequestFilterHeading = 'Sales Order Line';
                column(SalesHeaderNo; SalesHeader."No.")
                {
                }
                column(SalesHeaderOrderDate; SalesHeader."Order Date")
                {
                }
                column(Description_SalesLine; Description)
                {
                    IncludeCaption = true;
                }
                column(No_SalesLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(Type_SalesLine; Type)
                {
                    IncludeCaption = true;
                }
                column(ShipmentDate_SalesLine; FORMAT("Shipment Date"))
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                    IncludeCaption = true;
                }
                column(OutStandingQty_SalesLine; "Outstanding Quantity")
                {
                    IncludeCaption = true;
                }
                column(BackOrderQty; BackOrderQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                    IncludeCaption = true;
                }
                column(LineDiscAmt_SalesLine; "Line Discount Amount")
                {
                    IncludeCaption = true;
                }
                column(InvDiscAmt_SalesLine; "Inv. Discount Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                    IncludeCaption = true;
                }
                column(SalesOrderAmount; SalesOrderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(SalesHeaderCurrCode; SalesHeader."Currency Code")
                {
                }
                column(Inv; ItemRec.Inventory)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    NewOrder := "Document No." <> SalesHeader."No.";
                    IF NewOrder THEN
                        SalesHeader.GET(1, "Document No.");
                    IF "Shipment Date" <= WORKDATE THEN
                        BackOrderQty := "Outstanding Quantity"
                    ELSE
                        BackOrderQty := 0;
                    Currency.InitRoundingPrecision;
                    IF "VAT Calculation Type" IN ["VAT Calculation Type"::"Normal VAT", "VAT Calculation Type"::"Reverse Charge VAT"] THEN
                        //SalesOrderAmount :=
                        //ROUND(
                        //(Amount + "VAT Base Amount" * "VAT %" / 100) * "Outstanding Quantity" / Quantity / (1 + "VAT %" / 100),
                        //Currency."Amount Rounding Precision") //RJ
                        SalesOrderAmount := ROUND((("Amount Including VAT" / Quantity) * "Outstanding Quantity"), Currency."Amount Rounding Precision") //RJ
                    ELSE
                        //SalesOrderAmount :=
                        //ROUND(
                        //"Outstanding Amount" / (1 + "VAT %" / 100),
                        //Currency."Amount Rounding Precision");
                        SalesOrderAmount := ROUND((("Amount Including VAT" / Quantity) * "Outstanding Quantity"), Currency."Amount Rounding Precision"); //RJ
                    SalesOrderAmountLCY := SalesOrderAmount;
                    IF SalesHeader."Currency Code" <> '' THEN BEGIN
                        IF SalesHeader."Currency Factor" <> 0 THEN
                            SalesOrderAmountLCY :=
                              ROUND(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                  WORKDATE, SalesHeader."Currency Code",
                                  SalesOrderAmountLCY, SalesHeader."Currency Factor"));
                        IF PrintAmountsInLCY THEN BEGIN
                            "Unit Price" :=
                              ROUND(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                  WORKDATE, SalesHeader."Currency Code",
                                  "Unit Price", SalesHeader."Currency Factor"));
                            SalesOrderAmount := SalesOrderAmountLCY;
                        END;
                    END;
                    IF SalesHeader."Prices Including VAT" THEN BEGIN
                        "Unit Price" := "Unit Price" / (1 + "VAT %" / 100);
                        "Inv. Discount Amount" := "Inv. Discount Amount" / (1 + "VAT %" / 100);
                    END;
                    "Inv. Discount Amount" := "Inv. Discount Amount" * "Outstanding Quantity" / Quantity;
                    CurrencyCode2 := SalesHeader."Currency Code";
                    IF PrintAmountsInLCY THEN
                        CurrencyCode2 := '';
                    CurrencyTotalBuffer.UpdateTotal(
                      CurrencyCode2,
                      SalesOrderAmount,
                      Counter1,
                      Counter1);
                    IF Type = "Sales Line".Type::Item THEN BEGIN
                        ItemRec.GET("Sales Line"."No.");
                        ItemRec.CALCFIELDS(Inventory);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(SalesOrderAmountLCY, SalesOrderAmount);
                end;
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(TotalAmt_CurrTotalBuff; CurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(CurrCode_CurrTotalBuff; CurrencyTotalBuffer."Currency Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        OK := CurrencyTotalBuffer.FIND('-')
                    ELSE
                        OK := CurrencyTotalBuffer.NEXT <> 0;
                    IF NOT OK THEN
                        CurrReport.BREAK;

                    CurrencyTotalBuffer2.UpdateTotal(
                      CurrencyTotalBuffer."Currency Code",
                      CurrencyTotalBuffer."Total Amount",
                      Counter1,
                      Counter1);
                end;

                trigger OnPostDataItem()
                begin
                    CurrencyTotalBuffer.DELETEALL;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS(SalesOrderAmountLCY);
            end;
        }
        dataitem(Integer2; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(TotalAmt_CurrTotalBuff2; CurrencyTotalBuffer2."Total Amount")
            {
                AutoFormatExpression = CurrencyTotalBuffer2."Currency Code";
                AutoFormatType = 1;
            }
            column(CurrCode_CurrTotalBuff2; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    OK := CurrencyTotalBuffer2.FIND('-')
                ELSE
                    OK := CurrencyTotalBuffer2.NEXT <> 0;
                IF NOT OK THEN
                    CurrReport.BREAK;
            end;

            trigger OnPostDataItem()
            begin
                CurrencyTotalBuffer2.DELETEALL;
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
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        Caption = 'Show Amounts in LCY';
                    }
                    field(NewPagePerCustomer; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        OrderNoCaption = 'Order No.';
    }

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        SalesLineFilter := "Sales Line".GETFILTERS;
        PeriodText := "Sales Line".GETFILTER("Shipment Date");
    end;

    var
        Text000: Label 'Shipment Date: %1';
        Text001: Label 'Sales Order Line: %1';
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        ItemRec: Record Item;
        CustFilter: Text;
        SalesLineFilter: Text;
        SalesOrderAmount: Decimal;
        SalesOrderAmountLCY: Decimal;
        PrintAmountsInLCY: Boolean;
        PeriodText: Text[30];
        PrintOnlyOnePerPage: Boolean;
        BackOrderQty: Decimal;
        NewOrder: Boolean;
        OK: Boolean;
        Counter1: Integer;
        CurrencyCode2: Code[10];
        PageGroupNo: Integer;
        CustOrderDetailCaptionLbl: Label 'Customer - Order Detail';
        PageCaptionLbl: Label 'Page';
        AllAmtAreInLCYCaptionLbl: Label 'All amounts are in LCY';
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        QtyOnBackOrderCaptionLbl: Label 'Quantity on Back Order';
        OutstandingOrdersCaptionLbl: Label 'Outstanding Orders';
        TotalCaptionLbl: Label 'Total';


    procedure InitializeRequest(ShowAmountInLCY: Boolean; NewPagePerCustomer: Boolean)
    begin
        PrintAmountsInLCY := ShowAmountInLCY;
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;
}

