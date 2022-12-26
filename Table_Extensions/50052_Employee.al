tableextension 50052 Employee extends Employee
{
    fields
    {
        field(50000; "Fuel Type"; Option)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            OptionMembers = Petrol,Diesel,"Petrol/Deisel";
        }
        field(50001; "Petrol Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Diesel Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Mobile Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "No. of Petrol Ltrs"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "No. of Diesel Ltrs"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Insurance Amount PA Cover"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Vehicle No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}