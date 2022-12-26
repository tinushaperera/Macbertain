tableextension 50060 ReturnShipHead extends "Return Shipment Header"
{
    fields
    {
        field(50004; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Vehicle No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}