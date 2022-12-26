table 50007 "Product Category"
{

    fields
    {
        field(1; "Product Category Code"; Code[30])
        {

            trigger OnValidate()
            var
                RefData: Record "Reference Data";
            begin
                IF RefData.GET(RefData.Type::"Product Category", "Product Category Code") THEN
                    "Global Dimension 1 Code" := RefData."Global Dimension 1 Code";  //Get BU
            end;
        }
        field(2; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            var
                DimValueRec: Record "Dimension Value";
            begin
                DimValueRec.RESET;
                DimValueRec.SETFILTER("Global Dimension No.", '%1', 3);
                DimValueRec.SETFILTER(Code, "Shortcut Dimension 3 Code");
                IF DimValueRec.FINDFIRST THEN
                    Description := DimValueRec.Name;
            end;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; Description; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Product Category Code", "Shortcut Dimension 3 Code")
        {
            Clustered = true;
        }
        key(Key2; "Shortcut Dimension 3 Code", "Global Dimension 1 Code")
        {
        }
    }

    fieldgroups
    {
    }
}

