report 50074 "SVAT-04"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SVAT04.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("Sell-to Customer No.");
            PrintOnlyIfDetail = false;
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
            column(cus_name; CusRec.Name)
            {
            }
            column(cus_svat; CusRec."SVAT Registration No.")
            {
            }
            column(cus_vat; CusRec."VAT Registration No.")
            {
            }
            column(cus_address; CusRec.Address)
            {
            }
            column(cus_email; CusRec."E-Mail")
            {
            }
            column(cus_address2; CusRec."Address 2")
            {
            }
            column(cus_city; CusRec.City)
            {
            }
            column(cus_fax; CusRec."Fax No.")
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
            column(NumCredit; NumCredit)
            {
            }
            column(CName; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(TaxAreaCode; "Sales Invoice Header"."Tax Area Code")
            {
            }
            column(CreditNAmt; TotCreditAmt)
            {
            }
            column(ExchangeRate; ExchangeRate)
            {
            }
            dataitem("Tax Area"; "Tax Area")
            {
                DataItemLink = Code = FIELD("Tax Area Code");
                DataItemTableView = WHERE("SVAT No. Mandotory" = CONST(true));
                column(SVATMandotory; "Tax Area"."SVAT No. Mandotory")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                TaxArea: Record "Tax Area";
            begin
                Inx := Inx + 1;
                IF Inx = 1 THEN
                    SaleInvHed.COPY("Sales Invoice Header");
                IF SellCusNo <> "Sell-to Customer No." THEN BEGIN
                    SellCusNo := "Sell-to Customer No.";
                    CusRec.GET(SellCusNo);
                    GetDetails(SellCusNo);
                END
                ELSE
                    CurrReport.SKIP;
                IF TaxArea.GET("Tax Area Code") THEN
                    IF NOT TaxArea."SVAT No. Mandotory" THEN
                        CurrReport.SKIP;

                IF "Currency Code" <> '' THEN
                    ExchangeRate := 1 / "Currency Factor"
                ELSE
                    ExchangeRate := 1;
            end;

            trigger OnPreDataItem()
            var
                Text000: Label 'Customer No. Can''t be blank.';
            begin
                "Starting Date" := GETRANGEMIN("Posting Date");
                "Ending Date" := GETRANGEMAX("Posting Date");
                ComRec.GET;
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
        "Starting Date": Date;
        "Ending Date": Date;
        AmtwithVAT: Decimal;
        CreditRec: Record "Sales Cr.Memo Line";
        CreditwithVAT: Decimal;
        CurrencyFactor: Decimal;
        RupeeExRate: Decimal;
        CurrencyCode: Text[10];
        CurrExchRate: Record "Currency Exchange Rate";
        NumInv: Integer;
        NumCredit: Integer;
        TotAmt: Decimal;
        SVATAmt: Decimal;
        TotCreditAmt: Decimal;
        ExchangeRate: Decimal;
        SellCusNo: Code[20];
        Inx: Integer;


    procedure GetDetails(CusNo: Code[20])
    begin
        TotAmt := 0;
        SVATAmt := 0;
        NumInv := 0;
        NumCredit := 0;

        SaleInvHed.SETRANGE("Sell-to Customer No.", CusNo);
        SaleInvHed.FINDSET;
        REPEAT
            SaleInvHed.CALCFIELDS(SaleInvHed."Amount Including VAT");
            TotAmt := TotAmt + SaleInvHed."Amount Including VAT";
            SVATAmt := SVATAmt + (SaleInvHed."Amount Including VAT" * ComRec."SVAT Pecerntage(%)") / 100;
            NumInv := NumInv + 1;
        UNTIL SaleInvHed.NEXT = 0;
        TotCreditAmt := 0;
        SalesCrMemoHeader.RESET;
        SalesCrMemoHeader.SETRANGE("Sell-to Customer No.", CusNo);
        IF SalesCrMemoHeader.FINDFIRST THEN
            REPEAT
                NumCredit := NumCredit + 1;
            UNTIL SalesCrMemoHeader.NEXT = 0;
        SalesCrMemoHeader.CALCFIELDS(SalesCrMemoHeader."Amount Including VAT");
        TotCreditAmt := SalesCrMemoHeader."Amount Including VAT";
    end;
}

