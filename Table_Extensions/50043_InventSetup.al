tableextension 50043 InventorySetup extends "Inventory Setup"
{
    fields
    {
        field(50000; "MRN Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    var
        myInt: Integer;
}