tableextension 50001 salesPersonPurchaseExt extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; Designation; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code where(Type = const(Designation));

            trigger OnValidate()
            var
                refRec: Record "Reference Data";
            begin
                if refRec.Get(refRec.Type::Designation, Designation) then
                    "Job Title" := refRec.Description
                else
                    "Job Title" := '';
            end;
        }
        field(50001; "Territory Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Territory.Code;

            trigger OnValidate()
            var
                terrRec: Record Territory;
            begin
                terrRec.Reset();
                if terrRec.Get("Territory Code") then
                    "Country/Region Code" := terrRec."Country/Region Code";
            end;
        }
        field(50002; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;
            Editable = false;
        }
        field(50003; "Reporting To"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50004; Expense; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}