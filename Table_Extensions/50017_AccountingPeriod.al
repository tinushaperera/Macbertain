tableextension 50017 AccountPeriod extends "Accounting Period"
{
    fields
    {
        field(50000; "Cost Senario 2 Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Cost Senario 3 Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Cost Senario 4 Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Cost Senario 5 Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}