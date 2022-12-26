pageextension 50204 CustomerLedEntries extends "Customer Ledger Entries"
{

    layout
    {
        addafter("Posting Date")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Document No.")
        {
            field("PD Receipt No."; Rec."PD Receipt No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Cheque Retun Invoice"; Rec."Cheque Retun Invoice")
            {
                ApplicationArea = All;
                Style = Unfavorable;
                StyleExpr = true;
            }
        }
        addafter(Description)
        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field("Temp. Receipt No."; Rec."Temp. Receipt No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Unidentified Deposit No."; Rec."Unidentified Deposit No.")
            {
                ApplicationArea = All;
            }
            field("3rd Party Cheque"; Rec."3rd Party Cheque")
            {
                ApplicationArea = All;
            }
            field("Bank Code"; Rec."Bank Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Cheque Received Date"; Rec."Cheque Received Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Global Dimension 2 Code")
        {
            field("Region Code"; Rec."Region Code")
            {
                Editable = false;
                ApplicationArea = All;
                Visible = true;
            }
            field("Territory Code"; Rec."Territory Code")
            {
                Editable = false;
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("Due Date")
        {
            field("Closed by Entry No."; Rec."Closed by Entry No.")
            {
                ApplicationArea = All;
            }
            field("Closed at Date"; Rec."Closed at Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Reason Code")
        {
            field("Reason Description"; Rec."Reason Description")
            {
                ApplicationArea = All;
            }
        }
        modify("Customer Name")
        {
            Editable = false;
        }
        modify("External Document No.")
        {
            Editable = false;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }
        modify("Original Amt. (LCY)")
        {
            Visible = true;
        }
        modify("User ID")
        {
            Visible = true;
        }
        modify("Source Code")
        {
            Visible = true;
        }
        modify("Reason Code")
        {
            Visible = true;
        }
        modify(Reversed)
        {
            Visible = true;
        }
    }

    actions
    {
        addlast("F&unctions")
        {
            action("CRN 02 Instant")
            {
                Caption = 'CRN 02 Instant';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = Report "CRN 2nd Instant";
                Visible = false;
            }
            action("Official Receipt")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CustLedEnty: Record "Cust. Ledger Entry";
                begin
                    CustLedEnty.RESET;
                    CustLedEnty.SETRANGE("Document Type", Rec."Document Type");
                    CustLedEnty.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50002, TRUE, TRUE, CustLedEnty);
                end;
            }
            action("Chq. 01 Reminder Letter")
            {
                Caption = 'Chq. 01 Reminder Letter';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CustLedEnty: Record "Cust. Ledger Entry";
                begin
                    CustLedEnty.RESET;
                    CustLedEnty.SETRANGE("Document Type", Rec."Document Type");
                    CustLedEnty.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50064, TRUE, TRUE, CustLedEnty);
                end;
            }
            action("Chq. 2nd Reminder Letter")
            {
                Caption = 'Chq. 2nd Reminder Letter';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CustLedEnty: Record "Cust. Ledger Entry";
                begin
                    CustLedEnty.RESET;
                    CustLedEnty.SETRANGE("Document Type", Rec."Document Type");
                    CustLedEnty.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50082, TRUE, TRUE, CustLedEnty);
                end;
            }
            action("Debit Note Chq. Return/Chargers")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CustLedEnty: Record "Cust. Ledger Entry";
                begin
                    CustLedEnty.RESET;
                    CustLedEnty.SETRANGE("Document Type", Rec."Document Type");
                    CustLedEnty.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUNMODAL(50055, TRUE, TRUE, CustLedEnty);
                end;
            }
        }
    }
    var
        myInt: Integer;
}