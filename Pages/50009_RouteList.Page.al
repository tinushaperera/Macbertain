page 50009 "Route List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Reference Data";
    SourceTableView = SORTING(Type, Code)
                      ORDER(Ascending)
                      WHERE(Type = CONST(Route));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
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

