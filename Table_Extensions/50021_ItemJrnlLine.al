tableextension 50021 ItemJrnlExt extends "Item Journal Line"
{
    fields
    {
        field(50000; "Import Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sales Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Description 2"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."Description 2" WHERE("Item No." = FIELD("Item No."), Code = FIELD("Variant Code")));
            Editable = false;
        }
    }

    var
        myInt: Integer;
}