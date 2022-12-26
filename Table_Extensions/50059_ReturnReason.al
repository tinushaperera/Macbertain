tableextension 50059 ReturnReason extends "Return Reason"
{
    fields
    {
        field(50000; "Return Type"; Option)
        {
            OptionCaption = 'Sales Return,Purchase Return';
            OptionMembers = "Sales Return","Purchase Return";
        }
    }

    var
        myInt: Integer;
}