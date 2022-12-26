// page 50017 "PD-Cheque Receipt Journal"
// {
// AutoSplitKey = true;
// Caption = 'PD-Cheque Receipt Journal';
// DataCaptionExpression = DataCaption;
// DelayedInsert = true;
// PageType = Worksheet;
// SaveValues = true;
// SourceTable = Table81;

// layout
// {
//     area(content)
//     {
//         field("Journal Template Name"; "Journal Template Name")
//         {
//             Visible = false;
//         }
//         field(CurrentJnlBatchName; CurrentJnlBatchName)
//         {
//             Caption = 'Batch Name';
//             Lookup = true;

//             trigger OnLookup(var Text: Text): Boolean
//             begin
//                 CurrPage.SAVERECORD;
//                 GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
//                 CurrPage.UPDATE(FALSE);
//             end;

//             trigger OnValidate()
//             begin
//                 GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
//                 CurrentJnlBatchNameOnAfterVali;
//             end;
//         }
//         repeater()
//         {
//             field("Posting Date"; "Posting Date")
//             {
//                 Caption = 'Cheque Banking Date';
//             }
//             field("Cheque Received Date"; "Cheque Received Date")
//             {
//             }
//             field("Document Type"; "Document Type")
//             {
//                 Editable = false;
//             }
//             field("Document No."; "Document No.")
//             {
//                 Editable = false;
//             }
//             field("External Document No."; "External Document No.")
//             {
//                 Caption = 'Cheque No.';
//             }
//             field("Account Type"; "Account Type")
//             {

//                 trigger OnValidate()
//                 begin
//                     GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
//                 end;
//             }
//             field("Account No."; "Account No.")
//             {

//                 trigger OnValidate()
//                 var
//                     Text000M: Label 'Account Type should be Customer';
//                 begin
//                     GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
//                     ShowShortcutDimCode(ShortcutDimCode);
//                     IF "Account Type" <> "Account Type"::Customer THEN
//                         ERROR(Text000M);
//                     "Document Type" := "Document Type"::Payment;
//                 end;
//             }
//             field(Description; Description)
//             {
//             }
//             field(Narration; Narration)
//             {
//             }
//             field("Bank Code"; "Bank Code")
//             {
//             }
//             field("Branch Code"; "Branch Code")
//             {
//             }
//             field("Temp. Receipt No."; "Temp. Receipt No.")
//             {
//             }
//             field("3rd Party Cheque"; "3rd Party Cheque")
//             {
//             }
//             field("Salespers./Purch. Code"; "Salespers./Purch. Code")
//             {
//             }
//             field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
//             {
//                 Editable = false;
//             }
//             field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
//             {
//             }
//             field("Source Code"; "Source Code")
//             {
//                 Visible = false;
//             }
//             field("Credit Amount"; "Credit Amount")
//             {
//                 Visible = false;
//             }
//             field(Amount; Amount)
//             {
//             }
//             field("Bal. Account Type"; "Bal. Account Type")
//             {
//             }
//             field("Bal. Account No."; "Bal. Account No.")
//             {

