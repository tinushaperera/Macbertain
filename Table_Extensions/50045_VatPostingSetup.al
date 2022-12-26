tableextension 50045 VatPostingSetup extends "VAT Posting Setup"
{
    fields
    {
        field(50000; "SVAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}