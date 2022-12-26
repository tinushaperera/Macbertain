pageextension 50217 GenJournal extends "General Journal"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("Expense Type"; Rec."Expense Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter(Description)
        {
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
            }
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
            }
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
            field("Import Job No."; Rec."Import Job No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("Cost Mgt. Calculation"; Rec."Cost Mgt. Calculation")
            {
                ApplicationArea = All;
            }
            field("Cost Mgt. Ration"; Rec."Cost Mgt. Ration")
            {
                ApplicationArea = All;
            }
        }
        modify("Document Date")
        {
            Visible = true;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Reason Code")
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