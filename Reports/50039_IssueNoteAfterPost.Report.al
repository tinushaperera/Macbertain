report 50039 "Issue Note After Post"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/IssueNoteAfterPost.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            column(ComName; ComRec.Name)
            {
            }
            column(ComAdd; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(Date; "Transfer Shipment Header"."Posting Date")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Item; "Transfer Shipment Line"."Item No.")
                {
                }
                column(Des; "Transfer Shipment Line".Description)
                {
                }
                column(Qty; "Transfer Shipment Line".Quantity)
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