//                 trigger OnValidate()
//                 begin
//                     GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
//                     ShowShortcutDimCode(ShortcutDimCode);
//                 end;
//             }
//             field("Applies-to Doc. Type"; "Applies-to Doc. Type")
//             {
//                 Visible = false;
//             }
//             field("Applies-to Doc. No."; "Applies-to Doc. No.")
//             {
//                 Style = Unfavorable;
//                 StyleExpr = TRUE;
//             }
//             field("Reason Code"; "Reason Code")
//             {
//                 Visible = false;
//             }
//         }
//         group()
//         {
//             fixed()
//             {
//                 group("Account Name")
//                 {
//                     Caption = 'Account Name';
//                     field(AccName; AccName)
//                     {
//                         Editable = false;
//                     }
//                 }
//                 group("Bal. Account Name")
//                 {
//                     Caption = 'Bal. Account Name';
//                     field(BalAccName; BalAccName)
//                     {
//                         Caption = 'Bal. Account Name';
//                         Editable = false;
//                     }
//                 }
//                 group(Balance)
//                 {
//                     Caption = 'Balance';
//                     field(Balance; Balance + "Balance (LCY)" - xRec."Balance (LCY)")
//                     {
//                         AutoFormatType = 1;
//                         Caption = 'Balance';
//                         Editable = false;
//                         Visible = BalanceVisible;
//                     }
//                 }
//                 group("Total Balance")
//                 {
//                     Caption = 'Total Balance';
//                     field(TotalBalance; TotalBalance + "Balance (LCY)" - xRec."Balance (LCY)")
//                     {
//                         AutoFormatType = 1;
//                         Caption = 'Total Balance';
//                         Editable = false;
//                         Visible = TotalBalanceVisible;
//                     }
//                 }
//             }
//         }
//     }
//     area(factboxes)
//     {
//         part(; 699)
//         {
//             SubPageLink = Dimension Set ID=FIELD(Dimension Set ID);
//                 Visible = false;
//         }
//         systempart(; Links)
//         {
//             Visible = false;
//         }
//         systempart(; Notes)
//         {
//             Visible = false;
//         }
//     }
// }

// actions
// {
//     area(navigation)
//     {
//         group("&Line")
//         {
//             Caption = '&Line';
//             Image = Line;
//             action(Dimensions)
//             {
//                 Caption = 'Dimensions';
//                 Image = Dimensions;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ShortCutKey = 'Shift+Ctrl+D';

//                 trigger OnAction()
//                 begin
//                     ShowDimensions;
//                     CurrPage.SAVERECORD;
//                 end;
//             }
//         }
//         group("A&ccount")
//         {
//             Caption = 'A&ccount';
//             Image = ChartOfAccounts;
//             action(Card)
//             {
//                 Caption = 'Card';
//                 Image = EditLines;
//                 RunObject = Codeunit 15;
//                 ShortCutKey = 'Shift+F7';
//             }
//             action("Ledger E&ntries")
//             {
//                 Caption = 'Ledger E&ntries';
//                 Image = GLRegisters;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;
//                 RunObject = Codeunit 14;
//                 ShortCutKey = 'Ctrl+F7';
//             }
//         }
//     }
//     area(processing)
//     {
//         group("F&unctions")
//         {
//             Caption = 'F&unctions';
//             Image = "Action";
//             action("Apply Entries")
//             {
//                 Caption = 'Apply Entries';
//                 Ellipsis = true;
//                 Image = ApplyEntries;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Codeunit 225;
//                 ShortCutKey = 'Shift+F11';
//             }
//             action("Insert Conv. LCY Rndg. Lines")
//             {
//                 Caption = 'Insert Conv. LCY Rndg. Lines';
//                 Image = InsertCurrency;
//                 RunObject = Codeunit 407;
//                 Visible = false;
//             }
//         }
//         group("P&osting")
//         {
//             Caption = 'P&osting';
//             Image = Post;
//             action(Reconcile)
//             {
//                 Caption = 'Reconcile';
//                 Image = Reconcile;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ShortCutKey = 'Ctrl+F11';

//                 trigger OnAction()
//                 begin
//                     GLReconcile.SetGenJnlLine(Rec);
//                     GLReconcile.RUN;
//                 end;
//             }
//             action("Test Report")
//             {
//                 Caption = 'Test Report';
//                 Ellipsis = true;
//                 Image = TestReport;
//                 Promoted = true;

//                 trigger OnAction()
//                 begin
//                     ReportPrint.PrintGenJnlLine(Rec);
//                 end;
//             }
//             action("P&ost")
//             {
//                 Caption = 'P&ost';
//                 Image = PostOrder;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 ShortCutKey = 'F9';

