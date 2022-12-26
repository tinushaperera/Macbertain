pageextension 50200 SalesPersonPurchaserExt extends "Salesperson/Purchaser Card"
{
    layout
    {
        modify("Job Title")
        {
            Editable = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}