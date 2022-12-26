report 50012 "Finish Good Transfer Note"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/FinishGoodTransferNote.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = WHERE("Transfer Order No." = FILTER('TO*'));
            RequestFilterFields = "No.";
            column(TransfertoCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
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
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Transfer Order No." = FIELD("Transfer Order No.");
                column(ItemNo_TransferShipmentLine; "Transfer Shipment Line"."Item No.")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                {
                }
                column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                {
                }
                column(VariantCode_TransferShipmentLine; "Transfer Shipment Line"."Variant Code")
                {
                }
                column(Varient_Dec; VarientRec.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF VarientRec.GET("Item No.", "Variant Code") THEN;
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
        VarientRec: Record "Item Variant";
}

