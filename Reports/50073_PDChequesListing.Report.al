report 50073 "PD-Cheques Listing"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/PDChequesListing.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                                WHERE("Source Code" = FILTER('PD-CHQ'),
                                      "Account Type" = CONST(Customer),
                                      "Account No." = FILTER(<> ''));
            RequestFilterFields = "Posting Date", "Salespers./Purch. Code", "External Document No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";
            column(ComapanyName; CompanyInforec.Name)
            {
            }
            column(CompanyAddress; CompanyInforec.Address)
            {
            }
            column(CompanyCity; CompanyInforec.City)
            {
            }
            column(JournalBatchName_GenJournalLine; "Gen. Journal Line"."Journal Batch Name")
            {
            }
            column(JournalTemplateName_GenJournalLine; "Gen. Journal Line"."Journal Template Name")
            {
            }
            column(LineNo_GenJournalLine; "Gen. Journal Line"."Line No.")
            {
            }
            column(PDReceiptNo; "Document No.")
            {
            }
            column(BankingDate; FORMAT("Posting Date"))
            {
            }
            column(ChequeNo; "External Document No.")
            {
            }
            column(Amount; AmountPOSITIVE)
            {
            }
            column(CustomerCode; "Account No.")
            {
            }
            column(CustomerName; CusRec.Name)
            {
            }
            column(BankCode; "Region Code")
            {
            }
            column(Salesperson; "Salespers./Purch. Code")
            {
            }
            column(InvoiceNo; "Applies-to Doc. No.")
            {
            }
            column(ChequeReceivedDate; FORMAT("3rd Party Cheque"))
            {
            }
            column(DateFilter; COPYSTR(DateFilter, 13, 50))
            {
            }
            column(RunNo; RunNo)
            {
            }
            column(ChequeDate; "Posting Date")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = FIELD("Document No.");
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(OriginalAmount_CustLedgerEntry; "Cust. Ledger Entry"."Original Amount")
                {
                }
                column(SalespersonCode_CustLedgerEntry; "Cust. Ledger Entry"."Salesperson Code")
                {
                }
                column(GlobalDimension1Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 2 Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                DimentionValue.RESET;
                DimentionValue.SETRANGE(Code, "Shortcut Dimension 1 Code");
                IF DimentionValue.FINDFIRST THEN;

                IF Amount < 0 THEN BEGIN
                    AmountPOSITIVE := -1 * Amount;
                END
                ELSE
                    IF Amount > 0 THEN BEGIN
                        AmountPOSITIVE := Amount;
                    END;

                IF CusRec.GET("Account No.") THEN;

                //IF "Gen. Journal Line"."Applies-to Doc. No." > '' THEN BEGIN
                CustLedEntRec.SETFILTER("Document No.", "Gen. Journal Line"."Applies-to Doc. No.");
                CustLedEntRec.SETFILTER("Document Type", '%1', "Gen. Journal Line"."Applies-to Doc. Type");
                IF CustLedEntRec.FINDSET THEN
                    Count1 := CustLedEntRec.COUNT;
                /*END
                ELSE
                BEGIN
                  CustLedEntRec.SETFILTER("Applies-to ID" , "Gen. Journal Line"."Document No.");
                  IF CustLedEntRec.FINDSET THEN
                    Count1 := CustLedEntRec.COUNT ;
                END;*/

            end;

            trigger OnPreDataItem()
            begin
                IF CompanyInforec.GET THEN;

                DateFilter := GETFILTERS;

                RunNo := 0;
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
        CompanyInforec: Record "Company Information";
        AmountPOSITIVE: Decimal;
        DimentionValue: Record "Dimension Value";
        CusRec: Record Customer;
        DateFilter: Text[75];
        CustLedEntRec: Record "Cust. Ledger Entry";
        CustLedEntRec2: Record "Cust. Ledger Entry";
        Count1: Integer;
        Count2: Integer;
        Amt: Decimal;
        RunNo: Integer;
}

