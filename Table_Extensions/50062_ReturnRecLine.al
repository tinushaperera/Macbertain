tableextension 50062 ReturnRecLine extends "Return Receipt Line"
{
    fields
    {
        field(50008; "Return Reason Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Quantity Received By Stores"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}