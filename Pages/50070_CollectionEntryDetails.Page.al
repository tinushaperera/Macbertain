page 50070 "Collection Entry Details"
{
    PageType = List;
    SourceTable = "Collection Details Entry";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
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
                field("Remaining Amount"; rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Original Amt. (LCY)"; rec."Original Amt. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amt. (LCY)"; rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Sales (LCY)"; rec."Sales (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Payment Cust. Led. Entry No."; rec."Payment Cust. Led. Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Payment Amount"; rec."Payment Amount")
                {
                    ApplicationArea = All;
                }
                field("Payment Det. Led. Enrty No."; rec."Payment Det. Led. Enrty No.")
                {
                    ApplicationArea = All;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Month; rec.Month)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Line No"; rec."Line No")
                {
                    ApplicationArea = All;
                }
                field(Amt1; rec.Amt1)
                {
                    ApplicationArea = All;
                }
                field(Amt2; rec.Amt2)
                {
                    ApplicationArea = All;
                }
                field(Amt3; rec.Amt3)
                {
                    ApplicationArea = All;
                }
                field(Amt4; rec.Amt4)
                {
                    ApplicationArea = All;
                }
                field(CollectAmt; rec.CollectAmt)
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

