report 50051 "Export Sales Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ExportSalesReport.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Region Code", "Salesperson Code";
            column(Com_Name; ComRec.Name)
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
            {
            }
            column(Amount_SalesInvoiceHeader; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(OrderDate_SalesInvoiceHeader; "Sales Invoice Header"."Order Date")
            {
            }
            column(ReportOption; ReportOption)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Quantity = FILTER(<> 0));
                column(ShortcutDimension2Code_SalesInvoiceLine; Dimvalue.Name)
                {
                }
                column(Amount_SalesInvoiceLine; "Sales Invoice Line"."Amount Including VAT")
                {
                }
                column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                {
                }
                column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Dimvalue.GET('OPERATIONS', "Sales Invoice Line"."Shortcut Dimension 2 Code") THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF CusRec.GET("Sales Invoice Header"."Sell-to Customer No.") THEN
                    IF CusRec."Gen. Bus. Posting Group" <> 'EXPORT' THEN
                        CurrReport.SKIP;

            end;

            trigger OnPreDataItem()
            begin
                ReportOption := "Sales Invoice Header".GETFILTERS;
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
        CusRec: Record Customer;
        CusRec2: Record Customer;
        Dimvalue: Record "Dimension Value";
        ReportOption: Text[250];
}

