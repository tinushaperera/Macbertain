pageextension 50216 AppliedCustomerEntries extends "Applied Customer Entries"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Document Date"; Rec."Document Date")
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