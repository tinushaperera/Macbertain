pageextension 50210 PaymentTermss extends "Payment Terms"
{
    layout
    {
        addafter(Description)
        {
            field("Customer Payment Term"; Rec."Customer Payment Term")
            {
                ApplicationArea = All;
            }
            field("Vendor Payment Term"; Rec."Vendor Payment Term")
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