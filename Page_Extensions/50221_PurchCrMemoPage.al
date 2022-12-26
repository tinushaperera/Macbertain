pageextension 50221 PurchCrMemoPage extends "Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shortcut Dimension 2 Code")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
        modify("Vendor Authorization No.")
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