pageextension 50206 GenLedEntries extends "General Ledger Entries"
{

    layout
    {
        addafter("Posting Date")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Type")
        {
            field("Expense Type"; Rec."Expense Type")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Temp. Receipt No."; Rec."Temp. Receipt No.")
            {
                ApplicationArea = All;
            }
            field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Import Job No."; Rec."Import Job No.")
            {
                ApplicationArea = All;
            }
            field("Bank Code"; Rec."Bank Code")
            {
                ApplicationArea = All;
            }
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
            }
            field("Prior-Year Entry"; Rec."Prior-Year Entry")
            {
                ApplicationArea = All;
            }
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("System-Created Entry"; Rec."System-Created Entry")
            {
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
            }
            field(Applied; Rec.Applied)
            {
                ApplicationArea = All;
            }
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }

        }
        modify("G/L Account Name")
        {
            Visible = true;
        }
        modify("VAT Amount")
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
        modify(Reversed)
        {
            Visible = true;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}