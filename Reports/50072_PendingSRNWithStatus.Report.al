report 50072 "Pending SRN With Status"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/PendingSRNWithStatus.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Return Order"));
            RequestFilterFields = "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Region Code";
            column(SelltoCustomerName_SalesHeader; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCustomerNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(AppliestoDocNo_SalesHeader; "Sales Header"."Applies-to Doc. No.")
            {
            }
            column(OrderApproved_SalesHeader; "Sales Header"."Order Approved")
            {
            }
            column(QuantityApproved_SalesHeader; "Sales Header"."Quantity Approved")
            {
            }
            column(Status_SalesHeader; "Sales Header".Status)
            {
            }
            column(Remarks_SalesHeader; "Sales Header".Remarks)
            {
            }
            column(ShortcutDimension1Code_SalesHeader; "Sales Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_SalesHeader; "Sales Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Com_Name; ComRec.Name)
            {
            }
            column(ReportFilter; ReportFilter)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE(Quantity = FILTER(<> 0));
                column(ItemCategoryCode_SalesLine; "Sales Line"."Item Category Code")
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Line"."Amount Including VAT")
                {
                }
                column(ItemCat_Des; ItemCat.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ItemCat.GET("Sales Line"."Item Category Code") THEN;
                end;
            }

            trigger OnPreDataItem()
            begin
                ReportFilter := "Sales Header".GETFILTERS;
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
        ComRec: Record "Company Information";
        ItemCat: Record "Item Category";
        ReportFilter: Text[250];
}

