tableextension 50044 TaxArea extends "Tax Area"
{
    fields
    {
        field(50000; "VAT No. Mandotory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "NBT No. Mandotory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "SVAT No. Mandotory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Foreign Partner Tax Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}