pageextension 50234 SalesRecSetup extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Archive Orders")
        {
            field("Free Issue Code"; Rec."Free Issue Code")
            {
                ApplicationArea = All;
            }
            field("Overdue Approval Limit"; Rec."Overdue Approval Limit")
            {
                ApplicationArea = All;
            }
            field("Overdue Approval Age"; Rec."Overdue Approval Age")
            {
                ApplicationArea = All;
            }
            field("Overdue Days to Block Customer"; Rec."Overdue Days to Block Customer")
            {
                ApplicationArea = All;
            }
            field("Overdue Thold to Block Cust."; Rec."Overdue Thold to Block Cust.")
            {
                Caption = 'Overdue Threshold to Block Customer';
                ApplicationArea = All;
            }
            field("Sales Order Entry Code"; Rec."Sales Order Entry Code")
            {
                ApplicationArea = All;
            }
            field("Sales Return Entry Code"; Rec."Sales Return Entry Code")
            {
                ApplicationArea = All;
            }
            field("Sample Order Entry Code"; Rec."Sample Order Entry Code")
            {
                ApplicationArea = All;
            }
            field("Not Standard Approval"; Rec."Not Standard Approval")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Dimension Code")
        {
            group(Incentive)
            {
                field("Last Incetive Paid Year"; Rec."Last Incetive Paid Year")
                {
                    ApplicationArea = All;
                }
                field("Last Incentive Paid Month"; Rec."Last Incentive Paid Month")
                {
                    ApplicationArea = All;
                }
                field("Current Salary Year"; Rec."Current Salary Year")
                {
                    ApplicationArea = All;
                }
                field("Current Salary Month"; Rec."Current Salary Month")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            field("Debit Note Nos."; Rec."Debit Note Nos.")
            {
                ApplicationArea = All;
            }
            field("Sample Issue Nos."; Rec."Sample Issue Nos.")
            {
                ApplicationArea = All;
            }
            field("PD Cheque Doc. Nos."; Rec."PD Cheque Doc. Nos.")
            {
                ApplicationArea = All;
            }
            field("Invoice & Dispatch Nos."; Rec."Invoice & Dispatch Nos.")
            {
                ApplicationArea = All;
            }
            field("Debit Note Posting Nos."; Rec."Debit Note Posting Nos.")
            {
                ApplicationArea = All;
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