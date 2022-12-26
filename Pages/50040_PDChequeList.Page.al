page 50040 "PD Cheque List"
{
    Caption = 'PD Cheque List';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Gen. Journal Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Cheque Banking Date';
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Cheque Received Date"; rec."Cheque Received Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cheque No.';
                }
                field("Temp. Receipt No."; rec."Temp. Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

