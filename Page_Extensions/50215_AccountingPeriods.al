pageextension 50215 AccountingPeriods extends "Accounting Periods"
{
    layout
    {
        addafter("Average Cost Calc. Type")
        {
            field("Cost Senario 2 Period"; Rec."Cost Senario 2 Period")
            {
                ApplicationArea = All;
            }
            field("Cost Senario 3 Period"; Rec."Cost Senario 3 Period")
            {
                ApplicationArea = All;
            }
            field("Cost Senario 4 Period"; Rec."Cost Senario 4 Period")
            {
                ApplicationArea = All;
            }
            field("Cost Senario 5 Period"; Rec."Cost Senario 5 Period")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Fiscal Year Balance")
        {
            action("Cost Allocation Mgt. Senario 2")
            {
                Image = Cost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Cost Allocation Management 2";
                Visible = true;
            }
            action("Cost Allocation Mgt. Senario 3")
            {
                Image = Cost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Cost Allocation Management 3";
            }
            action("Cost Allocation Mgt. Senario 4")
            {
                Image = Cost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Cost Allocation Management 4";
            }
            action("Cost Allocation Mgt. Senario 5")
            {
                Image = Cost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Cost Allocation Management 5";
            }
        }
    }

    var
        myInt: Integer;
}