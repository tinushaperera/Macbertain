table 50005 "Shipping Guarantee"
{

    fields
    {
        field(1; "Shipping Guarantee Type"; Option)
        {
            OptionCaption = 'Guarentee,Deposit,STL,Import Loan';
            OptionMembers = Guarantee,Deposit,STL,"Import Loan";
        }
        field(2; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(3; "Import Job No."; Code[20])
        {
            TableRelation = "Import Jobs"."No.";
        }
        field(4; "Deposit Receipt No."; Code[20])
        {
        }
        field(5; "Deposit Date"; Date)
        {
        }
        field(6; "Shipping Agent"; Code[10])
        {
            TableRelation = "Shipping Agent";
        }
        field(7; "Value(LCY)"; Decimal)
        {
        }
        field(8; "B\L Number"; Code[20])
        {
        }
        field(9; "Cancel Date"; Date)
        {
        }
        field(10; Remarks; Text[90])
        {
        }
        field(11; "Container No."; Code[20])
        {
            Enabled = false;
        }
        field(12; "Reimbursement Amount"; Decimal)
        {
        }
        field(13; "Cheque No."; Code[20])
        {
        }
        field(14; Bank; Code[10])
        {
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Bank));
        }
        field(15; "Reimbursement Date"; Date)
        {
        }
        field(16; Status; Option)
        {
            OptionCaption = 'Open,Released,Closed';
            OptionMembers = Open,Released,Closed;

            trigger OnValidate()
            begin
                IF Status = Status::Closed THEN;
            end;
        }
        field(17; "No. Series"; Code[10])
        {
        }
        field(18; "Facility No."; Code[20])
        {
        }
        field(19; "Maturity Date"; Date)
        {
        }
        field(20; "Ref. No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Shipping Guarantee Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", TODAY, "No.", "No. Series");
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Cloud')]
    procedure TestNoSeries()
    begin
        PurchSetup.GET;
        IF "Shipping Guarantee Type" = "Shipping Guarantee Type"::Guarantee THEN
            PurchSetup.TESTFIELD(PurchSetup."Shipping Guarentee Nos.")
        ELSE
            IF "Shipping Guarantee Type" = "Shipping Guarantee Type"::Deposit THEN
                PurchSetup.TESTFIELD(PurchSetup."Container Deposit Nos.")
            ELSE
                IF "Shipping Guarantee Type" = "Shipping Guarantee Type"::STL THEN
                    PurchSetup.TESTFIELD(PurchSetup."STL Nos.")
                ELSE
                    IF "Shipping Guarantee Type" = "Shipping Guarantee Type"::"Import Loan" THEN
                        PurchSetup.TESTFIELD(PurchSetup."Import Loan Nos.");
    end;

    [Scope('Cloud')]
    procedure AssistEdit(): Boolean
    begin

        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        CASE "Shipping Guarantee Type" OF
            "Shipping Guarantee Type"::Guarantee:
                EXIT(PurchSetup."Shipping Guarentee Nos.");
            "Shipping Guarantee Type"::Deposit:
                EXIT(PurchSetup."Container Deposit Nos.");
            "Shipping Guarantee Type"::STL:
                EXIT(PurchSetup."STL Nos.");
            "Shipping Guarantee Type"::"Import Loan":
                EXIT(PurchSetup."Import Loan Nos.");
        END;
    end;
}

