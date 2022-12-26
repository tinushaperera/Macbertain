tableextension 50026 SalesCrMemoLine extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50000; "Free Issue Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50001; "Standard Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Standard Line Discount %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
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
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "NBT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
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
        field(52000; "Product Category Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52001; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard));

        }
        field(52002; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
    }

    var
        myInt: Integer;
}