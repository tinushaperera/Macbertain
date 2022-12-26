tableextension 50038 BankAccRec extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "External Document No."; Code[35])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}