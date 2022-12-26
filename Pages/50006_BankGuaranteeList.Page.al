page 50006 "Bank Guarantee List"
{
    PageType = List;
    SourceTable = "Customer Security";
    SourceTableView = WHERE("Security Type" = CONST("Bank Guarantee"));
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Security Type"; rec."Security Type")
                {
                    ApplicationArea = all;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Reference No."; rec."Reference No.")
                {
                    ApplicationArea = all;
                }
                field("Bank Code"; rec."Bank Code")
                {
                    ApplicationArea = all;
                }
                field("Bank Name"; rec."Bank Name")
                {
                    ApplicationArea = all;
                }
                field(Branch; rec.Branch)
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Strat Date"; rec."Strat Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; rec."End Date")
                {
                    ApplicationArea = all;
                }
                field(Active; rec.Active)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

