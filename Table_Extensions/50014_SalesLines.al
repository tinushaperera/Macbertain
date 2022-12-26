tableextension 50014 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50000; "Free Issue Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        field(50001; "Standard Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
            Editable = false;
        }
        field(50002; "Maximum Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
            AutoFormatType = 2;
        }
        field(50003; "Free Issue Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Free Issue Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Free Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Both; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Qty. Received"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Return Reason Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Order,Sample;
            OptionCaption = ' ,Order,Sample';
        }
        field(50010; "Quantity Received By Stores"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin
                IF Quantity < "Quantity Received By Stores" THEN
                    ERROR('Cannot be more than Return Order Quantity');
            end;
        }
        field(50011; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Available Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Location Code" = FIELD("Location Code"), "Variant Code" = FIELD("Variant Code")));
        }
        field(50013; "Gross Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Gross Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;

            trigger OnValidate()
            var
                User: Record User;
                SalesHedRec: Record "Sales Header";
                PenAppCanEdit: Boolean;
                Cust: Record Customer;
            begin
                Currency.Get("Currency Code");
                "Gross Line Discount Amount" := ROUND(ROUND(Quantity * "Gross Price", Currency."Amount Rounding Precision") * "Gross Line Discount %" / 100, Currency."Amount Rounding Precision");
                //Update Line Discount Amount
            end;
        }
        field(50015; "Gross Line Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
            AutoFormatExpression = "Currency Code";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetSalesHeader;
                "Gross Line Discount Amount" := ROUND("Gross Line Discount Amount", Currency."Amount Rounding Precision");

                TESTFIELD(Quantity);
                IF xRec."Gross Line Discount Amount" <> "Gross Line Discount Amount" THEN
                    IF ROUND(Quantity * "Gross Price", Currency."Amount Rounding Precision") <> 0 THEN
                        VALIDATE("Line Discount %",
                          ROUND(
                            "Gross Line Discount Amount" / ROUND(Quantity * "Gross Price", Currency."Amount Rounding Precision") * 100,
                            0.00001))
                    ELSE
                        VALIDATE("Line Discount %", 0);
            end;
        }
        field(50016; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Sell-to Customer No.")));
            Editable = false;
        }
        field(50017; Status; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header".Status WHERE("No." = FIELD("Document No.")));
            OptionMembers = " ",Open,Released,"Pending Approval","Pending Prepayment";
            OptionCaption = ' ,Open,Released,Pending Approval,Pending Prepayment';
        }
        field(50018; "Ship To City"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Ship-to City" WHERE("No." = FIELD("Document No.")));
        }
        field(50019; "Date-Time Released"; DateTime)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Date-Time Released" WHERE("No." = FIELD("Document No.")));
        }
        field(50020; "Ship To Code"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Ship-to Code" WHERE("No." = FIELD("Document No.")));
        }
        field(50021; "Route Code 1"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Route Code" WHERE("No." = FIELD("Document No.")));
        }
        field(50022; "Route Code2"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Ship-to Address"."Route Code 2" WHERE(Code = FIELD("Ship To Code")));
        }
        field(50023; "Route Code3"; Code[30])
        {
            fieldClass = FlowField;
            CalcFormula = Lookup("Ship-to Address"."Route Code 3" WHERE(Code = FIELD("Ship To Code")));
        }
        field(50024; "Route Code4"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Ship-to Address"."Route Code 4" WHERE(Code = FIELD("Ship To Code")));
        }
        field(50025; "Discounted Gross Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Currency: Record Currency;
            begin
                if Currency.Get("Currency Code") then;
                IF xRec."Discounted Gross Price" <> "Discounted Gross Price" THEN
                    VALIDATE("Gross Line Discount Amount", ROUND(("Gross Price" - "Discounted Gross Price") * Quantity, Currency."Amount Rounding Precision"));
            end;
        }
        field(50026; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "NBT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50029; "Territory Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Territory Code';
            NotBlank = true;
            TableRelation = Territory;
        }
        field(50030; "Line Unit GP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Blocked Reason"; Option)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Blocked Reason" WHERE("No." = FIELD("Sell-to Customer No.")));
            OptionCaption = 'None,Manual,Over Due';
            OptionMembers = "None",Manual,"Over Due";
        }
        field(50032; "Paym. Term Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Payment Terms Code" WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("Document No.")));
        }
        modify(Type)
        {
            trigger OnAfterValidate()

            begin
                //Chin 201602111134
                IF "Document Type" = "Document Type"::Order THEN
                    IF "Free Issue Line No." <> 0 THEN
                        ERROR(TextM000);
                //
            end;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SlsHdrRec: Record "Sales Header";
                LineNoCount: Integer;
                CustRec: Record Customer;
                TaxRec: Record "Tax Area";
            begin
                //RJ
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    LineNoCount := COUNT;
                    IF LineNoCount = 14 THEN
                        ERROR('Maximum line items in sales order should be less than 15');
                END;
                //
                //<Chin 201602161138
                IF "Document Type" = "Document Type"::Order THEN
                    IF "Free Issue Line No." <> 0 THEN
                        ERROR(TextM000);
                //>
                //<Chin 2016/02/03
                SalesHeader.Get("Document Type", "Document No.");
                VALIDATE("Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 1 Code");
                //>
                "Region Code" := SalesHeader."Region Code"; //RJ
                "Territory Code" := SalesHeader."Territory Code"; //RJ

                //<Chin 20161006 1911

                // IF CustRec.GET(SalesHeader."Sell-to Customer No.") THEN
                //     IF TaxRec.GET(CustRec."Tax Area Code") THEN
                //         IF TaxRec."Tax Group Code" <> '' THEN
                //             "Tax Group Code" := TaxRec."Tax Group Code";

                if item.Get("No.") then;

                IF CustRec.GET(SalesHeader."Sell-to Customer No.") THEN
                    IF CustRec."NBT Registration No." <> '' THEN
                        IF Item."Tax Group Code 2" <> '' THEN
                            "Tax Group Code" := Item."Tax Group Code 2";

                //<Chin 20160922
                Item.TESTFIELD("Global Dimension 2 Code", SalesHeader."Shortcut Dimension 2 Code");
                //>

                //<Chin 20160909 0909
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    IF "Shortcut Dimension 2 Code" <> '' THEN
                        IF SlsHdrRec.GET("Document Type", "Document No.") THEN BEGIN
                            IF "Shortcut Dimension 2 Code" <> SlsHdrRec."Shortcut Dimension 2 Code" THEN
                                ERROR('Should use the same Dimention Code as in header');
                        END;

                    CalculateGrossPrice;
                    CalculateGrossDiscount;
                END;
                //>

                //<Chin 20160303 0912
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::Sample THEN
                    VALIDATE("Unit Price", 0);
                //>
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                User: Record User;
                SalesHedRec: Record "Sales Header";
                PenAppCanEdit: Boolean;
            begin
                //MR(+)
                IF (Quantity < 0) THEN
                    ERROR(Text010);
                //MR(-)
                //<Chin 20160211147
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    IF "Free Issue Line No." <> 0 THEN
                        ERROR(TextM000);
                    SalesHedRec.GET("Document Type", "Document No.");
                    IF SalesHedRec.Status = SalesHedRec.Status::"Pending Approval" THEN BEGIN
                        User.RESET;
                        User.SETCURRENTKEY("User Name");
                        User.SETRANGE("User Name", USERID);
                        User.FINDFIRST;
                        //IF User."Sales Order Editable" THEN
                        IF "Free Issue Line" THEN
                            PenAppCanEdit := TRUE;
                    END;
                END;
                //>
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                User: Record User;
                SalesHedRec: Record "Sales Header";
                PenAppCanEdit: Boolean;
            begin
                //Chin 201602111449
                SalesHedRec.GET("Document Type", "Document No.");
                IF SalesHedRec.Status = SalesHedRec.Status::"Pending Approval" THEN BEGIN
                    User.RESET;
                    User.SETCURRENTKEY("User Name");
                    User.SETRANGE("User Name", USERID);
                    User.FINDFIRST;
                    //IF User."Sales Order Editable" THEN
                    PenAppCanEdit := TRUE;
                END;
                //>
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            var
                User: Record User;
                SalesHedRec: Record "Sales Header";
                PenAppCanEdit: Boolean;
                Cust: Record Customer;
            begin
                IF "Line Discount %" > 0 THEN
                    IF Cust.GET("Sell-to Customer No.") THEN BEGIN
                        Cust."Last Discount %" := "Line Discount %";
                        Cust.MODIFY;
                    END;

                COMMIT;
                //>
                //Chin201602111451
                IF "Maximum Line Discount %" <> 0 THEN
                    IF "Line Discount %" > "Maximum Line Discount %" THEN
                        ERROR(TextM000, "Line Discount %", "Maximum Line Discount %");
                SalesHedRec.GET("Document Type", "Document No.");
                IF SalesHedRec.Status = SalesHedRec.Status::"Pending Approval" THEN BEGIN
                    User.RESET;
                    User.SETCURRENTKEY("User Name");
                    User.SETRANGE("User Name", USERID);
                    User.FINDFIRST;
                    //IF User."Sales Order Editable" THEN
                    PenAppCanEdit := TRUE;
                END;

                //>

                //<Chin 20161013 1130
                IF xRec."Line Discount %" <> "Line Discount %" THEN
                    "Gross Line Discount Amount" :=
                      ROUND(
                        ROUND(Quantity * "Gross Price", Currency."Amount Rounding Precision") *
                        "Line Discount %" / 100, Currency."Amount Rounding Precision");
                //>

            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            var
                SlsHdrRec: Record "Sales Header";
            begin
                //<Chin 2016/02/03
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    IF SlsHdrRec.GET("Document Type", "Document No.") THEN BEGIN
                        IF "Shortcut Dimension 2 Code" <> SlsHdrRec."Shortcut Dimension 2 Code" THEN
                            ERROR('Should use the same Dimention Code as in header');
                    END;
                END;
                //>
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                CalculateGrossPrice;
                CalculateGrossDiscount;

                //<Chin 20160303 0912
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::Sample THEN
                    VALIDATE("Unit Price", 0);
                //>
            end;
        }
        modify("Return Qty. to Receive")
        {
            Caption = 'QC Approved Qty.';
            trigger OnAfterValidate()

            begin
                //<Chin 2016/03/24 1239
                IF ("Return Qty. to Receive" > "Quantity Received By Stores") AND ("Quantity Received By Stores" > 0) THEN
                    ERROR('Cannot be more than Qty. Received by Stores');
            end;
        }
        modify("Return Reason Code")
        {
            TableRelation = "Return Reason" WHERE("Return Type" = CONST("Sales Return"));
        }
    }

    trigger OnModify()
    var
        SalesHedRec: Record "Sales Header";
    begin
        SalesHedRec.GET("Document Type", "Document No.");
        SalesHedRec.MODIFY(TRUE);
    end;

    trigger OnDelete()

    begin

        IF "Document Type" = "Document Type"::Order THEN
            IF "Free Issue Line" THEN
                ERROR(TextM000);

        //<Chin 201602111133
        IF "Document Type" = "Document Type"::Order THEN
            IF "Free Issue Line No." <> 0 THEN BEGIN
                SalesLine2.GET("Document Type", "Document No.", "Free Issue Line No.");
                SalesLine2.DELETE;
            END
        //>
    end;

    PROCEDURE CreateNewLine();
    VAR
        SalesLineRec: Record "Sales Line";
        SaleRecSetup: Record "Sales & Receivables Setup";
        Text00M: Label 'No free issue quantity defined';
    BEGIN

        IF ("Free Issue Line") THEN
            EXIT;
        IF "Free Issue Quantity" = 0 THEN
            EXIT;
        IF ("Free Issue Quantity" = 0) AND ("Free Issue") THEN
            ERROR(Text00M);

        IF "Free Issue Line No." = 0 THEN BEGIN
            IF DIALOG.CONFIRM(' Do you want to creat a free Issue Line ? ', FALSE) = TRUE THEN BEGIN
                SaleRecSetup.GET;
                //SaleRecSetup.TESTFIELD("Free Issue Code");
                SalesLineRec.RESET;
                SalesLineRec.SETRANGE("Document Type", "Document Type");
                SalesLineRec.SETRANGE("Document No.", "Document No.");
                IF SalesLineRec.FINDLAST THEN;
                SalesLineRec.INIT;
                SalesLineRec."Document Type" := "Document Type";
                SalesLineRec."Document No." := "Document No.";
                SalesLineRec."Line No." := SalesLineRec."Line No." + 10000;
                SalesLineRec.VALIDATE(Type, Type);
                SalesLineRec.VALIDATE("No.", "No.");
                SalesLineRec."Free Issue Line" := TRUE;
                SalesLineRec.VALIDATE(Quantity, "Free Issue Quantity");
                SalesLineRec.INSERT(TRUE);
                SalesLineRec."Free Issue Quantity" := "Free Issue Quantity";
                SalesLineRec.VALIDATE("Unit Price", 0);
                //SalesLineRec."Purchasing Code" := SaleRecSetup."Free Issue Code";
                SalesLineRec.MODIFY(TRUE);
                COMMIT;
                IF NOT Both THEN
                    VALIDATE("Line Discount %", 0);
                "Free Issue Line No." := SalesLineRec."Line No.";
                MODIFY(TRUE);
            END;
        END
        ELSE BEGIN

        END
    END;

    LOCAL PROCEDURE CalculateGrossPrice();
    VAR
        CalcTax: Codeunit "Sales Tax Calculate";
    BEGIN
        GetSalesHeader;
        "Gross Price" := "Unit Price" + CalcTax.CalculateTax("Tax Area Code", "Tax Group Code", "Tax Liable", SalesHeader."Posting Date", "Unit Price", 1, SalesHeader."Currency Factor");
        //<Chin 201804181136
        "Line Unit GP" := "Unit Price" - "Unit Cost";
        //>
    END;

    LOCAL PROCEDURE CalculateGrossDiscount();
    BEGIN
        "Gross Line Discount Amount" :=
          ROUND(
            ROUND(Quantity * "Gross Price", Currency."Amount Rounding Precision") *
            "Line Discount %" / 100, Currency."Amount Rounding Precision");
        IF Quantity = 0 THEN
            "Discounted Gross Price" := "Gross Price" - "Gross Line Discount Amount"
        ELSE
            "Discounted Gross Price" := "Gross Price" - ("Gross Line Discount Amount" / Quantity);

        //>
    END;

    LOCAL PROCEDURE UpdateVatNbt(SalesLineRec: Record "Sales Line");
    VAR
        CalCompTax: Codeunit "Calculate Tax Of Company";
        NBTAmount: Decimal;
    BEGIN
        CalCompTax.CalNBT(SalesLineRec."Tax Group Code", SalesLineRec."Tax Area Code", SalesLineRec.Amount,
              NBTAmount);
        "NBT Amount" := NBTAmount;
        "VAT Amount" := ("Amount Including VAT" - Amount) - NBTAmount;
    END;

    var
        TextM000: Label 'Cannot change the quantity free issue line exist';
        SalesLine2: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        item: Record Item;
        Text010: Label 'Quantity must be greater than zero.';
        Currency: Record Currency;
}