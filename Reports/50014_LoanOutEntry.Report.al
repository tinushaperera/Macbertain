report 50014 "Loan Out Entry"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/LoanOutEntry.rdl';

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = WHERE("Order Type" = FILTER(Loan));
            RequestFilterFields = "No.";
            column(ComName; ComRec.Name)
            {
            }
            column(ComAdd; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(ComCity; ComRec.City)
            {
            }
            column(ComPH; ComRec."Phone No.")
            {
            }
            column(ComFax; ComRec."Fax No.")
            {
            }
            column(ComEmail; ComRec."E-Mail")
            {
            }
            column(Date; "Purch. Cr. Memo Hdr."."Posting Date")
            {
            }
            column(Loc; "Purch. Cr. Memo Hdr."."Location Code")
            {
            }
            column(Vendname; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
            {
            }
            column(No; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(Rem; "Purch. Cr. Memo Hdr.".Remarks)
            {
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Purch. Cr. Memo Line"."No.")
                {
                }
                column(ItemDes; "Purch. Cr. Memo Line".Description)
                {
                }
                column(UntCst; "Purch. Cr. Memo Line"."Unit Cost")
                {
                }
                column(Qty; "Purch. Cr. Memo Line".Quantity)
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

