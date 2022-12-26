pageextension 50236 PaymenetJnalExt extends "Payment Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
            }
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field("Expense Type"; Rec."Expense Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bal. Account No.")
        {
            field("Cheque Print Approved"; Rec."Cheque Print Approved")
            {
                ApplicationArea = All;
            }
        }
        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
    }

    actions
    {
        addafter(IncomingDoc)
        {
            action("Cheque Print")
            {
                ApplicationArea = All;
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JenJnlLine1: Record "Gen. Journal Line";
                    UserSetup: Record "User Setup";
                begin
                    //RJ
                    rec.TESTFIELD("Cheque Print Approved", TRUE); //RJ
                    UserSetup.GET(USERID);
                    IF NOT UserSetup."Check Print Approval" THEN
                        ERROR('You have no permission to Cheque Print');
                    JenJnlLine1.RESET;
                    JenJnlLine1.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    JenJnlLine1.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    JenJnlLine1.SETRANGE("Document No.", rec."Document No.");
                    REPORT.RUNMODAL(50006, TRUE, TRUE, JenJnlLine1);
                    //RJ
                end;
            }
            action("Payment Voucher - Cash")
            {
                Caption = 'Payment Voucher - Cheque';
                ApplicationArea = All;
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JenJnalLineRec: Record "Gen. Journal Line";
                begin
                    JenJnalLineRec.RESET;
                    JenJnalLineRec.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    JenJnalLineRec.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    JenJnalLineRec.SETRANGE("Document No.", rec."Document No.");
                    IF JenJnalLineRec.FINDFIRST THEN
                        REPORT.RUNMODAL(50023, TRUE, TRUE, JenJnalLineRec);
                end;
            }
            action("Payment Voucher - Cheque")
            {
                Caption = 'Petty Cash Payment Voucher';
                ApplicationArea = All;
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JenJnalLineRec: Record "Gen. Journal Line";
                begin
                    JenJnalLineRec.RESET;
                    JenJnalLineRec.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    JenJnalLineRec.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    JenJnalLineRec.SETRANGE("Document No.", Rec."Document No.");
                    IF JenJnalLineRec.FINDFIRST THEN
                        REPORT.RUNMODAL(50024, TRUE, TRUE, JenJnalLineRec);
                end;
            }
            action("Payment Voucher Advance - (Cash/Vendor)")
            {
                ApplicationArea = All;
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JenJnalLineRec: Record "Gen. Journal Line";
                begin
                    JenJnalLineRec.RESET;
                    JenJnalLineRec.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    JenJnalLineRec.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    JenJnalLineRec.SETRANGE("Document No.", rec."Document No.");
                    IF JenJnalLineRec.FINDFIRST THEN
                        REPORT.RUNMODAL(50022, TRUE, TRUE, JenJnalLineRec);
                end;
            }
            action("Payment Voucher- Direct")
            {
                ApplicationArea = All;
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JenJnalLineRec: Record "Gen. Journal Line";
                begin
                    JenJnalLineRec.RESET;
                    JenJnalLineRec.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    JenJnalLineRec.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    JenJnalLineRec.SETRANGE("Document No.", rec."Document No.");
                    IF JenJnalLineRec.FINDFIRST THEN
                        REPORT.RUNMODAL(50088, TRUE, TRUE, JenJnalLineRec);
                end;
            }
            action("Payment Voucher- Online")
            {
                ApplicationArea = All;
                Image = Voucher;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JenJnalLineRec: Record "Gen. Journal Line";
                begin
                    JenJnalLineRec.RESET;
                    JenJnalLineRec.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    JenJnalLineRec.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    JenJnalLineRec.SETRANGE("Document No.", rec."Document No.");
                    IF JenJnalLineRec.FINDFIRST THEN
                        REPORT.RUNMODAL(50054, TRUE, TRUE, JenJnalLineRec);
                end;
            }
        }
    }
}