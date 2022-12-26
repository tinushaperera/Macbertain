tableextension 50023 GeneralLedSetup extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Notification User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}