//                 trigger OnAction()
//                 begin
//                     UpdateRec;//RJ
//                     CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
//                     CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
//                     CurrPage.UPDATE(FALSE);
//                 end;
//             }
//             action("Post and &Print")
//             {
//                 Caption = 'Post and &Print';
//                 Image = PostPrint;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 ShortCutKey = 'Shift+F9';
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     UpdateRec;//RJ
//                     CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
//                     CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
//                     CurrPage.UPDATE(FALSE);
//                 end;
//             }
//             action("Posted Sales Invoices")
//             {
//                 Caption = 'Posted Sales Invoices';
//                 Image = PostOrder;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page 143;
//                 ShortCutKey = 'F9';

//                 trigger OnAction()
//                 begin
//                     //UpdateRec;//RJ
//                     //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
//                     //CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
//                     //CurrPage.UPDATE(FALSE);
//                 end;
//             }
//             action("PD-Cheques Listing")
//             {
//                 Caption = 'PD-Cheques Listing';
//                 Image = "Report";
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Report 50073;
//                 ShortCutKey = 'F9';

//                 trigger OnAction()
//                 begin
//                     //UpdateRec;//RJ
//                     //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
//                     //CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
//                     //CurrPage.UPDATE(FALSE);
//                 end;
//             }
//         }
//     }
// }

// trigger OnAfterGetCurrRecord()
// begin
//     GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
//     UpdateBalance;
// end;

// trigger OnAfterGetRecord()
// begin
//     ShowShortcutDimCode(ShortcutDimCode);
// end;

// trigger OnInit()
// begin
//     TotalBalanceVisible := TRUE;
//     BalanceVisible := TRUE;
// end;

// trigger OnNewRecord(BelowxRec: Boolean)
// begin
//     UpdateBalance;
//     SetUpNewLine(xRec, Balance, BelowxRec);
//     CLEAR(ShortcutDimCode);
// end;

// trigger OnOpenPage()
// var
//     JnlSelected: Boolean;
// begin
//     BalAccName := '';
//     OpenedFromBatch := ("Journal Batch Name" <> '') AND ("Journal Template Name" = '');
//     IF OpenedFromBatch THEN BEGIN
//         CurrentJnlBatchName := "Journal Batch Name";
//         GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
//         EXIT;
//     END;
//     GenJnlManagement.TemplateSelection(PAGE::"PD-Cheque Receipt Journal", 8, FALSE, Rec, JnlSelected);
//     IF NOT JnlSelected THEN
//         ERROR('');
//     GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
// end;

// var
//     ChangeExchangeRate: Page "511";
//     GLReconcile: Page "345";
//     GenJnlManagement: Codeunit "230";
//     ReportPrint: Codeunit "228";
//     CurrentJnlBatchName: Code[10];
//     AccName: Text[50];
//     BalAccName: Text[50];
//     Balance: Decimal;
//     TotalBalance: Decimal;
//     ShowBalance: Boolean;
//     ShowTotalBalance: Boolean;
//     ShortcutDimCode: array[8] of Code[20];
//     OpenedFromBatch: Boolean;
//     [InDataSet]
//     BalanceVisible: Boolean;
//     [InDataSet]
//     TotalBalanceVisible: Boolean;

// local procedure UpdateBalance()
// begin
//     GenJnlManagement.CalcBalance(
//       Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
//     BalanceVisible := ShowBalance;
//     TotalBalanceVisible := ShowTotalBalance;
// end;

// local procedure CurrentJnlBatchNameOnAfterVali()
// begin
//     CurrPage.SAVERECORD;
//     GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
//     CurrPage.UPDATE(FALSE);
// end;

// [Scope('Internal')]
// procedure UpdateRec()
// begin
//     IF FINDSET THEN
//         REPEAT
//             "PD Receipt No." := "Document No.";
//             MODIFY;
//             IF "Posting Date" > TODAY THEN
//                 ERROR('Document %1 unable to post', "Document No.");
//             //<Chin 20160713 1620
//             TESTFIELD("Temp. Receipt No.");
//         //>
//         UNTIL NEXT = 0;
// end;
// }

