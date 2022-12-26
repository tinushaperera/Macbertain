tableextension 50015 PurchaseHeadExt extends "Purchase Header"
{
    fields
    {
        modify("Payment Terms Code")
        {
            TableRelation = "Payment Terms" WHERE("Vendor Payment Term" = CONST(true));
        }
        field(50000; "Import Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Import Jobs".No. WHERE (Status=CONST(Released));
        }
        field(50001; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Local,Import,Loan,Return,Loan Return';
            OptionMembers = "Local",Import,Loan,Return,"Loan Return";
        }
        field(50003; "Shipping Ref. No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Vehicle No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Create User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Create Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "GRN Invoice No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }

    }


    PROCEDURE UpdateUnitCostFromSKU(DocType: Integer; DocNo: Code[20]);
    VAR
        PurchLine: Record "Purchase Line";
        SKU: Record "Stockkeeping Unit";
        Cost: Decimal;
    BEGIN
        PurchLine.RESET;
        PurchLine.SETFILTER("Document Type", '%1', DocType);
        PurchLine.SETFILTER("Document No.", DocNo);
        IF PurchLine.FINDSET THEN
            REPEAT
                Cost := SKU.GetItemSKUCost(PurchLine."No.", PurchLine."Variant Code", PurchLine."Location Code");
                IF (Cost > 0) AND (Cost <> PurchLine."Direct Unit Cost") THEN BEGIN
                    PurchLine.VALIDATE("Direct Unit Cost", Cost);
                    PurchLine.MODIFY;
                END;
            UNTIL PurchLine.NEXT = 0;
    END;
}

