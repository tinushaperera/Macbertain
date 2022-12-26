tableextension 50037 BankAccountLed extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Payee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Temp. Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Cheque Received Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "PD Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Unidentified Deposit No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Unidentified Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "3rd Party Cheque"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Bank Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Branch Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "D/C No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}