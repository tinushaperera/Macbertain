table 50016 "Web Service 1"
{
    Caption = 'Web Service';
    DataPerCompany = false;

    fields
    {
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,,,,,"Codeunit",,,"Page","Query",,,,,,,,,,;
            OptionCaption = ',,,,,Codeunit,,,Page,Query,,,,,,,,,,';
        }
        field(6; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = FIELD("Object Type"));
        }
        field(9; "Service Name"; Text[250])
        {
            Caption = 'Service Name';
        }
        field(12; Published; Boolean)
        {
            Caption = 'Published';
        }
        field(13; ExcludeFieldsOutsideRepeater; Boolean)
        {
            Caption = 'Exclude Fields Outside of the Repeater from ETag';
        }
        field(14; ExcludeNonEditableFlowFields; Boolean)
        {
            Caption = 'Exclude Non-Editable Flow Fields from ETag';
        }
        field(50000; "Excel Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Object Type", "Service Name")
        {
            Clustered = true;
        }
        key(Key2; "Object Type", "Object ID")
        {
        }
    }

    fieldgroups
    {
    }
}

