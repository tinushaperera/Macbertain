tableextension 50008 ItemExt extends Item
{
    fields
    {
        field(50000; "QC-Check-Need"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
        }
        field(50001; "Tax Group Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tax Group".Code;
        }
        field(50002; "Old Item Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Shortcut Dimension 3 Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = FILTER('PRODUCT TYPE'), "No." = FIELD("No.")));
            Editable = false;
        }
        field(50004; "MCB Product Group Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MCB Product Group".Code;
        }
    }
    fieldgroups
    {
        addlast(DropDown; Inventory) { }
    }
    var
        myInt: Integer;
}