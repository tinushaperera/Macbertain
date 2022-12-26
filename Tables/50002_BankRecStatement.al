table 50002 "Bank Reconciliation Statement"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(2; Des; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Qty%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Value%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; CM; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "CM%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; SMV; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "SMV%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Qty_C; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Qty%_C"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Value_C; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Value%_C"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; CM_C; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "CM%_C"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; SMV_C; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; SerialNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Inv No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Cus No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Cus Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Bold; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Underline; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; TwoLine; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

