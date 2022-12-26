tableextension 50009 ItemLedEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Import Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Item Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
        }
        field(50002; "Sales Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


}