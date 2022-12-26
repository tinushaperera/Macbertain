report 50075 "SVAT-05"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SVAT05.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("Sell-to Customer No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date", "VAT Bus. Posting Group", "Sell-to Customer No.";
            column(name; ComRec.Name)
            {
            }
            column(adress; ComRec.Address)
            {
            }
            column(adress2; ComRec."Address 2")
            {
            }
            column(phone; ComRec."Phone No.")
            {
            }
            column(city; ComRec.City)
            {
            }
            column(SVAT; ComRec."SVAT Pecerntage(%)")
            {
            }
            column(no; "Sales Invoice Header"."No.")
            {
            }
            column(amounts; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(posting_date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(subtotal; Subtotal)
            {
            }
            column(number; SerNo)
            {
            }
            column(CusName; "Sell-to Customer Name")
            {
            }
            column(CusNo; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(ExchangRate; ExchangRate)
            {
            }
            dataitem("Tax Area"; "Tax Area")
            {
                DataItemLink = Code = FIELD("Tax Area Code");
                DataItemTableView = WHERE("SVAT No. Mandotory" = CONST(true));
                column(SVATMandatory; "Tax Area"."SVAT No. Mandotory")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF CusNo <> "Sales Invoice Header"."Sell-to Customer No." THEN BEGIN
                    CusNo := "Sell-to Customer No.";
                    SerNo := 0;
                END;
                SerNo := SerNo + 1;

                IF "Currency Code" <> '' THEN
                    ExchangRate := 1 / "Currency Factor"
                ELSE
                    ExchangRate := 1;
            end;

            trigger OnPreDataItem()
            begin
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
        SalesInvoiceLine: Record "Sales Invoice Header";
        Subtotal: Decimal;
        "Starting date": Date;
        "Ending Date": Date;
        SerNo: Integer;
        CusNo: Code[20];
        ExchangRate: Decimal;
}

