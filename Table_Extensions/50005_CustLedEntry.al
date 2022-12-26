tableextension 50005 CustLedEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Sell-to Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(50003; "Territory Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Territory;
            NotBlank = false;
        }
        field(50004; "Bank Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Temp. Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Unidentified Deposit No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Customer Block"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "3rd Party Cheque"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Cheque Received Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "PD Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Bank Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Bank Code"));
        }
        field(50012; "Branch Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Branch Code"), "Bank Code" = FIELD("Bank Code"));
        }
        field(50013; "Unidentified Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "D/C No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Reason Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Reason Code".Description WHERE(Code = FIELD("Reason Code")));
            NotBlank = false;
        }
        field(50028; "Cheque Retun Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}