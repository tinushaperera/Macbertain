pageextension 50208 GLAccountList extends "G/L Account List"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
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