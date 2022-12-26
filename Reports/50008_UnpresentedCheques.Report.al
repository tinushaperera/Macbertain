report 50008 "Unpresented Cheques"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/UnpresentedCheques.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Bank Account No.", "Document Type", "Document No.")
                                ORDER(Ascending)
                                WHERE("Credit Amount" = FILTER(<> 0),
                                      Open = FILTER(true),
                                      Reversed = FILTER(false));
            RequestFilterFields = "Bank Account No.", "Posting Date";
            column(DocumentNo; "Document No.")
            {
            }
            column(PosingDate; FORMAT("Posting Date"))
            {
            }
            column(Description; Description)
            {
            }
            column(CreditAmount; "Credit Amount")
            {
            }
            column(CreditAmountLCY; "Credit Amount (LCY)")
            {
            }
            column(CompanyName; UPPERCASE(CpmpanyInfo.Name))
            {
            }
            column(CompanyAddress; CpmpanyInfo.Address)
            {
            }
            column(CompanyCity; CpmpanyInfo.City)
            {
            }
            column(BranchName; DimValueRec.Name)
            {
            }
            column(ChequeNo; "External Document No.")
            {
            }
            column(BankName; BankAccRec.Name)
            {
            }
            column(BankAccountNo; BankAccRec."Bank Account No.")
            {
            }
            column(BankCity; BankAccRec.City)
            {
            }
            column(Date; FORMAT(TODAY))
            {
            }
            column(Time; FORMAT(TIME))
            {
            }
            column(AmountLCY; "Amount (LCY)")
            {
            }
            column(PageNo; CurrReport.PAGENO)
            {
            }
            column(UserId; USERID)
            {
            }
            column(BankAccNo; BankAccNo)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(Payee; "Payee Name")
            {
            }
            column(PostingDate; FORMAT("Posting Date"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Add Branch
                DimValueRec.RESET;
                DimValueRec.SETRANGE(Code, "Bank Account Ledger Entry"."Global Dimension 1 Code");
                IF DimValueRec.FINDFIRST THEN;

                //Get Bank Acount Details
                IF BankAccRec.GET("Bank Account No.") THEN;

                ClacAmount := "Bank Account Ledger Entry".Amount;
                "ClacAmount(LYC)" := "Bank Account Ledger Entry"."Amount (LCY)";
                IF ("Document Type" = "Document Type"::Payment) AND
                       ("Bal. Account Type" = "Bal. Account Type"::Vendor) THEN BEGIN
                    "BnkAccLeg Ety".SETCURRENTKEY("Bank Account No.", "Document Type", "Document No.");
                    "BnkAccLeg Ety".SETRANGE("BnkAccLeg Ety"."Document No.",
                                                "Bank Account Ledger Entry"."Document No.");
                    "BnkAccLeg Ety".SETFILTER("BnkAccLeg Ety"."Amount (LCY)", '<>%1',
                                                    "Bank Account Ledger Entry"."Amount (LCY)");
                    IF "BnkAccLeg Ety".FINDFIRST THEN
                        REPEAT
                            ClacAmount := ClacAmount + "BnkAccLeg Ety".Amount;
                            "ClacAmount(LYC)" := "ClacAmount(LYC)" + "BnkAccLeg Ety"."Amount (LCY)";
                        UNTIL "BnkAccLeg Ety".NEXT = 0;
                END;
                TotAmount := TotAmount + ClacAmount;
                "TotAmount(LYC)" := "TotAmount(LYC)" + "ClacAmount(LYC)";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");
                IF CpmpanyInfo.GET THEN;
                BankAccNo := "Bank Account Ledger Entry".GETFILTER("Bank Account No.");
                DateFilter := "Bank Account Ledger Entry".GETFILTER("Posting Date");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TVFilter: Text[200];
        "BnkAccLeg Ety": Record "Bank Account Ledger Entry";
        ClacAmount: Decimal;
        "ClacAmount(LYC)": Decimal;
        TotAmount: Decimal;
        "TotAmount(LYC)": Decimal;
        TotalFor: Label 'Total for ';
        CpmpanyInfo: Record "Company Information";
        DimValueRec: Record "Dimension Value";
        BankAccRec: Record "Bank Account";
        BankAccNo: Code[20];
        DateFilter: Text[30];
}

