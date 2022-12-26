report 50002 "Customer - Receipt"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CustomerReceipt.rdl';
    Caption = 'Customer - Payment Receipt';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Customer No.", "Posting Date", "Currency Code")
                                WHERE("Document Type" = FILTER(Payment | Refund));
            RequestFilterFields = "Document Type";
            column(EntryNo_CustLedgEntry; "Entry No.")
            {
            }
            column(Amount; (-1) * "Original Amount")
            {
            }
            column(ChequeNo; "External Document No.")
            {
            }
            column(TextAmount; TextAmount[1])
            {
            }
            column(SigBy; PrepBy)
            {
            }
            column(warningMsg; warningMsg)
            {
            }
            column(Narr; "Cust. Ledger Entry".Narration)
            {
            }
            column(Rem; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            dataitem(PageLoop; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CustomerNo_CustLedgEntry; "Cust. Ledger Entry"."Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Des; "Cust. Ledger Entry".Description)
                {
                }
                column(Dim1; DimRec.Name)
                {
                }
                column(Dim; DimRec.Code)
                {
                }
                column(DocDate_CustLedgEntry; FORMAT("Cust. Ledger Entry"."Posting Date", 0, 4))
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CompanyInfoEMail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                {
                }
                column(CompanyInfoBankName; CompanyInfo."Bank Name")
                {
                }
                column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                {
                }
                column(ReportTitle; ReportTitle)
                {
                }
                column(DocumentNo_CustLedgEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(PaymentDiscountTitle; PaymentDiscountTitle)
                {
                }
                column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                {
                }
                column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                {
                }
                column(CompanyInfoBankNameCptn; CompanyInfoBankNameCptnLbl)
                {
                }
                column(CompanyInfoBankAccNoCptn; CompanyInfoBankAccNoCptnLbl)
                {
                }
                column(ReceiptNoCaption; ReceiptNoCaptionLbl)
                {
                }
                column(CompanyInfoVATRegNoCptn; CompanyInfoVATRegNoCptnLbl)
                {
                }
                column(CustLedgEntry1PostDtCptn; CustLedgEntry1PostDtCptnLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(PaymAmtSpecificationCptn; PaymAmtSpecificationCptnLbl)
                {
                }
                column(PmtTolInvCurrCaption; PmtTolInvCurrCaptionLbl)
                {
                }
                column(DocumentDateCaption; DocumentDateCaptionLbl)
                {
                }
                column(CompanyInfoEMailCaption; CompanyInfoEMailCaptionLbl)
                {
                }
                column(CompanyInfoHomePageCptn; CompanyInfoHomePageCptnLbl)
                {
                }
                dataitem(DetailedCustLedgEntry1; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Applied Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemTableView = SORTING("Applied Cust. Ledger Entry No.", "Entry Type")
                                        WHERE(Unapplied = CONST(false));
                    dataitem(CustLedgEntry1; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Cust. Ledger Entry No.");
                        DataItemLinkReference = DetailedCustLedgEntry1;
                        DataItemTableView = SORTING("Entry No.");
                        column(PostDate_CustLedgEntry1; FORMAT("Document Date"))
                        {
                        }
                        column(DocType_CustLedgEntry1; "Document Type")
                        {
                            IncludeCaption = true;
                        }
                        column(DocumentNo_CustLedgEntry1; "Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Desc_CustLedgEntry1; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(CurrCode_CustLedgEntry1; CurrencyCode("Currency Code"))
                        {
                        }
                        column(ShowAmount; ShowAmount)
                        {
                        }
                        column(PmtDiscInvCurr; PmtDiscInvCurr)
                        {
                        }
                        column(PmtTolInvCurr; PmtTolInvCurr)
                        {
                        }
                        column(CurrencyCodeCaption; FIELDCAPTION("Currency Code"))
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Entry No." = "Cust. Ledger Entry"."Entry No." THEN
                                CurrReport.SKIP;

                            PmtDiscInvCurr := 0;
                            PmtTolInvCurr := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            ShowAmount := -DetailedCustLedgEntry1.Amount;

                            IF "Cust. Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                                AppliedAmount :=
                                  ROUND(
                                    -DetailedCustLedgEntry1.Amount / "Original Currency Factor" *
                                    "Cust. Ledger Entry"."Original Currency Factor", Currency."Amount Rounding Precision");
                            END ELSE BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                AppliedAmount := -DetailedCustLedgEntry1.Amount;
                            END;

                            PmtDiscPmtCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");

                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem(DetailedCustLedgEntry2; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE(Unapplied = CONST(false));
                    dataitem(CustLedgEntry2; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Applied Cust. Ledger Entry No.");
                        DataItemLinkReference = DetailedCustLedgEntry2;
                        DataItemTableView = SORTING("Entry No.");
                        column(AppliedAmount; AppliedAmount)
                        {
                        }
                        column(Desc_CustLedgEntry2; Description)
                        {
                        }
                        column(DocumentNo_CustLedgEntry2; "Document No.")
                        {
                        }
                        column(DocType_CustLedgEntry2; "Document Type")
                        {
                        }
                        column(PostDate_CustLedgEntry2; FORMAT("Posting Date"))
                        {
                        }
                        column(PmtDiscInvCurr1; PmtDiscInvCurr)
                        {
                        }
                        column(PmtTolInvCurr1; PmtTolInvCurr)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Entry No." = "Cust. Ledger Entry"."Entry No." THEN
                                CurrReport.SKIP;

                            PmtDiscInvCurr := 0;
                            PmtTolInvCurr := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            ShowAmount := DetailedCustLedgEntry2.Amount;

                            IF "Cust. Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                            END ELSE BEGIN
                                PmtDiscInvCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                PmtTolInvCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            END;

                            PmtDiscPmtCurr := ROUND("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");

                            AppliedAmount := DetailedCustLedgEntry2.Amount;
                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem(Total; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(RemainingAmount; RemainingAmount)
                    {
                    }
                    column(CurrCode_CustLedgEntry; CurrencyCode("Cust. Ledger Entry"."Currency Code"))
                    {
                    }
                    column(OriginalAmt_CustLedgEntry; "Cust. Ledger Entry"."Original Amount")
                    {
                    }
                    column(ExtDocNo_CustLedgEntry; "Cust. Ledger Entry"."External Document No.")
                    {
                    }
                    column(PaymAmtNotAllocatedCptn; PaymAmtNotAllocatedCptnLbl)
                    {
                    }
                    column(CustLedgEntryOrgAmtCptn; CustLedgEntryOrgAmtCptnLbl)
                    {
                    }
                    column(ExternalDocumentNoCaption; ExternalDocumentNoCaptionLbl)
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                Cust.GET("Customer No.");
                FormatAddr.Customer(CustAddr, Cust);
                CALCFIELDS("Remaining Amount");

                IF NOT Currency.GET("Currency Code") THEN
                    Currency.InitRoundingPrecision;

                IF "Document Type" = "Document Type"::Payment THEN BEGIN
                    ReportTitle := Text003;
                    PaymentDiscountTitle := Text006;
                END ELSE BEGIN
                    ReportTitle := Text004;
                    PaymentDiscountTitle := Text007;
                END;

                CALCFIELDS("Original Amount");
                RemainingAmount := -"Original Amount";

                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(TextAmount, (-1) * "Original Amount", '');

                PrepBy := COPYSTR("Cust. Ledger Entry"."User ID", (STRPOS("Cust. Ledger Entry"."User ID", '\') + 1), STRLEN("Cust. Ledger Entry"."User ID"));  //<Chin >

                IF RemainingAmount >= 25000 THEN
                    warningMsg := 'It is hereby certified that the Stamp Duty of Rs.25/- has been compunded to CGIR'
                ELSE
                    warningMsg := ' ';

                DimRec.RESET;
                DimRec.SETRANGE(Code, "Global Dimension 1 Code");
                IF DimRec.FINDFIRST THEN;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                GLSetup.GET;
                "Cust. Ledger Entry".CALCFIELDS("Remaining Amount");
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
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        Currency: Record Currency;
        DimRec: Record "Dimension Value";
        FormatAddr: Codeunit "Format Address";
        ReportTitle: Text[30];
        PaymentDiscountTitle: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        RemainingAmount: Decimal;
        AppliedAmount: Decimal;
        PmtDiscInvCurr: Decimal;
        PmtTolInvCurr: Decimal;
        PmtDiscPmtCurr: Decimal;
        Text003: Label 'Payment Receipt';
        Text004: Label 'Payment Voucher';
        Text006: Label 'Pmt. Disc. Given';
        Text007: Label 'Pmt. Disc. Rcvd.';
        PmtTolPmtCurr: Decimal;
        ShowAmount: Decimal;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCptnLbl: Label 'Bank';
        CompanyInfoBankAccNoCptnLbl: Label 'Account No.';
        ReceiptNoCaptionLbl: Label 'Receipt No.';
        CompanyInfoVATRegNoCptnLbl: Label 'GST Reg. No.';
        CustLedgEntry1PostDtCptnLbl: Label 'Posting Date';
        AmountCaptionLbl: Label 'Amount';
        PaymAmtSpecificationCptnLbl: Label 'Payment Amount Specification';
        PmtTolInvCurrCaptionLbl: Label 'Pmt Tol.';
        DocumentDateCaptionLbl: Label 'Document Date';
        CompanyInfoEMailCaptionLbl: Label 'E-Mail';
        CompanyInfoHomePageCptnLbl: Label 'Home Page';
        PaymAmtNotAllocatedCptnLbl: Label 'Payment Amount Not Allocated';
        CustLedgEntryOrgAmtCptnLbl: Label 'Payment Amount';
        ExternalDocumentNoCaptionLbl: Label 'External Document No.';
        CheckReport: Report Check;
        TextAmount: array[2] of Text;
        PrepBy: Text[50];
        warningMsg: Text[100];

    local procedure CurrencyCode(SrcCurrCode: Code[10]): Code[10]
    begin
        IF SrcCurrCode = '' THEN
            EXIT(GLSetup."LCY Code");
        EXIT(SrcCurrCode);
    end;
}

