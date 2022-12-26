report 50016 "Finish Good Transfer Receipt"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/FinishGoodTransferReceipt.rdl';

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            DataItemTableView = WHERE("No." = FILTER('TR*'));
            RequestFilterFields = "No.";
            column(TransfertoCode_TransferShipmentHeader; "Transfer Receipt Header"."Transfer-to Code")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Receipt Header"."Posting Date")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Receipt Header"."Transfer Order No.")
            {
            }
            column(ComName; ComRec.Name)
            {
            }
            column(ComAdd; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(ComPhnNo; ComRec."Phone No.")
            {
            }
            column(ComFaxNo; ComRec."Fax No.")
            {
            }
            column(ComEmail; ComRec."E-Mail")
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Transfer Order No." = FIELD("Transfer Order No.");
                column(ItemNo_TransferShipmentLine; "Transfer Receipt Line"."Item No.")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Receipt Line".Description)
                {
                }
                column(UnitofMeasure_TransferShipmentLine; "Transfer Receipt Line"."Unit of Measure Code")
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Receipt Line".Quantity)
                {
                }
                column(VarCode; "Transfer Receipt Line"."Variant Code")
                {
                }
                column(VarDes; ItemVarent.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ItemVarent.GET("Item No.", "Variant Code") THEN;
                end;
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
        ItemVarent: Record "Item Variant";
}

