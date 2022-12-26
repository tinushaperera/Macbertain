report 50019 "Debit Note-Cheque Return"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/DebitNoteChequeReturn.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE("Debit Note" = FILTER(true));
            RequestFilterFields = "No.";
            column(DebtNo; "Sales Invoice Header"."Pre-Assigned No.")
            {
            }
            column(Date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(CusName; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(CusAdd; "Sales Invoice Header"."Sell-to Address")
            {
            }
            column(CusAdd2; "Sales Invoice Header"."Sell-to Address 2")
            {
            }
            column(CusCity; "Sales Invoice Header"."Sell-to City")
            {
            }
            column(ComName; ComRec.Name)
            {
            }
            column(RepName; SalesRep.Name)
            {
            }
            column(Amt; "Sales Invoice Header".Amount)
            {
            }
            column(AmtIncVAT; "Sales Invoice Header"."Amount Including VAT")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF SalesRep.GET("Salesperson Code") THEN;
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
        SalesRep: Record "Salesperson/Purchaser";
        ComRec: Record "Company Information";
}

