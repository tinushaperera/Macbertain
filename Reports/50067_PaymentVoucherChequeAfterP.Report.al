report 50067 "Payment Voucher-Cheque(AfterP)"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/PaymentVoucherChequeAfterP.rdl';

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
            column(BDocumentNo; "Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Amount; Amount)
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
            column(Narr; Narration)
            {
            }
            column(BankAccNo; "Bank Account No.")
            {
            }
            column(BName; BankRec.Name)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."),
                               "Posting Date" = FIELD("Posting Date");
                column(VDocumentNo; "Vendor Ledger Entry"."Document No.")
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
                column(Numbertxt; NoText[1])
                {
                }
                column(Payment_Detail; PurchaseLine."Description 2")
                {
                }
                column(Dim_Rec; DimRec.Name)
                {
                }

                trigger OnAfterGetRecord()
                var
                    PostdPurchaseHdr: Record "Purch. Inv. Header";
                    VATEntry: Record "VAT Entry";
                    TotalBalanceWithBalance: Decimal;
                begin
                    TotalBalanceWithBalance := 0;
                    TempPostedPurchaseLine.DELETEALL;
                    DeatailVendorLdgrEntry.RESET;
                    DeatailVendorLdgrEntry.SETRANGE("Document No.", "Document No.");
                    DeatailVendorLdgrEntry.SETRANGE("Posting Date", "Posting Date");
                    DeatailVendorLdgrEntry.SETRANGE("Initial Document Type", DeatailVendorLdgrEntry."Initial Document Type"::Invoice);
                    DeatailVendorLdgrEntry.SETRANGE("Entry Type", DeatailVendorLdgrEntry."Entry Type"::Application);
                    IF DeatailVendorLdgrEntry.FINDFIRST THEN
                        VendorLdgrEntry.RESET;
                    VendorLdgrEntry.SETRANGE("Closed by Entry No.", DeatailVendorLdgrEntry."Applied Vend. Ledger Entry No.");
                    IF VendorLdgrEntry.FINDFIRST THEN;
                    PostdPurchaseHdr.RESET;
                    PostdPurchaseHdr.SETRANGE("No.", VendorLdgrEntry."Document No.");
                    PostdPurchaseHdr.FINDFIRST;
                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE("Document No.", PostdPurchaseHdr."No.");
                    IF PurchaseLine.FINDFIRST THEN BEGIN
                        REPEAT
                            TotalBalanceWithBalance := TotalBalanceWithBalance + PurchaseLine."Amount Including VAT";
                            TempPostedPurchaseLine.TRANSFERFIELDS(PurchaseLine);
                            TempPostedPurchaseLine.INSERT;
                        UNTIL PurchaseLine.NEXT = 0;
                    END;

                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(NoText, TotalBalanceWithBalance, 'Only');

                    DimRec.GET('BUSINESS UNITS', "Global Dimension 1 Code");
                end;
            }

            trigger OnAfterGetRecord()
            var
                GenJnalLineRec: Record "Gen. Journal Line";
            begin
                IF BankRec.GET("Bank Account No.") THEN;
                IF "Bal. Account Type" = "Bank Account Ledger Entry"."Bal. Account Type"::Vendor THEN
                    VenRec.GET("Bal. Account No.");
            end;

            trigger OnPreDataItem()
            begin
                ComRec.GET;
            end;
        }
        dataitem(TempPurchaseLine; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(Purchase_Doc_No; TempPostedPurchaseLine."Document No.")
            {
            }
            column(Purchase_BU_Code; TempPostedPurchaseLine."Shortcut Dimension 1 Code")
            {
            }
            column(Purchase_OPeration; TempPostedPurchaseLine."Shortcut Dimension 2 Code")
            {
            }
            column(Purchase_Amount; TempPostedPurchaseLine.Amount)
            {
            }
            column(NBTAmount; NBTAmount)
            {
            }
            column(VATAmount; VATAmount)
            {
            }
            column(TotalBalance; TotalBalance)
            {
            }

            trigger OnAfterGetRecord()
            var
                CalCompTax: Codeunit "Calculate Tax Of Company";
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempPostedPurchaseLine.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempPostedPurchaseLine.NEXT = 0 THEN
                        CurrReport.BREAK;

                CalCompTax.CalTaxOnTax(TempPostedPurchaseLine."Tax Group Code", TempPostedPurchaseLine."Tax Area Code", TempPostedPurchaseLine.Amount,
                   NBTAmount, VATAmount);
                TotalBalance := TempPostedPurchaseLine.Amount + NBTAmount + VATAmount;
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
        TempPostedPurchaseLine: Record "Purch. Inv. Line" temporary;
        DeatailVendorLdgrEntry: Record "Detailed Vendor Ledg. Entry";
        VendorLdgrEntry: Record "Vendor Ledger Entry";
        PurchaseLine: Record "Purch. Inv. Line";
        ComRec: Record "Company Information";
        VenRec: Record Vendor;
        BankRec: Record "Bank Account";
        CheckReport: Report Check;
        BCRec: Record "Dimension Value";
        DimRec: Record "Dimension Value";
        AmtTxt: Decimal;
        NBTAmount: Decimal;
        VATAmount: Decimal;
        TotalBalance: Decimal;
        NoText: array[2] of Text[100];
        PurchaseCode: Code[20];
        PurchaseBU: Code[10];
        PurchaseOperation: Code[10];
        PurchaseAmount: Decimal;
        AccCode: Code[20];
        Discrip: Text[100];
}

