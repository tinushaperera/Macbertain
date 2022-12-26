page 50017 "PD-Cheque Receipt Journal"
{
    ApplicationArea = all;
    UsageCategory = Tasks;
    AutoSplitKey = true;
    Caption = 'PD-Cheque Receipt Journal';
    DataCaptionExpression = rec.DataCaption;
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(content)
        {
            field("Journal Template Name"; rec."Journal Template Name")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = all;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(General)
            {
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Caption = 'Cheque Banking Date';
                }
                field("Cheque Received Date"; rec."Cheque Received Date")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Caption = 'Cheque No.';
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        Text000M: Label 'Account Type should be Customer';
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        IF rec."Account Type" <> rec."Account Type"::Customer THEN
                            ERROR(Text000M);
                        rec."Document Type" := rec."Document Type"::Payment;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Narration; rec.Narration)
                {
                    ApplicationArea = all;
                }
                field("Bank Code"; rec."Bank Code")
                {
                    ApplicationArea = all;
                }
                field("Branch Code"; rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field("Temp. Receipt No."; rec."Temp. Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("3rd Party Cheque"; rec."3rd Party Cheque")
                {
                    ApplicationArea = all;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Credit Amount"; rec."Credit Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            group(Control30)
            {
                fixed(Control1901776101)
                {
                    group("Account Name")
                    {
                        Caption = 'Account Name';
                        field(AccName; AccName)
                        {
                            ApplicationArea = all;
                            Editable = false;
                        }
                    }
                    group("Bal. Account Name")
                    {
                        Caption = 'Bal. Account Name';
                        field(BalAccName; BalAccName)
                        {
                            ApplicationArea = all;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                        }
                    }
                    group(Balance1)
                    {
                        Caption = 'Balance';
                        field(Balance; Balance + rec."Balance (LCY)" - xRec."Balance (LCY)")
                        {
                            ApplicationArea = all;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            Visible = BalanceVisible;
                        }
                    }
                    group("Total Balance")
                    {
                        Caption = 'Total Balance';
                        field(TotalBalance; TotalBalance + rec."Balance (LCY)" - xRec."Balance (LCY)")
                        {
                            ApplicationArea = all;
                            AutoFormatType = 1;
                            Caption = 'Total Balance';
                            Editable = false;
                            Visible = TotalBalanceVisible;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part("Dimension Set Entries FactBox"; "Dimension Set Entries FactBox")
            {
                SubPageLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                Visible = false;
            }
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
            // systempart(; Notes)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                Image = ChartOfAccounts;
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Codeunit "Gen. Jnl.-Show Card";
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = all;
                    Caption = 'Ledger E&ntries';
                    Image = GLRegisters;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Codeunit "Gen. Jnl.-Show Entries";
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Apply Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Gen. Jnl.-Apply";
                    ShortCutKey = 'Shift+F11';
                }
                action("Insert Conv. LCY Rndg. Lines")
                {
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    Image = InsertCurrency;
                    RunObject = Codeunit "Adjust Gen. Journal Balance";
                    Visible = false;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Reconcile)
                {
                    ApplicationArea = all;
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F11';

                    trigger OnAction()
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.RUN;
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = all;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = all;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        UpdateRec;//RJ
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                        CurrentJnlBatchName := rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;

                    trigger OnAction()
                    begin
                        UpdateRec;//RJ
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := rec.GETRANGEMAX(rec."Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Posted Sales Invoices";
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        //UpdateRec;//RJ
                        //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
                        //CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        //CurrPage.UPDATE(FALSE);
                    end;
                }
                action("PD-Cheques Listing")
                {
                    ApplicationArea = all;
                    Caption = 'PD-Cheques Listing';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "PD-Cheques Listing";
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        //UpdateRec;//RJ
                        //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
                        //CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        //CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance;
    end;

    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := TRUE;
        BalanceVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance;
        rec.SetUpNewLine(xRec, Balance, BelowxRec);
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        BalAccName := '';
        OpenedFromBatch := (rec."Journal Batch Name" <> '') AND (rec."Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := rec."Journal Batch Name";
            GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        GenJnlManagement.TemplateSelection(PAGE::"PD-Cheque Receipt Journal", "Gen. Journal Template Type"::"PD Cheque", FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page "Reconciliation";
        GenJnlManagement: Codeunit "GenJnlManagement";
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[10];
        AccName: Text[50];
        BalAccName: Text[50];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;
        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(
          Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;


    procedure UpdateRec()
    begin
        IF rec.FINDSET THEN
            REPEAT
                rec."PD Receipt No." := rec."Document No.";
                rec.MODIFY;
                IF rec."Posting Date" > TODAY THEN
                    ERROR('Document %1 unable to post', rec."Document No.");
                //<Chin 20160713 1620
                rec.TESTFIELD("Temp. Receipt No.");
            //>
            UNTIL rec.NEXT = 0;
    end;
}

