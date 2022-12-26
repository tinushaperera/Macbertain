page 50005 "Customer Security List"
{

    PageType = List;
    SourceTable = "Customer Security";
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
                field("Bank Code"; rec."Bank Code")
                {
                    ApplicationArea = all;
                }
                field("Bank Name"; rec."Bank Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Branch Code"; rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field(Branch; rec.Branch)
                {
                    ApplicationArea = all;
                    Editable = false;
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
                field("Reference No."; rec."Reference No.")
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

