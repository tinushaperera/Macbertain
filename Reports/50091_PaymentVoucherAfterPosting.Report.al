report 50091 "Payment Voucher- After Posting"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/PaymentVoucherAfterPosting.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Document No.";
            column(ComName; ComRec.Name)
            {
            }
            column(ComAdd1; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(VenName; "Payee Name")
            {
            }
            column(VenAdd1; VenRec.Address)
            {
            }
            column(VenAdd2; VenRec."Address 2")
            {
            }
            column(VenCity; VenRec.City)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(AccountNo; Description)
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; ABS(Amount))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(BankName; BankRec.Name)
            {
            }
            column(BankNo; BankRec."No.")
            {
            }
            column(DocDate; "Document Date")
            {
            }
            column(Numbertxt; NoText[1])
            {
            }
            column(BalDes; BalDes)
            {
            }
            column(AccCode; AccCode)
            {
            }
            column(Narration; Narration)
            {
            }
            column(BUCode; "Global Dimension 1 Code")
            {
            }
            column(OCode; "Global Dimension 2 Code")
            {
            }
            column(BankAccNo; "Bank Account No.")
            {
            }
            column(BName; BankRec.Name)
            {
            }
            column(AccNo; "Bal. Account No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                GenJnalLineRec: Record "Gen. Journal Line";
                BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                TotalAmount: Decimal;
            begin
                TotalAmount := 0;
                IF BankRec.GET("Bank Account No.") THEN;
                IF "Bal. Account Type" = "Bal. Account Type"::Vendor THEN
                    VenRec.GET("Bal. Account No.");

                BankAccountLedgerEntry.RESET;
                BankAccountLedgerEntry.SETRANGE("Document No.", "Document No.");
                IF BankAccountLedgerEntry.FINDFIRST THEN
                    BankAccountLedgerEntry.CALCSUMS(BankAccountLedgerEntry.Amount);
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoText, ABS(BankAccountLedgerEntry.Amount), 'Only');
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
        VenRec: Record Vendor;
        BankRec: Record "Bank Account";
        CheckReport: Report Check;
        AmtTxt: Decimal;
        NoText: array[2] of Text[100];
        GLacc: Record "G/L Account";
        BalDes: Text[100];
        AccCode: Code[20];
        DimRec1: Record "Dimension Value";
        DimRec: Record "Dimension Value";
        DimCode2: Code[10];
        DimCode1: Code[10];
}

