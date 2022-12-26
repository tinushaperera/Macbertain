report 50030 "Sales Return Advise Note"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SalesReturnAdviseNote.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER("Return Order"));
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
            column(CusName; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(CusAdd; CusRec.Address)
            {
            }
            column(CusCity; CusRec.City)
            {
            }
            column(CusCont; CusRec.Contact)
            {
            }
            column(CusPhnNo; CusRec."Phone No.")
            {
            }
            column(SP; CusRec."Salesperson Code")
            {
            }
            column(CustomerNo; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(No; "Sales Header"."No.")
            {
            }
            column(PoDate; "Sales Header"."Posting Date")
            {
            }
            column(CretUser; "Sales Header"."Create User ID")
            {
            }
            column(Inv; "Sales Header"."Applies-to Doc. No.")
            {
            }
            column(OrderApproved_SalesHeader; "Sales Header"."Order Approved")
            {
            }
            column(Qty_Apprved; "Sales Header"."Quantity Approved")
            {
            }
            column(ApprovedDateTime_SalesHeader; "Sales Header"."Approved Date & Time")
            {
            }
            column(QuantityApprovedDateTime_SalesHeader; "Sales Header"."Quantity Approved Date & Time")
            {
            }
            column(SalespersonPhnNo; Salesperson."Phone No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER(Item));
                column(ItemNo; "Sales Line"."No.")
                {
                }
                column(ItemDes; "Sales Line".Description)
                {
                }
                column(QtyInv; "Sales Line"."Qty. to Invoice")
                {
                }
                column(Qty; "Sales Line".Quantity)
                {
                }
                column(ReservedQty; "Sales Line"."Qty. Received")
                {
                }
                column(QTC; "Sales Line"."Quantity Received By Stores")
                {
                }
                column(Remark; "Sales Line"."Return Reason Remarks")
                {
                }
                column(Reson; "Sales Line"."Return Reason Code")
                {
                }
                column(QC; "Sales Line"."Return Qty. to Receive")
                {
                }
                column(ReturnReson; "Sales Line"."Return Reason Remarks")
                {
                }
                column(RetDes; ReturnReson.Description)
                {
                }
                column(Remarks; "Sales Line".Remarks)
                {
                }
                column(VariantCode; "Sales Line"."Variant Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ReturnReson.GET("Return Reason Code") THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF CusRec.GET("Sell-to Customer No.") THEN;
                IF Salesperson.GET("Salesperson Code") THEN;
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
        CusRec: Record Customer;
        ReturnReson: Record "Return Reason";
        Salesperson: Record "Salesperson/Purchaser";
}

