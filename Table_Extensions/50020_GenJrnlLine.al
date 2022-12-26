tableextension 50020 GenJrnlLine extends "Gen. Journal Line"
{
    // DrillDownPageId = "PD Cheque List";
    fields
    {
        field(50000; "Payee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Region Code"; Code[10])
        {
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(50003; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = ToBeClassified;
        }
        field(50005; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            NotBlank = true;
            TableRelation = Territory;
            DataClassification = ToBeClassified;
        }
        field(50006; "Bank Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Temp. Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Unidentified Deposit No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Unidentified Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Entry"."Entry No." WHERE("G/L Account No." = FILTER(30140), "Document Type" = FILTER(Payment), Applied = CONST(false));

            trigger OnValidate()
            var
                GLEnty: Record "G/L Entry";
            begin
                //RJ(-)
                GLEnty.RESET;
                GLEnty.SETRANGE("Entry No.", "Unidentified Entry No.");
                GLEnty.FINDFIRST;
                "Unidentified Deposit No." := GLEnty."Document No.";
                VALIDATE(Amount, (GLEnty.Amount * -1));
                VALIDATE("Bal. Account No.", GLEnty."G/L Account No.");
                //RJ(+)
            end;
        }
        field(50010; "Customer Block"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.07';
            Editable = false;
        }
        field(50011; "3rd Party Cheque"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.08';
        }
        field(50012; "PD Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.09';
        }
        field(50013; Checked; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.10';
            Editable = false;
        }
        field(50014; Confirmed; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.11';
            Editable = false;
        }
        field(50015; "CF-Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.12';
            TableRelation = "Reference Data".Code WHERE(Type = CONST("CF-Type"));
        }
        field(50016; "Cheque Received Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.13';
        }
        field(50017; "Import Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'RJ0.14';
            TableRelation = "Import Jobs"."No." WHERE("Vendor No." = FIELD("Account No."));
        }
        field(50018; "Cost Mgt. Ration"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Cost Mgt. Calculation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                EmpRec: Record Employee;
            begin
                IF "Employee No." <> '' THEN
                    IF EmpRec.GET("Employee No.") THEN
                        "Salespers./Purch. Code" := EmpRec."Salespers./Purch. Code";
            end;
        }
        field(50021; "Expense Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Mobile,Fuel';
            OptionMembers = General,Mobile,Fuel;
        }
        field(50022; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Bank Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Bank Code"));

            trigger OnValidate()
            var
                RefRec: Record "Reference Data";
            begin
            end;
        }
        field(50024; "Branch Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Branch Code"), "Bank Code" = FIELD("Bank Code"));
        }
        field(50025; "Acc. Balance"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Account No.")));
        }
        field(50026; "D/C No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Local,Import,Loan,Return,Loan Return';
            OptionMembers = "Local",Import,Loan,Return,"Loan Return";
        }
        field(50028; "Cheque Print Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                // UserSetup.GET(USERID);
                // IF NOT UserSetup."Cheque Print Approval" THEN
                //     ERROR('You do not have permission');
            end;
        }
        modify("Account No.")
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting), Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer WHERE(Blocked = FILTER('<>New'))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner";

            trigger OnAfterValidate()
            var
                Cust: Record Customer;
            begin
                if "Account Type" = "Account Type"::Customer then begin
                    if "Account No." <> '' then begin
                        Cust.Get("Account No.");
                        "Region Code" := Cust."Region Code"; //RJ
                        "Territory Code" := Cust."Territory Code"; //RJ
                        UpdateDocNo;
                    end;
                end;
            end;
        }
        modify("Salespers./Purch. Code")
        {
            trigger OnAfterValidate()
            var
                cust: Record Customer;
            begin
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF Cust.GET("Account No.") THEN
                        IF ("Salespers./Purch. Code" <> Cust."Salesperson Code") AND ("Salespers./Purch. Code" <> Cust."Salesperson Code 2") THEN
                            ERROR('Sales Person sholud be Linekd to Customer : %1 .', Cust.Name);
                END;
                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN BEGIN
                    IF Cust.GET("Bal. Account No.") THEN
                        IF ("Salespers./Purch. Code" <> Cust."Salesperson Code") AND ("Salespers./Purch. Code" <> Cust."Salesperson Code 2") THEN
                            ERROR('Sales Person sholud be Linekd to Customer : %1 .', Cust.Name);
                end;
            end;
        }
        modify("Reason Code")
        {
            trigger OnAfterValidate()
            var
                ResonRec: Record "Reason Code";
            begin
                //RJ(-)
                ResonRec.RESET;
                ResonRec.SETRANGE(Code, "Reason Code");
                ResonRec.FINDFIRST;
                "Customer Block" := ResonRec."Customer Block";
                //RJ(+)
            end;
        }
        modify("Bal. Account No.")
        {
            trigger OnAfterValidate()
            begin
                if "Bal. Account Type" = "Bal. Account Type"::"Bank Account" then
                    if "Bal. Account No." <> '' then
                        UpdateExDocNo;
            end;
        }

    }
    keys
    {
        key(FK; "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code") { }
    }
    PROCEDURE UpdateExDocNo()
    VAR
        GenBathName: Record "Gen. Journal Batch";
        SalesRecSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccRec: Record "Bank Account";
        "Pay-Temp": Boolean;
        NoSeriesCode: Code[10];
    BEGIN
        IF ("Account No." = '') OR (xRec."Account No." <> '') THEN
            EXIT;
        GenBathName.RESET;
        GenBathName.SETRANGE("Bal. Account Type", GenBathName."Bal. Account Type"::"Bank Account");
        IF GenBathName.FINDSET THEN
            REPEAT
                BankAccRec.GET(GenBathName."Bal. Account No.");
                NoSeriesMgt.InitSeries(BankAccRec."Cheque Nos.",
                    xRec."External Document No.", 0D, "External Document No.", NoSeriesCode);
            UNTIL GenBathName.NEXT = 0;
    END;

    PROCEDURE UpdateDocNo()
    VAR
        GenJurTemp: Record "Gen. Journal Template";
        SalesRecSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "PD-Temp": Boolean;
        NoSeriesCode: Code[10];
    BEGIN
        IF ("Account No." = '') OR (xRec."Account No." <> '') THEN
            EXIT;
        "PD-Temp" := FALSE;
        GenJurTemp.RESET;
        GenJurTemp.SETRANGE(Type, GenJurTemp.Type::"PD Cheque");
        IF GenJurTemp.FINDSET THEN
            REPEAT
                IF GenJurTemp.Name = "Journal Template Name" THEN
                    "PD-Temp" := TRUE;
            UNTIL GenJurTemp.NEXT = 0;

        IF NOT "PD-Temp" THEN
            EXIT;
        "Document No." := '';
        SalesRecSetup.GET;
        SalesRecSetup.TESTFIELD("PD Cheque Doc. Nos.");
        NoSeriesMgt.InitSeries(SalesRecSetup."PD Cheque Doc. Nos.",
            xRec."Document No.", 0D, "Document No.", NoSeriesCode);
        VALIDATE("Document No.");
    END;

    PROCEDURE CreateBankChargesLine()
    VAR
        GenJnlLine: Record "Gen. Journal Line";
        BankAcc: Record "Bank Account";
        GenJnlLine2: Record "Gen. Journal Line";
        LineNo: Integer;
    BEGIN
        GenJnlLine2.RESET;
        GenJnlLine2.SETFILTER("Journal Template Name", "Journal Template Name");
        GenJnlLine2.SETFILTER("Journal Batch Name", "Journal Batch Name");
        IF GenJnlLine2.FINDLAST THEN
            LineNo := GenJnlLine2."Line No."
        ELSE
            LineNo := 0;
        BankAcc.GET("Bal. Account No.");
        GenJnlLine.INIT;
        GenJnlLine.VALIDATE("Journal Template Name", "Journal Template Name");
        GenJnlLine.VALIDATE("Journal Batch Name", "Journal Batch Name");
        GenJnlLine.VALIDATE("Line No.", LineNo + 1000);
        GenJnlLine.VALIDATE("Posting Date", "Posting Date");
        GenJnlLine.VALIDATE("Account Type", "Account Type");
        GenJnlLine.VALIDATE("Account No.", "Account No.");
        GenJnlLine.VALIDATE(Description, Description);
        GenJnlLine.VALIDATE(Amount, BankAcc."Bank Charges");
        GenJnlLine.VALIDATE("Bal. Account Type", "Bal. Account Type");
        GenJnlLine.VALIDATE("Bal. Account No.", "Bal. Account No.");
        GenJnlLine.INSERT;
    END;

    var
        myInt: Integer;
}