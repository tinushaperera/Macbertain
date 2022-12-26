page 50021 "Import Jobs List"
{
    CardPageID = "Import Job Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Import Jobs";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Created User Id"; rec."Created User Id")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("TEST Excel")
            {
                Visible = false;

                trigger OnAction()
                var
                    inc: Codeunit "Incentive Management";
                begin

                    inc.CreateExcelSheet;
                end;
            }
        }
    }
}

