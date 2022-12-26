report 50025 "Sales Return"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SalesReturn.rdl';

    dataset
    {
        dataitem("Return Receipt Header"; "Return Receipt Header")
        {
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
            column(No; "Return Receipt Header"."No.")
            {
            }
            column(Date; "Return Receipt Header"."Posting Date")
            {
            }
            column(IRN; SalesInvHedd."Order No.")
            {
            }
            column(CusName; "Return Receipt Header"."Sell-to Customer Name")
            {
            }
            column(SelltoAddress_ReturnReceiptHeader; "Return Receipt Header"."Sell-to Address")
            {
            }
            column(SelltoAddress2_ReturnReceiptHeader; "Return Receipt Header"."Sell-to Address 2")
            {
            }
            column(SelltoCity_ReturnReceiptHeader; "Return Receipt Header"."Sell-to City")
            {
            }
            column(IssueDate; "Return Receipt Header"."Document Date")
            {
            }
            column(ResonCode; ResonRec.Description)
            {
            }
            column(Inv; "Return Receipt Header"."Applies-to Doc. No.")
            {
            }
            column(remarks; "Return Receipt Header".Remarks)
            {
            }
            column(Vehicle; "Return Receipt Header"."Vehicle No.")
            {
            }
            column(InvDispatch_No; SalesShpmntHedd."No.")
            {
            }
            column(Retno; "Return Receipt Header"."Return Order No.")
            {
            }
            column(Remarks2; "Return Receipt Header"."Remarks-2")
            {
            }
            dataitem("Return Receipt Line"; "Return Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER(Item));
                column(ItemNo; "Return Receipt Line"."No.")
                {
                }
                column(ItemDes; "Return Receipt Line".Description)
                {
                }
                column(Qty; "Return Receipt Line".Quantity)
                {
                }
                column(reason; ReturnReson.Description)
                {
                }
                column(VariantCode_ReturnReceiptLine; "Return Receipt Line"."Variant Code")
                {
                }
                column(Description2_ReturnReceiptLine; "Return Receipt Line"."Description 2")
                {
                }
                column(ReturnReasonRemarks; "Return Receipt Line"."Return Reason Remarks")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ReturnReson.GET("Return Reason Code") THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ResonRec.RESET;
                ResonRec.SETRANGE(Code, "Reason Code");
                IF ResonRec.FINDFIRST THEN;
                IF SalesInvHedd.GET("Applies-to Doc. No.") THEN;


                //GJ
                SalesShpmntHedd.RESET;
                SalesShpmntHedd.SETRANGE("Invoice Despatch No.", SalesInvHedd."Invoice Despatch No.");
                IF SalesShpmntHedd.FINDFIRST THEN;
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
        ResonRec: Record "Reason Code";
        ReturnReson: Record "Return Reason";
        SalesInvHedd: Record "Sales Invoice Header";
        SalesShpmntHedd: Record "Sales Shipment Header";
}

