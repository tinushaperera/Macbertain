pageextension 50211 SalesPeoplePerchasers extends "Salespersons/Purchasers"
{
    layout
    {
        addafter(Name)
        {
            field(Designation; Rec.Designation)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Phone No.")
        {
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
            }
            field("Country/Region Code"; Rec."Country/Region Code")
            {
                ApplicationArea = All;
            }
            field("Reporting To"; Rec."Reporting To")
            {
                ApplicationArea = All;
            }
            field(Block; Rec.Block)
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