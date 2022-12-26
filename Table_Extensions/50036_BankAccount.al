tableextension 50036 BankAccount extends "Bank Account"
{
    fields
    {
        field(50000; "Cheque Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Bank Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}