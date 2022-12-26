tableextension 50028 PurchRcptLine extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}