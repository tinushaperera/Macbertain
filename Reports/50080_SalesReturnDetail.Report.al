report 50080 "Sales Return Detail"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SalesReturnDetail.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "Sell-to Customer No.";
            column(No; "Sales Header"."No.")
            {
            }
            column(Com_Name; ComInfo.Name)
            {
            }
            column(Com_Address; ComInfo.Address)
            {
            }
            column(City; ComInfo.City)
            {
            }
            column(Tell; ComInfo."Phone No.")
            {
            }
            column(Vat_No; ComInfo."VAT Registration No.")
            {
            }
            column(Fax_No; ComInfo."Fax No.")
            {
            }
            column(ReportFilter1; ReportFilter[1])
            {
            }
            column(CustNo; "Sell-to Customer No.")
            {
            }
            column(CustName; "Sell-to Customer Name")
            {
            }
            column(PostingDate; "Sales Header"."Posting Date")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                RequestFilterFields = "Return Reason Code";
                column(ItemNo; "Sales Line"."No.")
                {
                }
                column(Quantity; "Sales Line".Quantity)
                {
                }
                column(QuantityReceivedByStores; "Sales Line"."Quantity Received By Stores")
                {
                }
                column(ReturnQtyReceived; "Sales Line"."Return Qty. Received")
                {
                }
                column(RetReasonCode; "Sales Line"."Return Reason Code")
                {
                }
                column(RetReasonRemarks; "Sales Line"."Return Reason Remarks")
                {
                }
                column(QtyInvoiced; QtyInvoiced)
                {
                }
                column(ReportFilter2; ReportFilter[2])
                {
                }
                column(QtyInvoiced2; "Sales Line"."Quantity Invoiced")
                {
                }
                column(RtnQtyToReceive; "Sales Line"."Return Qty. to Receive")
                {
                }
                dataitem(Item; Item)
                {
                    DataItemLink = "No." = FIELD("No.");
                    column(ItemDesc; Item.Description)
                    {
                    }
                    column(ReportFilter3; ReportFilter[3])
                    {
                    }
                    column(ProdType; ProdType)
                    {
                    }

                    trigger OnPreDataItem()
                    var
                        DefDimRec: Record "Default Dimension";
                    begin
                        ReportFilter[3] := Item.GETFILTERS;
                        IF DefDimRec.GET(DATABASE::Item, "No.", 'PRODUCT TYPE') THEN
                            ProdType := DefDimRec."Dimension Value Code"
                        ELSE
                            ProdType := '';
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    QtyInvoiced := 0;
                    IF "Sales Line"."Appl.-from Item Entry" > 0 THEN BEGIN
                        ItmLedRec.GET("Sales Line"."Appl.-from Item Entry");
                        QtyInvoiced := -ItmLedRec.Quantity;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    ReportFilter[2] := "Sales Line".GETFILTERS;
                end;
            }

            trigger OnPreDataItem()
            begin
                ReportFilter[1] := "Sales Header".GETFILTERS;
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
        ComInfo.GET;
    end;

    var
        ComInfo: Record "Company Information";
        ItmLedRec: Record "Item Ledger Entry";
        QtyInvoiced: Decimal;
        ReportFilter: array[3] of Text[512];
        ProdType: Text[60];
}

