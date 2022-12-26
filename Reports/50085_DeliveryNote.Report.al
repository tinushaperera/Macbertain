report 50085 "Delivery Note"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/DeliveryNote.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Invoice Despatch No.";
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemLink = "Invoice Despatch No." = FIELD("Invoice Despatch No."),
                               "Order No." = FIELD("Order No.");
                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    column(ShipItemNo; "Sales Shipment Line"."No.")
                    {
                    }
                    column(ShipItemDes; "Sales Shipment Line".Description)
                    {
                    }
                    column(ShipItemDes2; "Sales Shipment Line"."Description 2")
                    {
                    }
                    column(ShipUOM; "Sales Shipment Line"."Unit of Measure Code")
                    {
                    }
                    column(ShipQty; "Sales Shipment Line".Quantity)
                    {
                    }
                    column(Doc; "Sales Shipment Line"."Document No.")
                    {
                    }
                    column(ShipCusName; SalesShipHedd."Sell-to Customer Name")
                    {
                    }
                    column(Ref; SalesShipHedd."Sell-to Customer No.")
                    {
                    }
                    column(ShipDesdate; SalesShipHedd."Document Date")
                    {
                    }
                    column(ShipLoc; SalesShipHedd."Location Code")
                    {
                    }
                    column(ShipShipNo; SalesShipHedd."No.")
                    {
                    }
                    column(ShipOrdNo; SalesShipHedd."Order No.")
                    {
                    }
                    column(ShipInvDIs; SalesShipHedd."Invoice Despatch No.")
                    {
                    }
                    column(Ship_Name; SalesShipHedd."Ship-to Name")
                    {
                    }
                    column(Ship_Addres; SalesShipHedd."Ship-to Address")
                    {
                    }
                    column(Ship_Addres_2; SalesShipHedd."Ship-to Address 2")
                    {
                    }
                    column(Ship_City; SalesShipHedd."Ship-to City")
                    {
                    }
                    column(ShipCusAdd; CusRec.Address)
                    {
                    }
                    column(ShipCusAdd2; CusRec."Address 2")
                    {
                    }
                    column(ShipCusCity; CusRec.City)
                    {
                    }
                    column(ShipComName1; ComRec.Name)
                    {
                    }
                    column(ShipComAdd1; ComRec.Address)
                    {
                    }
                    column(ShipComAdd21; ComRec."Address 2")
                    {
                    }
                    column(ShipComPhnNo1; ComRec."Phone No.")
                    {
                    }
                    column(ShipComFaxNo1; ComRec."Fax No.")
                    {
                    }
                    column(ShipComEmail1; ComRec."E-Mail")
                    {
                    }
                    column(InvDoisNo; SalesShipHedd."Invoice Despatch No.")
                    {
                    }
                    column(RepName; SaleRep.Name)
                    {
                    }
                    column(SalesRepPhoneNo; SaleRep."Phone No.")
                    {
                    }
                    column(Remarks; SalesShipHedd.Remarks)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF "Sales Shipment Line".Quantity = 0 THEN
                            CurrReport.SKIP;
                        SalesShipHedd.GET("Document No.");
                        CusRec.GET(SalesShipHedd."Sell-to Customer No.");
                    end;

                    trigger OnPreDataItem()
                    begin
                        ComRec.GET;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF SaleRep.GET(SalesShipHedd."Salesperson Code") THEN; //TL -Not sure "Sales Shipment Header" >>> SalesShipHedd
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesInvHedd: Record "Sales Invoice Header";
            begin
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
        CusRec: Record Customer;
        ComRec: Record "Company Information";
        SalesShipHedd: Record "Sales Shipment Header";
        NBTAmount: Decimal;
        VATAmount: Decimal;
        SVATAmt: Decimal;
        ExchangRete: Decimal;
        GrossTot: Decimal;
        SubTot: Decimal;
        UnitPrice: Decimal;
        AmtIncVat: Decimal;
        Caption: Text[10];
        FoterTxt: Text[100];
        SVATText: Text;
        CurrCode: Code[10];
        DisNo: Code[20];
        Dup: Text[10];
        User: Record User;
        LoopText: Code[10];
        Counter: Integer;
        LoopText1: Code[10];
        Counter1: Integer;
        SaleRep: Record "Salesperson/Purchaser";
}

