report 50088 "Payment Voucher-New"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/PaymentVoucherNew.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
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
            column(VenName; "Gen. Journal Line"."Payee Name")
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
            column(DocumentNo_GenJournalLine; "Gen. Journal Line"."Document No.")
            {
            }
            column(PostingDate_GenJournalLine; "Gen. Journal Line"."Posting Date")
            {
            }
            column(MessagetoRecipient_GenJournalLine; "Gen. Journal Line"."Message to Recipient")
            {
            }
            column(AccountNo_GenJournalLine; "Gen. Journal Line".Description)
            {
            }
            column(Description_GenJournalLine; "Gen. Journal Line".Description)
            {
            }
            column(Amount_GenJournalLine; "Gen. Journal Line".Amount)
            {
            }
            column(ExternalDocumentNo_GenJournalLine; "Gen. Journal Line"."External Document No.")
            {
            }
            column(BankName; BankRec.Name)
            {
            }
            column(BankNo; BankRec."No.")
            {
            }
            column(VatAmt; "Gen. Journal Line"."VAT Amount")
            {
            }
            column(DocDate; "Gen. Journal Line"."Document Date")
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
            column(AccType; "Gen. Journal Line"."Account Type")
            {
            }
            column(Dim2; DimCode1)
            {
            }
            column(Dim1; DimCode2)
            {
            }
            column(AccNo; "Gen. Journal Line"."Account No.")
            {
            }
            column(Narration; "Gen. Journal Line".Narration)
            {
            }

            trigger OnAfterGetRecord()
            var
                GenJnalLineRec: Record "Gen. Journal Line";
            begin
                IF "Account Type" = "Account Type"::Vendor THEN
                    VenRec.GET("Account No.");

                IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
                    BankRec.GET("Bal. Account No.");
                    BalDes := BankRec.Name;
                END
                ELSE
                    IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN BEGIN
                        GLacc.GET("Bal. Account No.");
                        BalDes := GLacc.Name;
                    END
                    ELSE
                        BalDes := '';

                IF "Account Type" = "Account Type"::"G/L Account" THEN
                    AccCode := "Account No."
                ELSE
                    AccCode := '';
                AmtTxt := Amount + "VAT Amount";
                //CheckReport.InitTextVariable;
                //CheckReport.FormatNoText(NoText,AmtTxt,'Only');

                DimRec.RESET;
                DimRec.SETRANGE(Code, "Shortcut Dimension 1 Code");
                IF DimRec.FINDFIRST THEN
                    DimCode2 := DimRec.Code
                ELSE
                    DimCode2 := DimRec.Code;

                DimRec1.RESET;
                DimRec1.SETRANGE(Code, "Shortcut Dimension 2 Code");
                IF DimRec1.FINDFIRST THEN
                    DimCode1 := DimRec1.Code
                ELSE
                    DimCode1 := '';

                GenJnalLineRec.RESET;
                GenJnalLineRec.SETRANGE(GenJnalLineRec."Journal Template Name", "Journal Template Name");
                GenJnalLineRec.SETRANGE(GenJnalLineRec."Journal Batch Name", "Journal Batch Name");
                GenJnalLineRec.SETRANGE(GenJnalLineRec."Document No.", "Document No.");
                IF GenJnalLineRec.FINDSET THEN
                    GenJnalLineRec.CALCSUMS(Amount);
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoText, ABS(GenJnalLineRec.Amount), 'Only');
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

