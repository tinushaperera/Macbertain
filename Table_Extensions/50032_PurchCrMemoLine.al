tableextension 50032 PurchCrMemoLine extends "Purch. Cr. Memo Line"
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