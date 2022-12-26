pageextension 50226 PurchInvSubform extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Description 2")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Tax Group Code")
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