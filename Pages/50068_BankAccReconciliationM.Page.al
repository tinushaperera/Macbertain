page 50068 "Bank Acc. Reconciliation-M"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Bank Acc. Reconciliation Line";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ready for Application"; rec."Ready for Application")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; rec."Transaction Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Value Date"; rec."Value Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Check No."; rec."Check No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SetUserInteractions;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Statement Amount"; rec."Statement Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Applied Amount"; rec."Applied Amount")
                {
                    ApplicationArea = All;
                }
                field(Difference; rec.Difference)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Applied Entries"; rec."Applied Entries")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Related-Party Name"; rec."Related-Party Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Additional Transaction Info"; rec."Additional Transaction Info")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group(General)
            {
                Visible = false;

                field(Balance; Balance + rec."Statement Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = rec.GetCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Enabled = BalanceEnable;
                }
                field(TotalBalance; TotalBalance + rec."Statement Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = rec.GetCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Enabled = TotalBalanceEnable;
                }
                field(TotalDiff; TotalDiff + rec.Difference)
                {
                    ApplicationArea = All;
                    AutoFormatExpression = rec.GetCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Total Difference';
                    Editable = false;
                    Enabled = TotalDiffEnable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowStatementLineDetails)
            {
                ApplicationArea = All;
                Caption = 'Details';
                RunObject = Page 1221;
                RunPageLink = "Data Exch. No." = FIELD("Data Exch. Entry No."),
                              "Line No." = FIELD("Data Exch. Line No.");
            }
            action(ApplyEntries1)
            {
                ApplicationArea = All;
                Caption = '&Apply Entries...';
                Enabled = ApplyEntriesAllowed;
                Image = ApplyEntries;

                trigger OnAction()
                begin
                    ApplyEntries;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF rec."Statement Line No." <> 0 THEN
            CalcBalance(rec."Statement Line No.");
        SetUserInteractions;
    end;

    trigger OnAfterGetRecord()
    begin
        SetUserInteractions;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SetUserInteractions;
    end;

    trigger OnInit()
    begin
        BalanceEnable := TRUE;
        TotalBalanceEnable := TRUE;
        TotalDiffEnable := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF BelowxRec THEN
            CalcBalance(xRec."Statement Line No.")
        ELSE
            CalcBalance(xRec."Statement Line No." - 1);
    end;

    var
        BankAccRecon: Record "Bank Acc. Reconciliation";
        StyleTxt: Text;
        TotalDiff: Decimal;
        Balance: Decimal;
        TotalBalance: Decimal;
        [InDataSet]
        TotalDiffEnable: Boolean;
        [InDataSet]
        TotalBalanceEnable: Boolean;
        [InDataSet]
        BalanceEnable: Boolean;
        ApplyEntriesAllowed: Boolean;

    local procedure CalcBalance(BankAccReconLineNo: Integer)
    var
        TempBankAccReconLine: Record "Bank Acc. Reconciliation Line";
    begin
        IF BankAccRecon.GET(rec."Statement Type", rec."Bank Account No.", rec."Statement No.") THEN;

        TempBankAccReconLine.COPY(Rec);

        TotalDiff := -rec.Difference;
        IF TempBankAccReconLine.CALCSUMS(Difference) THEN BEGIN
            TotalDiff := TotalDiff + TempBankAccReconLine.Difference;
            TotalDiffEnable := TRUE;
        END ELSE
            TotalDiffEnable := FALSE;

        TotalBalance := BankAccRecon."Balance Last Statement" - rec."Statement Amount";
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
            TotalBalance := TotalBalance + TempBankAccReconLine."Statement Amount";
            TotalBalanceEnable := TRUE;
        END ELSE
            TotalBalanceEnable := FALSE;

        Balance := BankAccRecon."Balance Last Statement" - rec."Statement Amount";
        TempBankAccReconLine.SETRANGE("Statement Line No.", 0, BankAccReconLineNo);
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
            Balance := Balance + TempBankAccReconLine."Statement Amount";
            BalanceEnable := TRUE;
        END ELSE
            BalanceEnable := FALSE;
    end;

    local procedure ApplyEntries()
    var
        BankAccReconApplyEntries: Codeunit "Bank Acc. Recon. Apply Entries";
    begin
        rec."Ready for Application" := TRUE;
        CurrPage.SAVERECORD;
        COMMIT;
        BankAccReconApplyEntries.ApplyEntries(Rec);
    end;


    procedure GetSelectedRecords(var TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary)
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        CurrPage.SETSELECTIONFILTER(BankAccReconciliationLine);
        IF BankAccReconciliationLine.FINDSET THEN
            REPEAT
                TempBankAccReconciliationLine := BankAccReconciliationLine;
                TempBankAccReconciliationLine.INSERT;
            UNTIL BankAccReconciliationLine.NEXT = 0;
    end;

    local procedure SetUserInteractions()
    begin
        StyleTxt := rec.GetStyle;
        ApplyEntriesAllowed := rec.Type = rec.Type::"Check Ledger Entry";
    end;


    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        IF SetFilterOn THEN
            rec.SETFILTER(Difference, '<>%1', 0)
        ELSE
            rec.RESET;
        CurrPage.UPDATE;
    end;
}

