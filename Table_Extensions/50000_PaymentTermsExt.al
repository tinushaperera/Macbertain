tableextension 50000 PaymentTermsExt extends "Payment Terms"
{
    fields
    {
        field(50000; "Customer Payment Term"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Vendor Payment Term"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}