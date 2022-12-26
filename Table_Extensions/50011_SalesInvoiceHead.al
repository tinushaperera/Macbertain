tableextension 50011 Salesinvoicehead extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Route Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Route));
        }
        field(50001; "Temporary Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "NIC No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; SalesPersonFilter; Code[21])
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
        field(50010; "Invoice Despatch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Actual Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
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
        field(50029; "Tube Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50030; "Posted User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50031; "Dispatch No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Header"."No." WHERE("Order No." = FIELD("Order No."), "Invoice Despatch No." = FIELD("Invoice Despatch No.")));
            Editable = false;
        }
        field(50032; "VAT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."VAT Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(50033; "NBT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."NBT Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(50034; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            NotBlank = true;
            TableRelation = Territory;
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}