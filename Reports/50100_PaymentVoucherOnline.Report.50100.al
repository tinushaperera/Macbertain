report 50100 "Payment Voucher- Online"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/PaymentVoucherOnline.50100.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
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
            column(DocDate; "Gen. Journal Line"."Document Date")
            {
            }
            column(Numbertxt; NoText[1])
            {
            }
            column(BCName; BCRec.Name)
            {
            }
            column(AccCode; AccCode)
            {
            }
            column(AccType; "Gen. Journal Line"."Account Type")
            {
            }
            column(Narr; "Gen. Journal Line".Narration)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = FIELD("Document No.");
                column(DocumentNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Description; "Vendor Ledger Entry".Description)
                {
                }
                column(AmounttoApply; "Vendor Ledger Entry"."Amount to Apply")
                {
                }
                column(GlobalDimension1; "Vendor Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(VatAmt; VAT_Amt)
                {
                }
                column(NBT_Amt; NBT_Amt)
                {
                }
                dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    column("IN"; "Purch. Inv. Line"."Document No.")
                    {
                    }
                    column(Des; Discrip)
                    {
                    }
                    column(Dim2; DimRec1.Code)
                    {
                    }
                    column(Dim1; DimRec.Code)
                    {
                    }
                    column(Amt; "Purch. Inv. Line".Amount)
                    {
                    }
                    column(LineDes; "Purch. Inv. Line".Description)
                    {
                    }
                    column(AmtIncVAT; "Purch. Inv. Line"."Amount Including VAT")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        ItemRec: Record Item;
                        GLAccRec: Record "G/L Account";
                        FARec: Record "Fixed Asset";
                    begin
                        DimRec.RESET;
                        DimRec.SETRANGE(Code, "Shortcut Dimension 1 Code");
                        IF DimRec.FINDFIRST THEN
                            DimRec1.RESET;
                        DimRec1.SETRANGE(Code, "Shortcut Dimension 2 Code");
                        IF DimRec1.FINDFIRST THEN
                            IF Type = Type::Item THEN BEGIN
                                ItemRec.GET("No.");
                                Discrip := ItemRec.Description;
                            END;
                        IF Type = Type::"G/L Account" THEN BEGIN
                            GLAccRec.GET("No.");
                            Discrip := GLAccRec.Name;
                        END;
                        IF Type = Type::"Fixed Asset" THEN BEGIN
                            FARec.GET("No.");
                            Discrip := FARec.Description;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    VATEntry: Record "VAT Entry";
                    CalCompTax: Codeunit "Calculate Tax Of Company";
                begin
                    VAT_Amt := 0;
                    NBT_Amt := 0;
                    VATEntry.RESET;
                    VATEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    VATEntry.SETRANGE("Document No.", "Document No.");
                    VATEntry.SETRANGE("Bill-to/Pay-to No.", "Vendor No.");
                    VATEntry.SETRANGE("Tax Jurisdiction Code", 'NBT');
                    VATEntry.CALCSUMS(Amount);
                    NBT_Amt := VATEntry.Amount;
                    VATEntry.RESET;
                    VATEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    VATEntry.SETRANGE("Document No.", "Document No.");
                    VATEntry.SETRANGE("Bill-to/Pay-to No.", "Vendor No.");
                    VATEntry.SETRANGE("Tax Jurisdiction Code", 'VAT');
                    VATEntry.CALCSUMS(Amount);
                    VAT_Amt := VATEntry.Amount;
                end;
            }

            trigger OnAfterGetRecord()
            var
                GenJnalLineRec: Record "Gen. Journal Line";
            begin
                IF "Account Type" = "Gen. Journal Line"."Account Type"::Vendor THEN
                    VenRec.GET("Account No.");

                IF "Bal. Account Type" = "Gen. Journal Line"."Bal. Account Type"::"Bank Account" THEN
                    BankRec.GET("Gen. Journal Line"."Bal. Account No.");

                AmtTxt := "Gen. Journal Line".Amount + "Gen. Journal Line"."VAT Amount";
                //CheckReport.InitTextVariable;
                //CheckReport.FormatNoText(NoText,AmtTxt,'Only');

                BCRec.RESET;
                BCRec.SETRANGE(Code, "Shortcut Dimension 1 Code");
                IF BCRec.FINDFIRST THEN;

                IF "Account Type" = "Account Type"::"G/L Account" THEN
                    AccCode := "Account No."
                ELSE
                    AccCode := '';
                DimRec.RESET;
                DimRec.SETRANGE(Code, "Shortcut Dimension 1 Code");
                IF DimRec.FINDFIRST THEN
                    DimRec1.RESET;
                DimRec1.SETRANGE(Code, "Shortcut Dimension 2 Code");
                IF DimRec1.FINDFIRST THEN
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
        BCRec: Record "Dimension Value";
        VAT_Amt: Decimal;
        NBT_Amt: Decimal;
        AccCode: Code[20];
        DimRec: Record "Dimension Value";
        DimRec1: Record "Dimension Value";
        Discrip: Text[100];
}

