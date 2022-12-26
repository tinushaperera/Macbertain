tableextension 50034 ReasonCode extends "Reason Code"
{
    fields
    {
        field(50000; "Bank Chargers"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Customer Block"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Cheque Return - 2nd Instant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}