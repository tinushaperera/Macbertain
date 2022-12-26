tableextension 50024 SalesShipmentLine extends "Sales Shipment Line"
{
    fields
    {
        field(50000; "Free Issue Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50001; "Standard Line Discount %"; Decimal)
        {
            Caption = 'Standard Line Discount %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = ToBeClassified;
        }
        field(50002; "Maximum Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
            Caption = 'Maximum Line Discount %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50003; "Free Issue Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Free Issue Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Free Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Both; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Qty. Received"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Return Reason Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Order,Sample';
            OptionMembers = "Order",Sample;
        }
        field(50010; "Quantity Received By Stores"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Available Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Location Code" = FIELD("Location Code"), "Variant Code" = FIELD("Variant Code")));
        }
        field(50013; "Gross Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50014; "Gross Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            Enabled = false;
            MaxValue = 100;
            MinValue = 0;

            DataClassification = ToBeClassified;
        }
        field(50015; "Gross Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Gross Line Discount Amount';
            DataClassification = ToBeClassified;
        }
        field(50019; "Date-Time Released"; DateTime)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Date-Time Released" WHERE("No." = FIELD("Document No.")));
            Editable = false;
        }
        field(50025; "Discounted Gross Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "VAT Amount"; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50027; "NBT Amount"; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50028; "Region Code"; Code[10])
        {
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(50029; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            NotBlank = true;
            TableRelation = Territory;

            DataClassification = ToBeClassified;
        }
        field(50030; "Line Unit GP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}