page 50008 "Salesperson List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Salesperson/Purchaser";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field("Reporting To"; Rec."Reporting To")
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

