table 50000 "Reference Data"
{

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Customer Security Details,Designation,Bank Code,CF-Type,Route,Bank,Table Code,Product Category,Incentive Column,Branch Code';
            OptionMembers = " ","Customer Security Details",Designation,"Bank Code","CF-Type",Route,Bank,"Table Code","Product Category","Incentive Column","Branch Code";
        }
        field(2; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Bank Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Bank Code"));
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

