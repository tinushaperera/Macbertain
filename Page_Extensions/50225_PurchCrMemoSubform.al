pageextension 50225 PurchCrMemoSubform extends "Purch. Cr. Memo Subform"
{
    layout
    {
        modify("Return Reason Code")
        {
            Visible = true;
        }
        modify("Location Code")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}