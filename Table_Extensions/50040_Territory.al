tableextension 50040 Territory extends Territory
{
    fields
    {
        field(50000; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
    }

    var
        myInt: Integer;
}