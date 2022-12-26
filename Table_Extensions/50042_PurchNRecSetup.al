tableextension 50042 PurchNPaybleSetup extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Import Job Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50001; "Import Jobs Entry Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Table Code"));
        }
        field(50002; "Shipping Guarentee Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50003; "Container Deposit Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50004; "Import Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 120 = R;
            Caption = 'Import Order Nos.';
            TableRelation = "No. Series".Code;
        }
        field(50005; "Loan Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 120 = R;
            Caption = 'Loan Order Nos.';
            TableRelation = "No. Series".Code;
        }
        field(50006; "Loan Return Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 120 = R;
            Caption = 'Loan Return Order Nos.';
            TableRelation = "No. Series".Code;
        }
        field(50007; "STL Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50008; "Import Loan Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    var
        myInt: Integer;
}