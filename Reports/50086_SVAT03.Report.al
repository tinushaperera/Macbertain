report 50086 "SVAT-03"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SVAT03.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("Sell-to Customer No.");
            RequestFilterFields = "Posting Date", "Sell-to Customer No.";
            column(Svat_reg; ComRec."SVAT No.")
            {
            }
            column(vat_reg; ComRec."VAT Registration No.")
            {
            }
            column(com_name; ComRec.Name)
            {
            }
            column(com_address; ComRec.Address)
            {
            }
            column(com_address2; ComRec."Address 2")
            {
            }
            column(com_city; ComRec.City)
            {
            }
            column(com_fax; ComRec."Fax No.")
            {
            }
            column(com_email; ComRec."E-Mail")
            {
            }
            column(SVAT; ComRec."SVAT Pecerntage(%)")
            {
            }
            column(Starting_date; "Starting Date")
            {
            }
            column(Ending_date; "Ending Date")
            {
            }
            column(amount; TotAmt)
            {
            }
            column(SVATAmount; SVATAmt)
            {
            }
            column(InvNum; NumInv)
            {
            }
            column(CName; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(TaxAreaCode; "Sales Invoice Header"."Tax Area Code")
            {
            }
            column(AmtInVAT; "Amount Including VAT")
            {
            }
            column(TotSVAT; TotSVAT)
            {
            }
            column(TotZero; TotZero)
            {
            }
            column(ExchangeRate; ExchangeRate)
            {
            }
            column(TotAmt; TotAmt)
            {
            }
            column(SupplyAmt; SupplyAmt)
            {
            }
            column(ExcemptAmt; ExcemptAmt)
            {
            }

            trigger OnAfterGetRecord()
            var
                TaxArea: Record "Tax Area";
                SalesInvoiceLine: Record "Sales Invoice Line";
            begin
                SupplyAmt := 0;
                VATEntry.SETRANGE(Type, VATEntry.Type::Sale);
                VATEntry.SETRANGE("Tax Jurisdiction Code", 'VAT');
                VATEntry.SETRANGE("Posting Date", "Starting Date", "Ending Date");
                IF VATEntry.FINDSET THEN
                    REPEAT
                        SupplyAmt := SupplyAmt + VATEntry.Base;
                    UNTIL VATEntry.NEXT = 0;

                ExcemptAmt := 0;
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Document No.", "No.");
                IF SalesInvoiceLine.FINDFIRST THEN
                    REPEAT
                        IF SalesInvoiceLine."Gen. Prod. Posting Group" = 'TR-FERTI' THEN
                            ExcemptAmt := ExcemptAmt + SalesInvoiceLine."Amount Including VAT";
                    UNTIL SalesInvoiceLine.NEXT = 0;

                CALCFIELDS("Amount Including VAT");
                TotSVAT := 0;
                TotZero := 0;
                AmtInVAT := 0;
                IF "Currency Code" <> '' THEN
                    ExchangeRate := 1 / "Currency Factor"
                ELSE
                    ExchangeRate := 1;

                IF TaxArea.GET("Tax Area Code") THEN
                    IF TaxArea."SVAT No. Mandotory" THEN
                        TotSVAT := "Amount Including VAT" * ExchangeRate;
                IF "Tax Area Code" = 'ZERO RATE' THEN
                    TotZero := "Amount Including VAT" * ExchangeRate;
                /*IF "Tax Area Code" = 'NBT EX/VAT EX' THEN
                    TotExcempted := "Amount Including VAT" * ExchangeRate;*/

            end;

            trigger OnPreDataItem()
            var
                Text000: Label 'Customer No. Can''t be blank.';
            begin
                "Starting Date" := GETRANGEMIN("Posting Date");
                "Ending Date" := GETRANGEMAX("Posting Date");
                ComRec.GET;
                VATEntry.RESET;
                VATEntry.SETCURRENTKEY(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date");
            end;
        }
        dataitem(DataItem10; "Sales Cr.Memo Header")
        {
            column(TotCreditAmt; TotCreditAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Amount Including VAT");
                IF "Currency Code" <> '' THEN
                    ExchangeRate2 := 1 / "Currency Factor"
                ELSE
                    ExchangeRate2 := 1;
                TotCreditAmt := "Amount Including VAT" * ExchangeRate2;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", "Starting Date", "Ending Date");
                SETFILTER("Tax Area Code", 'SVAT*');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ComRec: Record "Company Information";
        CusRec: Record Customer;
        SalesRec: Record "Sales Invoice Header";
        SaleInvHed: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
        CurrExchRate: Record "Currency Exchange Rate";
        VATEntry: Record "VAT Entry";
        "Starting Date": Date;
        "Ending Date": Date;
        AmtwithVAT: Decimal;
        CreditwithVAT: Decimal;
        CurrencyFactor: Decimal;
        RupeeExRate: Decimal;
        CurrencyCode: Text[10];
        NumInv: Integer;
        NumCredit: Integer;
        TotAmt: Decimal;
        SVATAmt: Decimal;
        SellCusNo: Code[20];
        Inx: Integer;
        TotSVAT: Decimal;
        TotZero: Decimal;
        TotExcempted: Decimal;
        AmtInVAT: Decimal;
        ExchangeRate: Decimal;
        ExchangeRate2: Decimal;
        TotCreditAmt: Decimal;
        SupplyAmt: Decimal;
        ExcemptAmt: Decimal;
}

