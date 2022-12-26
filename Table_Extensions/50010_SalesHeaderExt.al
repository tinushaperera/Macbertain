tableextension 50010 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50000; "Route Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Route));
        }
        field(50001; "Temporary Receipt No."; Code[6])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin
                IF STRLEN("Temporary Receipt No.") <> 6 THEN
                    ERROR('Temporary Receipt No. should be 6 charactersin lenght');
            end;
        }
        field(50002; "NIC No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; SalesPersonFilter; Code[21])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "SVAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Credit Limit Check"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(50009; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Order,Sample;
            OptionCaption = ' ,Order,Sample';
        }
        field(50010; "Invoice Despatch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Fee Issue Exists"; Boolean)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Free Issue Line" = CONST(true)));
        }
        field(50012; "Dicount Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" WHERE("Line Discount Amount" = FILTER(> 0), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        }
        field(50013; "Over Due Check"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";
        }
        field(50014; "Create User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50015; "Entry Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Table Code"));
        }
        field(50016; "Last Date-Time Modified"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50017; "Last Modified User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            // TestTableRelation = false;
            Editable = false;
        }
        field(50018; "Date-Time Created"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Released User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Date-Time Released"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Order Approved"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin
                IF "Order Approved" = TRUE THEN
                    "Approved Date & Time" := CREATEDATETIME(TODAY, TIME)
                ELSE
                    "Approved Date & Time" := CREATEDATETIME(0D, 0T);
            end;
        }
        field(50023; "Route Code2"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Ship-to Address"."Route Code 2" WHERE(Code = FIELD("Ship-to Code")));
            Editable = false;
        }
        field(50024; "Route Code3"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Ship-to Address"."Route Code 3" WHERE(Code = FIELD("Ship-to Code")));
        }
        field(50025; "Route Code4"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Ship-to Address"."Route Code 4" WHERE(Code = FIELD("Ship-to Code")));
        }
        field(50026; "Approved Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Quantity Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                IF "Quantity Approved" = TRUE THEN
                    "Quantity Approved Date & Time" := CREATEDATETIME(TODAY, TIME)
                ELSE
                    "Quantity Approved Date & Time" := CREATEDATETIME(0D, 0T);
            end;
        }
        field(50028; "Quantity Approved Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Tube Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Allow Without Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "VAT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."VAT Amount" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        }
        field(50033; "NBT Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."NBT Amount" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        }
        field(50034; "Territory Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Territory;
            Editable = false;
        }
        field(50035; "Blocked Reason"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",None,Manual,"Over Due";
            OptionCaption = ' ,None,Manual,Over Due';
            Editable = false;
        }

        modify("Sell-to Customer No.")
        {
            TableRelation = Customer."No." where(Blocked = filter('<>New'));

            trigger OnAfterValidate()
            var
                VatPostSetupRec: Record "VAT Posting Setup";
                Cust: Record Customer;
            begin
                Cust.Get("Sell-to Customer No.");
                "Region Code" := Cust."Region Code";
                "Territory Code" := Cust."Territory Code"; //RJ
                                                           //<Chin 201602161038
                IF Cust."Salesperson Code" <> '' THEN;
                SalesPersonFilter := Cust."Salesperson Code";
                IF Cust."Salesperson Code 2" <> '' THEN
                    IF SalesPersonFilter <> '' THEN
                        SalesPersonFilter := SalesPersonFilter + '''|''' + Cust."Salesperson Code 2"
                    ELSE
                        SalesPersonFilter := Cust."Salesperson Code 2";
                //>
                IF VatPostSetupRec.GET("VAT Bus. Posting Group") THEN // RJ
                    "SVAT %" := VatPostSetupRec."SVAT %";
            end;
        }
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                SalesPerson: Record "Salesperson/Purchaser";
                Cust: Record Customer;
            begin
                //RJ(+)
                Cust.Get("Bill-to Customer No.");
                IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order") THEN
                    VALIDATE("Salesperson Code", Cust."Salesperson Code")
                //RJ(-)
            end;
        }
        modify("Ship-to Code")
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."), Active = CONST(true));
        }
        modify("Payment Terms Code")
        {
            TableRelation = "Payment Terms" WHERE("Customer Payment Term" = CONST(true));
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()

            begin
                //<Chin 2016/02/03 1248
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETFILTER("Document No.", "No.");
                IF SalesLine.FINDSET THEN
                    REPEAT
                        IF SalesLine."Shortcut Dimension 2 Code" <> "Shortcut Dimension 2 Code" THEN
                            ERROR('There are line/s with a different %1', FIELDCAPTION("Shortcut Dimension 2 Code"));
                    UNTIL SalesLine.NEXT = 0;
                //>
            end;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                SalesPerson: Record "Salesperson/Purchaser";
                Cust: Record Customer;
            begin
                IF Cust.GET("Bill-to Customer No.") THEN
                    IF ("Salesperson Code" <> '') AND ("Salesperson Code" <> xRec."Salesperson Code") THEN BEGIN
                        IF ("Salesperson Code" <> Cust."Salesperson Code") AND ("Salesperson Code" <> Cust."Salesperson Code 2") THEN
                            ERROR('Please Select  Valid Salesperson');
                    END;

                IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order") THEN
                    IF SalesPerson.GET("Salesperson Code") THEN
                        VALIDATE("Shortcut Dimension 1 Code", SalesPerson."Global Dimension 1 Code");
            end;
        }
        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()

            begin
                Error('Select invoice no from the message');
            end;
        }
    }

    trigger OnInsert()

    begin
        //<Chin 20160624 2128
        "Create User ID" := USERID;
        "Date-Time Created" := CREATEDATETIME(TODAY, TIME);
        //>   
    end;

    trigger OnModify()

    begin
        IF "Create User ID" = '' THEN BEGIN //NS
            "Create User ID" := USERID;
            "Date-Time Created" := CREATEDATETIME(TODAY, TIME);
        END;
        //<Chin 20160624 2130
        "Last Modified User ID" := USERID;
        "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
        //>
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "No.");
        IF SalesLine.CALCSUMS("Quantity Shipped") THEN
            IF SalesLine."Quantity Shipped" <> 0 THEN BEGIN
                UserSetup.GET(USERID);
                IF UserSetup."Sales Order Delete" = FALSE THEN
                    ERROR('You Dont have permission to delete this Sales Order !');
            END;
    end;

    PROCEDURE SetCreditLimit();
    VAR
        CustRec: Record Customer;
        CustLgrRec: Record "Cust. Ledger Entry";
        SaleSetupRec: Record "Sales & Receivables Setup";
        Overdue: Decimal;
    BEGIN
        SaleSetupRec.GET;
        "Over Due Check" := 0;
        IF CustRec.GET("Sell-to Customer No.") THEN BEGIN
            CustRec.CALCFIELDS("PD Check Amount", "Promissory Note Amount", "Bank Guarantee Amount", Balance, "Outstanding Orders");
            "Credit Limit Check" := CustRec."Credit Limit (LCY)" - (CustRec."Balance (LCY)" + CustRec."Outstanding Orders (LCY)");
            CustLgrRec.SETFILTER(CustLgrRec."Customer No.", "Sell-to Customer No.");
            //CustLgrRec.SETFILTER(CustLgrRec."Remaining Amount" , '>=%1' ,SaleSetupRec."Overdue Approval Limit");
            CustLgrRec.SETFILTER("Posting Date", '<%1', (WORKDATE - SaleSetupRec."Overdue Approval Age"));
            IF CustLgrRec.FINDFIRST THEN
                REPEAT
                    CustLgrRec.CALCFIELDS("Remaining Amount");
                    Overdue += CustLgrRec."Remaining Amount";
                UNTIL CustLgrRec.NEXT = 0;
            "Over Due Check" := Overdue - SaleSetupRec."Overdue Approval Limit"; //checking overdue approval threshlod
        END ELSE BEGIN
            "Credit Limit Check" := 0;
        END;
    END;

    PROCEDURE CheckSalesReturnNotBlankFields();
    VAR
        SalesLineRec: Record "Sales Line";
    BEGIN
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            SalesLineRec.RESET;
            SalesLineRec.SETRANGE("Document Type", "Document Type");
            SalesLineRec.SETFILTER("Document No.", "No.");
            IF SalesLineRec.FINDSET THEN
                REPEAT
                    IF SalesLineRec.Type = SalesLineRec.Type::Item THEN
                        SalesLineRec.TESTFIELD("Return Reason Code");
                UNTIL SalesLineRec.NEXT = 0;
        END;
    END;

    var
        SalesLine: Record "Sales Line";
        UserSetup: Record "User Setup";
}