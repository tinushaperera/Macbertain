tableextension 50031 PurchCrMemohead extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50000; "Import Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Import Jobs"."No.";
        }
        field(50001; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Local,Import,Loan,Return,Loan Return';
            OptionMembers = "Local",Import,Loan,Return,"Loan Return";
        }
        field(50003; "Shipping Ref. No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Create User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Create Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "GRN Invoice No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}