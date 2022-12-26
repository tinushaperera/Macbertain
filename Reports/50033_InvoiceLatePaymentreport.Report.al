report 50033 "Invoice Late Payment report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/InvoiceLatePaymentreport.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE("Document Type" = CONST(Invoice),
                                      "Document No." = FILTER('INL*'));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "Region Code";
            column(ComName; ComRec.Name)
            {
            }
            column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(CustomerName_CustLedgerEntry; "Cust. Ledger Entry"."Customer Name")
            {
            }
            column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(OriginalAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Original Amt. (LCY)")
            {
            }
            column(DueDate_CustLedgerEntry; "Cust. Ledger Entry"."Due Date")
            {
            }
            column(RemainingAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(PaymentMethodCode_CustLedgerEntry; "Cust. Ledger Entry"."Payment Method Code")
            {
            }
            column(FilterPane; FilterPane)
            {
            }
            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                    WHERE("Entry Type" = CONST(Application));
                column(PostingDate_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Posting Date")
                {
                }
                column(AmountLCY_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Amount (LCY)")
                {
                }
                column(Balace_Due_Date; "Cust. Ledger Entry"."Posting Date" - "Detailed Cust. Ledg. Entry"."Posting Date")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                FilterPane := "Cust. Ledger Entry".GETFILTERS;
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
        FilterPane: Text[300];
}

