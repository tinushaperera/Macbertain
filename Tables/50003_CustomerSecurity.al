table 50003 "Customer Security"
{

    fields
    {
        field(1; "Security Type"; Option)
        {
            OptionMembers = "Bank Guarantee","Promissory Note";
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3; "Bank Code"; Code[30])
        {
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Bank Code"));

            trigger OnValidate()
            var
                RefRec: Record "Reference Data";
            begin
                RefRec.RESET;
                IF RefRec.GET(RefRec.Type::"Bank Code", "Bank Code") THEN
                    "Bank Name" := RefRec.Description;
            end;
        }
        field(4; "Bank Name"; Text[60])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Strat Date"; Date)
        {
        }
        field(7; "End Date"; Date)
        {
        }
        field(8; Active; Boolean)
        {
        }
        field(9; "Reference No."; Code[20])
        {
        }
        field(10; Branch; Text[30])
        {
        }
        field(11; "Branch Code"; Code[20])
        {
            TableRelation = "Reference Data".Code WHERE("Bank Code" = FIELD("Bank Code"),
                                                         Type = FILTER("Branch Code"));

            trigger OnValidate()
            var
                RefRec: Record "Reference Data";
            begin
                RefRec.RESET;
                IF RefRec.GET(RefRec.Type::"Branch Code", "Branch Code") THEN
                    Branch := RefRec.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "Security Type", "Customer No.", "Reference No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

