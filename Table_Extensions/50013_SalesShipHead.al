tableextension 50013 SalesShiphead extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Invoice Despatch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "NIC No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50006; "SVAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Credit Limit Check"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Credit Limit Check';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            BlankNumbers = BlankZero;
            BlankZero = true;
            OptionCaption = 'Order,Sample';
            OptionMembers = "Order",Sample;
        }
        field(50014; "Create User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Entry Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Table Code"));
        }
        field(50016; "Last Date-Time Modified"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Date-Time Modified';
            Editable = false;
        }
        field(50017; "Last Modified User ID"; Code[50])
        {
            Caption = 'Last Modified By ID';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = ToBeClassified;
        }
        field(50018; "Date-Time Created"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Released User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Date-Time Released"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Route Code2"; Code[30])
        {
            CalcFormula = Lookup("Ship-to Address"."Route Code 2" WHERE(Code = FIELD("Ship-to Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Route Code3"; Code[30])
        {
            CalcFormula = Lookup("Ship-to Address"."Route Code 3" WHERE(Code = FIELD("Ship-to Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Route Code4"; Code[30])
        {
            CalcFormula = Lookup("Ship-to Address"."Route Code 4" WHERE(Code = FIELD("Ship-to Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "Tube Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50032; "VAT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line"."VAT Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(50033; "NBT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line"."NBT Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(50034; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            NotBlank = true;
            TableRelation = Territory;
        }
    }

    var
        myInt: Integer;
}