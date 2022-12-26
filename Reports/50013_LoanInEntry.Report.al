report 50013 "Loan In Entry"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/LoanInEntry.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
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
            column(Date; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(Loc; "Purch. Inv. Header"."Location Code")
            {
            }
            column(Vendname; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(No; "Purch. Inv. Header"."No.")
            {
            }
            column(Rem; "Purch. Inv. Header".Remarks)
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Purch. Inv. Line"."No.")
                {
                }
                column(ItemDes; "Purch. Inv. Line".Description)
                {
                }
                column(UntCst; "Purch. Inv. Line"."Unit of Measure Code")
                {
                }
                column(Qty; "Purch. Inv. Line".Quantity)
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

