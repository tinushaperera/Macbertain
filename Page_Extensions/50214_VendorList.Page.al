pageextension 50214 VendorList extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Purchases (LCY)"; Rec."Purchases (LCY)")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("Last Date Modified")
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
            field("Tax Liable"; Rec."Tax Liable")
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
        modify("Purchaser Code")
        {
            Visible = true;
        }
        modify("Name 2")
        {
            Caption = 'FinAcc No';
        }
        modify("Vendor Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Payment Terms Code")
        {
            Visible = true;
        }
        modify(Blocked)
        {
            Visible = true;
        }
        modify("Last Date Modified")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}