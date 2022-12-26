tableextension 50003 GLEntry extends "G/L Entry"
{
    fields
    {
        field(50000; "Temp. Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Salespers./Purch. Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50002; "Expense Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",General,Mobile,Fuel;
            OptionCaption = ' ,General,Mobile,Fuel';
        }
        field(50003; "Import Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Bank Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code where(Type = const("Bank Code"));
        }
        field(50006; "Branch Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code where(Type = const("Branch Code"), "Bank Code" = field("Bank Code"));
        }
        field(50007; Applied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Payee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Unidentified Deposit No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Unidentified Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50013; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Local,Import,Loan,Return,"Loan Return";
            OptionCaption = ' ,Local,Import,Loan,Return,Loan Return';
        }
    }
    keys
    {
        key(FK; "Global Dimension 1 Code", "Global Dimension 2 Code") { }
    }
    var
        myInt: Integer;
}