pageextension 50218 ItemJrnl extends "Item Journal"
{
    layout
    {
        modify("Document Date")
        {
            Visible = true;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        modify(Amount)
        {
            Editable = false;
        }
        modify("Reason Code")
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