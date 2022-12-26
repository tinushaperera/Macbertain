tableextension 50030 PurchInvLine extends "Purch. Inv. Line"
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