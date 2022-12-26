tableextension 50063 SalesLineDiscount extends "Sales Line Discount"
{
    fields
    {
        field(50000; "Payment Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }
        field(50001; "Free Issue Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50002; "Maximum Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
            Caption = 'Maximum Line Discount %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50003; Both; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Item Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD(Code)));
            Editable = false;
        }
    }
    keys
    {
        key(FK; "Payment Method")
        { }
    }

    var
        myInt: Integer;
}