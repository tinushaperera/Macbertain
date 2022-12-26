report 50029 "Gate Pass"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/GatePass.rdl';

    dataset
    {
        dataitem("Return Shipment Header"; "Return Shipment Header")
        {
            RequestFilterFields = "No.";
            column(No; "Return Shipment Header"."No.")
            {
            }
            column(YouRef; "Return Shipment Header"."Your Reference")
            {
            }
            column(Date; "Return Shipment Header"."Posting Date")
            {
            }
            column(Vehicle; "Return Shipment Header"."Vehicle No.")
            {
            }
            column(VendName; VendRec.Name)
            {
            }
            column(VendAdd; VendRec.Address)
            {
            }
            column(VendAdd2; VendRec."Address 2")
            {
            }
            column(Contact; VendRec.Contact)
            {
            }
            column(ComName; ComRec.Name)
            {
            }
            column(Add; ComRec.Address)
            {
            }
            column(Add2; ComRec."Address 2")
            {
            }
            column(Comc; ComRec.City)
            {
            }
            column(Rem; "Return Shipment Header".Remarks)
            {
            }
            dataitem("Return Shipment Line"; "Return Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = CONST(Item));
                column(Item; "Return Shipment Line"."No.")
                {
                }
                column(Des; "Return Shipment Line".Description)
                {
                }
                column(UOM; "Return Shipment Line"."Unit of Measure Code")
                {
                }
                column(Qty; "Return Shipment Line".Quantity)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                VendRec.GET("Buy-from Vendor No.");
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
        VendRec: Record Vendor;
}

