tableextension 50002 GlAccountExt extends "G/L Account"
{
    fields
    {
        field(50000; "Cost Scenario 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Cost Scenario 3"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Cost Scenario 4"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Cost Scenario 5"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Sales Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Cost Mgt Sales Acc"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Debtors Acc"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "NAV A/C"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Account Type") { }
    }

    var
        myInt: Integer;
}