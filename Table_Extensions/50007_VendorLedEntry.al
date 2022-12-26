tableextension 50007 VendorLedEntry extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Import Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Payee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Bank Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Branch Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Local,Import,Loan,Return,"Loan Return";
            OptionCaption = ' ,Local,Import,Loan,Return,Loan Return';
        }
    }
}