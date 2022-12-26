report 50053 "Debit Note"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/DebitNote.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(Cus_No; CusRec."No.")
            {
            }
            column(Cus_Name; CusRec.Name)
            {
            }
            column(Cus_Add1; CusRec.Address)
            {
            }
            column(Cus_Add2; CusRec."Address 2")
            {
            }
            column(Cus_City; CusRec.City)
            {
            }
            column(Posting_Date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(Com_Name; ComInfo.Name)
            {
            }
            column(Com_Address; ComInfo.Address)
            {
            }
            column(Com_City; ComInfo.City)
            {
            }
            column(Com_Tell; ComInfo."Phone No.")
            {
            }
            column(Com_Fax; ComInfo."Fax No.")
            {
            }
            column(Com_Web; ComInfo."Home Page")
            {
            }
            column(Vat_No; ComInfo."VAT Registration No.")
            {
            }
            column(Posting_Description; "Sales Invoice Header"."Posting Description")
            {
            }
            column(No; "Sales Invoice Header"."No.")
            {
            }
            column(Vat_Amount; VatAmt)
            {
            }
            column(Amount_Non_Vat; "Sales Invoice Header".Amount)
            {
            }
            column(AomuntVAT; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(Doc_Date; "Sales Invoice Header"."Document Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF CusRec.GET("Sell-to Customer No.") THEN;

                VatAmt := "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount
            end;

            trigger OnPreDataItem()
            begin
                IF ComInfo.GET THEN;
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
        ComInfo: Record "Company Information";
        CusRec: Record Customer;
        CusLegEntRec: Record "Cust. Ledger Entry";
        VatAmt: Decimal;
}

