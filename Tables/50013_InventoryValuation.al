table 50013 "Inventory Valuation"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            TableRelation = Item;
        }
        field(2; "Variant Code"; Code[20])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(3; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(5; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(6; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(7; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(8; "Assembly BOM"; Boolean)
        {
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Caption = 'Assembly BOM';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Description; Text[50])
        {
        }
        field(10; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
        field(11; "Size Description"; Text[50])
        {
        }
        field(12; "Color Description"; Text[50])
        {
        }
        field(13; "Item Cat. Description"; Text[50])
        {
        }
        field(14; "Product Group Description"; Text[50])
        {
        }
        field(15; "User ID"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Variant Code", "User ID")
        {
            Clustered = true;
        }
        key(Key2; "Inventory Posting Group")
        {
        }
    }

    fieldgroups
    {
    }
}

