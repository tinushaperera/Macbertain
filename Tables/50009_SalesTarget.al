table 50009 "Sales Targets"
{

    fields
    {
        field(1; "Target Year"; Integer)
        {
        }
        field(2; "Target Month"; Integer)
        {
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                SalesPerRec: Record "Salesperson/Purchaser";
            begin
                IF SalesPerRec.GET("Salesperson Code") THEN BEGIN
                    "SalepPerson Name" := SalesPerRec.Name;
                    Designation := SalesPerRec.Designation;
                END;
            end;
        }
        field(5; "SalepPerson Name"; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(6; Designation; Code[30])
        {
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Designation));

            trigger OnValidate()
            var
                RefDataRec: Record "Reference Data";
            begin
            end;
        }
        field(7; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            NotBlank = true;
            TableRelation = Territory;

            trigger OnValidate()
            var
                TerritoryRec: Record Territory;
            begin
            end;
        }
        field(8; "Product Category Code"; Code[30])
        {
            CaptionClass = '1,2,3';
            Caption = 'Product Category Code';
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Product Category"));

            trigger OnValidate()
            var
                SlsHdrRec: Record "Sales Header";
            begin
            end;
        }
        field(9; "Target Value"; Decimal)
        {
        }
        field(10; Indentation; Integer)
        {
        }
        field(11; Totalling; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Target Year", "Target Month", "Salesperson Code", "Product Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

