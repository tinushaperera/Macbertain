tableextension 50004 CustomerEXT extends Customer
{
    fields
    {
        field(50000; "Business Registration No."; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
                RecCount: Integer;
            begin
                //<Chin 26/0/2016
                TESTFIELD("Partner Type");
                IF "Partner Type" = "Partner Type"::Company THEN BEGIN
                    CustomerRec.RESET;
                    CustomerRec.SETFILTER("Business Registration No.", "Business Registration No.");
                    RecCount := 0;
                    IF CustomerRec.FINDSET THEN BEGIN
                        REPEAT
                            IF CustomerRec."No." <> "No." THEN
                                ERROR(' S"me Business Registration No. in Customer No. : %1', CustomerRec."No.");
                        UNTIL CustomerRec.NEXT = 0;
                    END;
                    TESTFIELD("Business Registration No.");
                END;
                //> Chin
            end;
        }
        field(50001; "NIC No."; Text[12])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
                RecCount: Integer;
                strLast: Text[1];
            begin
                //<Chin 26/0/2016
                TESTFIELD("Partner Type");
                IF "Partner Type" = "Partner Type"::Person THEN BEGIN
                    CustomerRec.RESET;
                    CustomerRec.SETFILTER("NIC No.", "NIC No.");
                    RecCount := 0;
                    IF CustomerRec.FINDSET THEN BEGIN
                        REPEAT
                            IF CustomerRec."No." <> "No." THEN
                                ERROR(' Same NIC No. in Customer No. : %1', CustomerRec."No.");
                        UNTIL CustomerRec.NEXT = 0;
                    END;

                    //Validating NIC No.
                    IF (STRLEN("NIC No.") <> 10) AND (STRLEN("NIC No.") <> 12) THEN
                        ERROR('NIC No. Should have 10 or 12 Characters');
                    IF ((STRLEN("NIC No.") = 10)) THEN BEGIN
                        IF (EVALUATE(RecCount, COPYSTR("NIC No.", 1, 9)) = FALSE) THEN
                            ERROR(' NIC No. has some invalid Characters');
                        strLast := COPYSTR("NIC No.", 10, 1);
                        IF (strLast <> 'x') AND (strLast <> 'X') AND (strLast <> 'v') AND (strLast <> 'V') THEN
                            ERROR('the Character should be ''x'',''X'',''v'' OR ''V''');
                    END;
                END;
                //> Chin
            end;
        }
        field(50002; "Industry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Manufacture,Trading;
            OptionCaption = ' ,Manufacture,Trading';
            NotBlank = true;
        }
        field(50003; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50004; "NBT Registration No."; Text[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                //<Chin 20160718 1210
                IF ("NBT Registration No." <> xRec."NBT Registration No.")
                  AND (STRLEN("NBT Registration No.") <> 0)
                  AND (STRLEN("NBT Registration No.") <> 14) THEN
                    ERROR(' %1 format not correct', FIELDCAPTION("NBT Registration No."));
                //>
            end;
        }
        field(50005; "SVAT Registration No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Salesperson Code 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate()

            begin
                //<Chin 26/01/2016
                TESTFIELD("Salesperson Code");
                IF "Salesperson Code" = "Salesperson Code 2" THEN
                    ERROR('Cannot have the same Sales person Code for both Sales persons');
                //> 
            end;
        }
        field(50007; "Bank Guarantee Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Customer Security".Amount WHERE("Security Type" = CONST("Bank Guarantee"), Active = CONST(true), "Customer No." = FIELD("No.")));
            Editable = false;
        }
        field(50008; "Promissory Note Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Customer Security".Amount WHERE("Security Type" = CONST("Promissory Note"), Active = CONST(true), "Customer No." = FIELD("No.")));
            Editable = false;
        }
        field(50009; "Route Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code where(Type = const(Route));
            trigger OnLookup()
            var
                RouteRec: Record "Reference Data";
                ShipToAddressRec: Record "Ship-to Address";
            begin
                ShipToAddressRec.SETFILTER("Customer No.", "No.");
                IF ShipToAddressRec.FINDFIRST THEN BEGIN
                    FILTERGROUP(2);
                    RouteRec.SETRANGE(Type, RouteRec.Type::Route);
                    RouteRec.SETFILTER(Code, '%1|%2|%3|%4', ShipToAddressRec."Route Code", ShipToAddressRec."Route Code 2", ShipToAddressRec."Route Code 3", ShipToAddressRec."Route Code 4");
                    FILTERGROUP(0);
                    IF PAGE.RUNMODAL(50009, RouteRec) = ACTION::LookupOK THEN
                        "Route Code" := RouteRec.Code;
                END
                ELSE BEGIN
                    ERROR('Set Ship-To Address first !');
                END;
            end;
        }
        field(50010; "Customer Registered Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Customer Grade"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",A1,A2,A3,A4,A5;
            OptionCaption = ' ,A1,A2,A3,A4,A5';
        }
        field(50012; "PD Check Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Gen. Journal Line".Amount WHERE("Journal Template Name" = CONST('PD CHEQUE'), "Account No." = FIELD("No.")));
        }
        field(50013; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Date Filter 2"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50015; "Overdue Invoice Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter 2")));
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(50016; "Ship to Address Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Ship-to Address" WHERE("Customer No." = FIELD("No.")));
            Editable = false;
        }
        field(50017; "Last Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Blocked Reason"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = None,Manual,"Over Due";
            OptionCaption = 'None,Manual,"Over Due';
        }
        field(50019; "Prevent Cus.Statement Print"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Balance As At (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter 2")));
        }
        field(50021; Reject; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                VALIDATE(Blocked, Blocked::All);
                IF NOT Reject THEN
                    IF "Reject Reason" <> '' THEN
                        ERROR('Reject reason must be blank.');
            end;
        }
        field(50022; "Reject Reason"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        modify("Territory Code")
        {
            trigger OnAfterValidate()
            var
                TetRec: Record Territory;
            begin

                TetRec.Reset();
                if TetRec.Get("Territory Code") then
                    "Region Code" := TetRec."Country/Region Code";
            end;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                salesPer: Record "Salesperson/Purchaser";
            begin
                if "Salesperson Code" = "Salesperson Code 2" then
                    ERROR('Cannot have the same Sales person Code for both Sales persons');

                salesPer.RESET;
                if salesPer.Get("Salesperson Code") then begin
                    Validate("Territory Code", salesPer."Territory Code");
                end;
            end;
        }
        modify("Country/Region Code")
        {
            trigger OnAfterValidate()
            var
                country: Record "Country/Region";
            begin
                if country.Get("Country/Region Code") then
                    County := country.Name;
            end;
        }
        modify("VAT Registration No.")
        {
            trigger OnAfterValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
                VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
            begin
                //<Chin 20160718 1209
                IF ("VAT Registration No." <> xRec."VAT Registration No.")
                  AND (STRLEN("VAT Registration No.") <> 0)
                  AND (STRLEN("VAT Registration No.") <> 14) THEN
                    ERROR(' %1 format not correct', FIELDCAPTION("VAT Registration No."));
                //>
            end;
        }
        modify("Payment Terms Code")
        {
            TableRelation = "Payment Terms".Code where("Customer Payment Term" = const(true));
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()

            begin
                IF Blocked = Rec.Blocked::" " THEN
                    "Blocked Reason" := "Blocked Reason"::None
                ELSE
                    IF "Blocked Reason" = "Blocked Reason"::None THEN
                        "Blocked Reason" := "Blocked Reason"::Manual;
            end;
        }
        modify("Partner Type")
        {
            trigger OnAfterValidate()
            var
                TaxAreaRec: Record "Tax Area";
            begin
                IF "Partner Type" = "Partner Type"::Foreign THEN BEGIN
                    TaxAreaRec.RESET;
                    TaxAreaRec.SETFILTER(TaxAreaRec."Foreign Partner Tax Code", '%1', TRUE);
                    IF TaxAreaRec.FINDFIRST THEN
                        "Tax Area Code" := TaxAreaRec.Code;
                END;
            end;
        }

    }
    fieldgroups
    {
        addlast(DropDown; "Salesperson Code", "Currency Code", "Global Dimension 1 Code", Balance, "Credit Limit (LCY)", "Tax Area Code", Address, "Address 2") { }
    }
    PROCEDURE NewCustomer(): Boolean;
    BEGIN
        IF Rec.Blocked = Blocked::New THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    END;

    PROCEDURE GetCreditExposure(): Decimal;
    VAR
        varCrExp: Decimal;
    BEGIN
        //Credit Exposure = Out Standing Balance - (Bank Guarantee + Promissory Notes + Post Dated Cheques in Hand)
        varCrExp := "Balance (LCY)" - "Bank Guarantee Amount" - "Promissory Note Amount" - "PD Check Amount";
        EXIT(varCrExp);
    END;

    PROCEDURE CheckNotBlankFields();
    VAR
        varCustomerRec: Record Customer;
        varCustMetaData: RecordRef;
        TaxAreaRec: Record "Tax Area";
    BEGIN
        IF "Bill-to Customer No." = '' THEN
            "Bill-to Customer No." := "No.";
        TESTFIELD("No.");
        TESTFIELD(Name);
        TESTFIELD(Address);
        //TESTFIELD("Address 2");
        TESTFIELD(City);
        TESTFIELD(Contact);
        TESTFIELD("Phone No.");
        TESTFIELD("Territory Code");
        TESTFIELD("Global Dimension 1 Code");
        TESTFIELD("Global Dimension 2 Code");
        TESTFIELD("Credit Limit (LCY)");
        TESTFIELD("Customer Posting Group");
        //TESTFIELD("Currency Code");
        TESTFIELD("Customer Price Group");
        TESTFIELD("Payment Terms Code");
        TESTFIELD("Salesperson Code");
        TESTFIELD("Shipment Method Code");
        //TESTFIELD("Customer Disc. Group");
        TESTFIELD("Country/Region Code");
        TESTFIELD("Payment Method Code");
        TESTFIELD("Post Code");
        TESTFIELD(County);
        TESTFIELD("Tax Area Code");
        //TESTFIELD("Tax Liable");
        TESTFIELD("VAT Bus. Posting Group");
        TESTFIELD("Partner Type");
        IF "Partner Type" = "Partner Type"::Company THEN
            TESTFIELD("Business Registration No.");
        IF "Partner Type" = "Partner Type"::Person THEN
            TESTFIELD("NIC No.");
        IF "Partner Type" = "Partner Type"::Foreign THEN BEGIN
            TESTFIELD("Currency Code");
            TaxAreaRec.RESET;
            TaxAreaRec.SETFILTER(TaxAreaRec."Foreign Partner Tax Code", '%1', TRUE);
            IF TaxAreaRec.FINDFIRST THEN
                IF "Tax Area Code" <> TaxAreaRec.Code THEN
                    "Tax Area Code" := TaxAreaRec.Code;
        END;

        TESTFIELD("Industry Type");
        TESTFIELD("Region Code");
        IF TaxAreaRec.GET("Tax Area Code") THEN BEGIN
            IF TaxAreaRec."VAT No. Mandotory" THEN BEGIN
                TESTFIELD("VAT Registration No.");
                IF STRLEN("VAT Registration No.") < 4 THEN
                    ERROR('VAT Registration No. format is incorrect.')
                ELSE
                    IF COPYSTR("VAT Registration No.", STRLEN("VAT Registration No.") - 4, 5) <> '-7000' THEN
                        ERROR('VAT Registration No. format is incorrect.');
            END;
            IF TaxAreaRec."NBT No. Mandotory" THEN BEGIN
                TESTFIELD("NBT Registration No.");
                IF STRLEN("NBT Registration No.") < 4 THEN
                    ERROR('NBT Registration No. format is incorrect.')
                ELSE
                    IF COPYSTR("NBT Registration No.", STRLEN("NBT Registration No.") - 4, 5) <> '-9000' THEN
                        ERROR('NBT Registration No. format is incorrect.');
            END;
            IF TaxAreaRec."SVAT No. Mandotory" THEN
                TESTFIELD("SVAT Registration No.");
        END;
        IF "Partner Type" = "Partner Type"::Proprietor THEN
            TESTFIELD("NIC No.");
    END;

    // PROCEDURE SendApproveMail();
    // VAR
    //     SMTPMailSetup: Record "SMTP Mail Setup 1";
    //     SMTPMail: Codeunit "SMTP Mail";
    //     UserSetupRec: Record "User Setup";
    //     TestMailTitleTxt: Label 'Customer Approval -  %1';
    //     TestMailBodyTxt1: Label 'Customer code  : %1        Name:%2   B.Unit :%3';
    //     TestMailSuccessMsg: Label 'Message sent successfully';
    //     TestMailBodyTxt2: Label 'Approved By : %1';
    //     CrLf: Text[2];
    // BEGIN
    //     CrLf[1] := 13;
    //     CrLf[2] := 10;

    //     SMTPMailSetup.GET;
    //     UserSetupRec.GET(USERID);
    //     UserSetupRec.TESTFIELD("E-Mail");

    //     SMTPMail.CreateMessage(
    //       '',
    //       UserSetupRec."E-Mail",
    //       UserSetupRec."E-Mail",
    //       STRSUBSTNO(TestMailTitleTxt, Name),
    //       STRSUBSTNO(
    //         STRSUBSTNO(TestMailBodyTxt1, "No.", Name, "Global Dimension 1 Code") + CrLf + '           ' + STRSUBSTNO(TestMailBodyTxt2, USERID),
    //         USERID,
    //         SMTPMailSetup."SMTP Server",
    //         FORMAT(SMTPMailSetup."SMTP Server Port"),
    //         SMTPMailSetup.Authentication,
    //         SMTPMailSetup."Secure Connection",
    //         SERVICEINSTANCEID,
    //         TENANTID),
    //       TRUE);

    //     SMTPMail.Send;
    //     MESSAGE(TestMailSuccessMsg, UserSetupRec."E-Mail");
    // END;

    // PROCEDURE SendApproveRequestMail();
    // VAR
    //     SMTPMailSetup: Record "SMTP Mail Setup 1";
    //     SMTPMail: Codeunit "SMTP Mail";
    //     UserSetupRec: Record "User Setup";
    //     CrLf: Text[2];
    //     TestMailTitleTxt: Label 'Customer Approval Request-  %1';
    //     TestMailBodyTxt1: Label 'Customer code  : %1        Name:%2   B.Unit :%3';
    //     TestMailSuccessMsg: Label 'Message sent successfully';
    //     TestMailBodyTxt2: Label 'Send By : %1';
    // BEGIN

    //     CrLf[1] := 13;
    //     CrLf[2] := 10;

    //     SMTPMailSetup.GET;

    //     UserSetupRec.SETFILTER("Customer Approval", '%1', TRUE);
    //     IF UserSetupRec.FINDSET THEN BEGIN
    //         REPEAT
    //             IF UserSetupRec."E-Mail" <> '' THEN BEGIN
    //                 SMTPMail.CreateMessage(
    //                   '',
    //                   UserSetupRec."E-Mail",
    //                   UserSetupRec."E-Mail",
    //                   STRSUBSTNO(TestMailTitleTxt, Name),
    //                   STRSUBSTNO(
    //                     STRSUBSTNO(TestMailBodyTxt1, "No.", Name, "Global Dimension 1 Code") + CrLf + '           ' + STRSUBSTNO(TestMailBodyTxt2, USERID),
    //                     USERID,
    //                     SMTPMailSetup."SMTP Server",
    //                     FORMAT(SMTPMailSetup."SMTP Server Port"),
    //                     SMTPMailSetup.Authentication,
    //                     SMTPMailSetup."Secure Connection",
    //                     SERVICEINSTANCEID,
    //                     TENANTID),
    //                   TRUE);

    //                 SMTPMail.Send;
    //             END;
    //         UNTIL UserSetupRec.NEXT = 0;
    //     END;
    //     MESSAGE(TestMailSuccessMsg, UserSetupRec."E-Mail");
    // END;

    PROCEDURE CalcInvoicedPrepmtAmountLCY() PrepaymentAmount: Decimal;
    VAR
        SalesLine: Record "Sales Line";
    BEGIN
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Bill-to Customer No.", "No.");
        SalesLine.SETFILTER("Prepayment %", '<>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                PrepaymentAmount += SalesLine."Prepmt. Amount Inv. (LCY)" + SalesLine."Prepmt. VAT Amount Inv. (LCY)";
            UNTIL SalesLine.NEXT = 0;
    END;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        if Blocked = xRec.Blocked then
            "Last Date Modified" := Today();
    end;
    // BEGIN
    // {
    //   **Bloked Reason - When Setting "Blocked" Field, Set "Blocked Reason" first, Then the "Blocked" field.
    // }
    // END.
    // trigger OnAfterModify()
    // begin
    //     if Blocked = xRec.Blocked then
    //         "Last Date Modified" := Today();
    // end;

}