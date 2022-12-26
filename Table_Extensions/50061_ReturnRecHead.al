tableextension 50061 ReturnRecHead extends "Return Receipt Header"
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
        field(50019; "Remarks-2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Order Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Approved Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Quantity Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Quantity Approved Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}