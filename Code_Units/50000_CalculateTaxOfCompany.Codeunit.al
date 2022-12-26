codeunit 50000 "Calculate Tax Of Company"
{

    trigger OnRun()
    var
        Val: Decimal;
    begin
    end;

    var
        Text001: Label 'The Qty. to Invoice must be equal to Return Qty. Received.';


    procedure CalTaxOnTax(TaxGropCode: Code[10]; TaxAreaCode: Code[20]; CalAmt: Decimal; var NBTAmt: Decimal; var VATAmt: Decimal)
    var
        TaxDetail: Record "Tax Detail";
        TaxALine: Record "Tax Area Line";
    begin
        TaxDetail.RESET;
        TaxDetail.SETRANGE("Tax Group Code", TaxGropCode);

        TaxALine.RESET;
        TaxALine.SETCURRENTKEY("Tax Area", "Calculation Order");
        TaxALine.SETRANGE("Tax Area", TaxAreaCode);
        TaxALine.ASCENDING(FALSE);
        IF TaxALine.FINDSET THEN;
        REPEAT
            TaxDetail.SETRANGE("Tax Jurisdiction Code", TaxALine."Tax Jurisdiction Code");
            IF TaxDetail.FINDLAST THEN BEGIN
                IF TaxALine."Tax Jurisdiction Code" = 'NBT' THEN
                    NBTAmt := CalAmt * TaxDetail."Tax Below Maximum" / 100;
                IF TaxALine."Tax Jurisdiction Code" = 'VAT' THEN
                    VATAmt := (CalAmt + NBTAmt) * TaxDetail."Tax Below Maximum" / 100;
            END;
        UNTIL TaxALine.NEXT = 0;
    end;


    procedure CalNBT(TaxGropCode: Code[10]; TaxAreaCode: Code[20]; CalAmt: Decimal; var NBTAmt: Decimal)
    var
        TaxDetail: Record "Tax Detail";
        TaxALine: Record "Tax Area Line";
    begin
        TaxDetail.RESET;
        TaxDetail.SETRANGE("Tax Group Code", TaxGropCode);

        TaxALine.RESET;
        TaxALine.SETCURRENTKEY("Tax Area", "Calculation Order");
        TaxALine.SETRANGE("Tax Area", TaxAreaCode);
        TaxALine.ASCENDING(FALSE);
        IF TaxALine.FINDSET THEN;
        REPEAT
            TaxDetail.SETRANGE("Tax Jurisdiction Code", TaxALine."Tax Jurisdiction Code");
            IF TaxDetail.FINDLAST THEN BEGIN
                IF TaxALine."Tax Jurisdiction Code" = 'NBT' THEN
                    NBTAmt := CalAmt * TaxDetail."Tax Below Maximum" / 100;
            END;
        UNTIL TaxALine.NEXT = 0;
    end;


    procedure CalVAT(TaxGropCode: Code[10]; TaxAreaCode: Code[20]; CalAmt: Decimal; var NBTAmt: Decimal; var VATAmt: Decimal)
    var
        TaxDetail: Record "Tax Detail";
        TaxALine: Record "Tax Area Line";
    begin
        TaxDetail.RESET;
        TaxDetail.SETRANGE("Tax Group Code", TaxGropCode);

        TaxALine.RESET;
        TaxALine.SETCURRENTKEY("Tax Area", "Calculation Order");
        TaxALine.SETRANGE("Tax Area", TaxAreaCode);
        TaxALine.ASCENDING(FALSE);
        IF TaxALine.FINDSET THEN;
        REPEAT
            TaxDetail.SETRANGE("Tax Jurisdiction Code", TaxALine."Tax Jurisdiction Code");
            IF TaxDetail.FINDLAST THEN BEGIN
                IF TaxALine."Tax Jurisdiction Code" = 'VAT' THEN
                    VATAmt := (CalAmt + NBTAmt) * TaxDetail."Tax Below Maximum" / 100;
            END;
        UNTIL TaxALine.NEXT = 0;
    end;


    procedure CheckSalesReturnShipRecive(DocType: Integer; DocNo: Code[20])
    var
        SalesLine: Record "Sales Line";
    begin
        CLEAR(SalesLine);
        SalesLine.SETRANGE("Document Type", DocType);
        SalesLine.SETRANGE("Document No.", DocNo);
        IF NOT SalesLine.FINDSET THEN
            EXIT;
        REPEAT
            IF SalesLine."Qty. to Invoice" <> 0 THEN
                IF SalesLine."Qty. to Invoice" <> SalesLine."Return Qty. Received" - SalesLine."Quantity Invoiced" THEN
                    ERROR(Text001);
        UNTIL SalesLine.NEXT = 0;
    end;
}

