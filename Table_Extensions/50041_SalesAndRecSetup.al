tableextension 50041 SalesNRecSetup extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Free Issue Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Purchasing.Code;
        }
        field(50001; "Debit Note Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50002; "Sample Issue Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sample Issue Nos.';
            TableRelation = "No. Series";
        }
        field(50003; "PD Cheque Doc. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "Invoice & Dispatch Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50005; "Overdue Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Overdue Approval Age"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Overdue Days to Block Customer"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Sales Order Entry Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Table Code"));
        }
        field(50009; "Sales Return Entry Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Table Code"));
        }
        field(50010; "Sample Order Entry Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Table Code"));
        }
        field(50011; "Not Standard Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Last Incetive Paid Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Last Incentive Paid Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Debit Note Posting Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50015; "Overdue Thold to Block Cust."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Current Salary Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Current Salary Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}