pageextension 50228 SalesCrMemoSubForm extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Description 2")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Tax Category")
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