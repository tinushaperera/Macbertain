pageextension 50213 VendorLedEntries extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
        }
        addafter("Exported to Payment File")
        {
            field("Import Job No."; Rec."Import Job No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Global Dimension 1 Code")
        {
            Visible = true;
            Editable = false;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
            Editable = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}