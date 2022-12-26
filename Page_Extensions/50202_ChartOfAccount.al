pageextension 50202 ChartOfAccount extends "Chart of Accounts"
{
    layout
    {
        addafter(Balance)
        {
            field("NAV A/C"; Rec."NAV A/C")
            {
                ApplicationArea = All;
            }
            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = All;
            }
            field("Budget at Date"; Rec."Budget at Date")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Default Deferral Template Code")
        {
            field("Cost Scenario 2"; Rec."Cost Scenario 2")
            {
                ApplicationArea = All;
            }
            field("Cost Scenario 3"; Rec."Cost Scenario 3")
            {
                ApplicationArea = All;
            }
            field("Cost Scenario 4"; Rec."Cost Scenario 4")
            {
                ApplicationArea = All;
            }
            field("Cost Scenario 5"; Rec."Cost Scenario 5")
            {
                ApplicationArea = All;
            }
            field("Sales Account"; Rec."Sales Account")
            {
                ApplicationArea = All;
            }
            field("Cost Mgt Sales Acc"; Rec."Cost Mgt Sales Acc")
            {
                ApplicationArea = All;
            }
            field("Debtors Acc"; Rec."Debtors Acc")
            {
                ApplicationArea = All;
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
            }
        }
        modify("Default Deferral Template Code")
        {
            Caption = 'Default Deferral Template';
        }
        modify("Direct Posting")
        {
            Visible = true;
        }
        modify("Net Change")
        {
            BlankZero = true;
        }
        modify("Balance at Date")
        {
            BlankZero = true;
        }
        modify(Balance)
        {
            BlankZero = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}