report 50076 "Inventory Availability Check"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/InventoryAvailabilityCheck.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.", Status;
            column(No; "No.")
            {
            }
            column(SellCusNo; "Sell-to Customer No.")
            {
            }
            column(SellCusName; "Sell-to Customer Name")
            {
            }
            column(OrDate; "Order Date")
            {
            }
            column(SalPer; "Salesperson Code")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order));
                column(LineNo; "Line No.")
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(Descrip; Description)
                {
                }
                column(LocCode; "Location Code")
                {
                }
                column(Qty; Quantity)
                {
                }
                column(AvQty; "Sales Line"."Available Inventory")
                {
                }
                column(AmountIncludingVAT; "Sales Line"."Amount Including VAT")
                {
                }
                column(VariantCode_SalesLine; "Sales Line"."Variant Code")
                {
                }
                column(QuantityShipped; "Sales Line"."Quantity Shipped")
                {
                }
                column(OperationCode; "Sales Line"."Shortcut Dimension 2 Code")
                {
                }
            }
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
}

