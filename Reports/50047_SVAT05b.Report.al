report 50047 "SVAT-05b"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SVAT05b.rdl';
    EnableExternalImages = false;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "Posting Date", "Sell-to Customer No.";
            column(name; UPPERCASE(ComRec.Name))
            {
            }
            column(SvatP; ComRec."SVAT Pecerntage(%)")
            {
            }
            column(CusName; "Sell-to Customer Name")
            {
            }
            column(CusNo; "Sell-to Customer No.")
            {
            }
            column(no; "No.")
            {
            }
            column(number; SerNo)
            {
            }
            column(InvNo; "Applies-to Doc. No.")
            {
            }
            column(posting_date; "Posting Date")
            {
            }
            column(amounts; "Amount Including VAT")
            {
            }
            column(ExchangeRate; ExchangeRate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF TaxArea.GET("Tax Area Code") THEN
                    IF NOT TaxArea."SVAT No. Mandotory" THEN
                        CurrReport.SKIP;
                IF CusNo <> "Sell-to Customer No." THEN BEGIN
                    CusNo := "Sell-to Customer No.";
                    SerNo := 0;
                END;
                SerNo := SerNo + 1;

                IF "Currency Code" <> '' THEN
                    ExchangeRate := 1 / "Currency Factor"
                ELSE
                    ExchangeRate := 1;
            end;

            trigger OnPreDataItem()
            begin
                IF ComRec.GET THEN;
                SerNo := 0;
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
        SalesInvoiceLine: Record "Sales Invoice Header";
        TaxArea: Record "Tax Area";
        SerNo: Integer;
        ExchangeRate: Decimal;
        CusNo: Code[20];
}

