table 50004 "Import Jobs"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Import Job Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                IF Vendor.GET("Vendor No.") THEN
                    "Vendor Name" := Vendor.Name
                ELSE
                    "Vendor Name" := '';
            end;
        }
        field(3; "Vendor Name"; Text[50])
        {
        }
        field(4; Description; Text[100])
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; "Created User Id"; Text[50])
        {
            Editable = false;
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Released,Closed';
            OptionMembers = Open,Released,Closed;

            trigger OnValidate()
            begin
                IF Status = Status::Closed THEN
                    IF NOT AllServiceInvoicesPosted THEN
                        ERROR('All Service Invoices are not posted');
            end;
        }
        field(8; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(9; "LC No."; Code[20])
        {
        }
        field(10; Currency; Code[10])
        {
            TableRelation = Currency;
        }
        field(11; "LC Opening date"; Date)
        {
        }
        field(12; "Bank Bill No"; Code[20])
        {
        }
        field(13; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
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
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Cloud')]
    procedure TestNoSeries()
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Import Job Nos.");
    end;

    [Scope('Cloud')]
    procedure AssistEdit(): Boolean
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Import Job Nos.");
        IF NoSeriesMgt.SelectSeries(PurchSetup."Import Job Nos.", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    [Scope('Cloud')]
    procedure AllServiceInvoicesPosted(): Boolean
    var
        PurchInvRec: Record "Purch. Inv. Header";
        PurchHdr: Record "Purchase Header";
        InvCount: Integer;
        ChrgCount: Integer;
    begin
        /*InvCount := 0;
        ChrgCount := 0;
        PurchInvRec.RESET ;
        PurchInvRec.SETFILTER(PurchInvRec."Import Job No.", "No.");
        IF PurchInvRec.FINDSET THEN
          REPEAT
            InvCount += 1;
          UNTIL PurchInvRec.NEXT = 0;
        
        PurchHdr.RESET;
        PurchHdr.SETFILTER(PurchHdr."Import Job No.","No.");
        PurchHdr.SETFILTER(PurchHdr."Entry Type",'COM-INV');
        IF PurchHdr.FINDSET THEN
          REPEAT
            PurchChargRec.RESET;
            PurchChargRec.SETRANGE("Document Type" , PurchHdr."Document Type");
            PurchChargRec.SETFILTER("Document No.",PurchHdr."No.");
            PurchChargRec.SETFILTER("Charge Amount",'>%1' ,0);
            IF PurchChargRec.FINDSET THEN
              REPEAT
                ChrgCount += 1;
              UNTIL PurchChargRec.NEXT = 0;
          UNTIL PurchHdr.NEXT= 0;
        IF ChrgCount = 0 THEN
          EXIT(FALSE)
        ELSE
          IF InvCount >= ChrgCount THEN
            EXIT(TRUE)
          ELSE
            EXIT(FALSE);
         */
        EXIT(TRUE);

    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        IF PurchSetup.GET THEN;
        EXIT(PurchSetup."Import Job Nos.");
    end;
}

