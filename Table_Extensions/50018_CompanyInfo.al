tableextension 50018 CompanyInfo extends "Company Information"
{
    fields
    {
        field(50000; "SVAT No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "SVAT Pecerntage(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}