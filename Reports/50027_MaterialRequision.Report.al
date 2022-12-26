report 50027 "Material Requision"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/MaterialRequision.rdl';

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = WHERE(MRN = FILTER(true));//ask from pW
            RequestFilterFields = "No.";
            column(ComName; ComRec.Name)
            {
            }
            column(MRN_No; "Transfer Header"."No.")
            {
            }
            column(Date; "Transfer Header"."Posting Date")
            {
            }
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Transfer Line"."Item No.")
                {
                }
                column(ItemDes; "Transfer Line".Description)
                {
                }
                column(Qty; "Transfer Line".Quantity)
                {
                }
                column(QtyShiped; "Transfer Line"."Quantity Shipped")
                {
                }
            }

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
}

