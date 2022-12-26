tableextension 50016 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
        field(50000; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(FK; "Document Type", Type, "No.", "Variant Code")
        { }
    }

    var
        myInt: Integer;
}