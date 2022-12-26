tableextension 50022 UserSetup extends "User Setup"
{
    fields
    {
        field(50000; "Customer Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Transfer Order Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Issue Note Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Check Print Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Import Loan Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Short Term Laon Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Bank Guarantee Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Promissory Note Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Quantity Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Hide Costing Data"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Hide Master Data Fields"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Sales Order Delete"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Sales Ret. Order Line Editable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50500; "Excel Date Filter"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50501; "Excel Date Filter 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50502; "Default Excel Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50503; "Material Requestion Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50504; "Activate Ship To Address"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50505; "Check Sales Header Approve"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50506; "Fix Posting to Current Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50507; "Excel Global Dim 1 Filter"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50508; "Excel Global Dim 2 Filter"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50509; "Excel Territory Code Filter"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;

            DataClassification = ToBeClassified;
        }
        field(50510; "Excel Region Code Filter"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50511; "Excel Salesperson Code Filter"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            DataClassification = ToBeClassified;
        }
        field(50512; "Sales Order Reopen Approvel"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50513; "Sales Order Delete Approvel"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50514; "Reject Editable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50515; "Cheque Print Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; Designation; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Designation));
        }
        field(50017; "Sales Order Editable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Inv. Reprint"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        Text001: Label 'The %1 Salesperson/Purchaser code is already assigned to another User ID %2.';
        Text003: Label '"You cannot have both a %1 and %2. "';
        Text005: Label 'You cannot have approval limits less than zero.';
}