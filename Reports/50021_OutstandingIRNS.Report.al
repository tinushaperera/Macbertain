report 50021 "Outstanding IRNS"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/OutstandingIRNS.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE(Status = CONST(Released),
                                      "Document Type" = CONST(Order));
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE(Type = CONST(Item),
                                          "Outstanding Quantity" = FILTER(<> 0));
                RequestFilterFields = "Sell-to Customer No.", "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";
                column(Com_Name; ComRec.Name)
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Line"."Amount Including VAT")
                {
                }
                column(QuantityShipped_SalesLine; "Sales Line"."Quantity Shipped")
                {
                }
                column(SelltoCustomerNo_SalesLine; "Sales Line"."Sell-to Customer No.")
                {
                }
                column(ShortcutDimension2Code_SalesLine; "Sales Line"."Shortcut Dimension 2 Code")
                {
                }
                column(Dim_Name; DimRec.Name)
                {
                }
                column(OutstandingQuantity_SalesLine; "Sales Line"."Outstanding Quantity")
                {
                }
                column(Item_Inventory; Itemrec.Inventory)
                {
                }
                column(Cus_Name; CusRec.Name)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF DimRec.GET('OPERATIONS', "Sales Line"."Shortcut Dimension 2 Code") THEN;
                    IF Itemrec.GET("No.") THEN
                        Itemrec.CALCFIELDS(Inventory);
                    IF CusRec.GET("Sales Line"."Sell-to Customer No.") THEN;
                end;
            }

            trigger OnPreDataItem()
            begin
                IF "Sales Header".Status <> "Sales Header".Status::Released THEN
                    CurrReport.SKIP;
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

    trigger OnInitReport()
    begin
        ComRec.GET;
    end;

    var
        CusRec: Record Customer;
        DimRec: Record "Dimension Value";
        Itemrec: Record Item;
        ComRec: Record "Company Information";
}

