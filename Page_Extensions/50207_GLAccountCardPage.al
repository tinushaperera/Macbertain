pageextension 50207 GLAccountCard extends "G/L Account Card"
{
    layout
    {
        addafter("Direct Posting")
        {
            field("NAV A/C"; Rec."NAV A/C")
            {
                ApplicationArea = All;
            }
        }
        addafter(Posting)
        {
            group("Cost Allocation")
            {
                Caption = 'Cost Allocation';
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
                    Caption = 'Debtors Acc';
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}