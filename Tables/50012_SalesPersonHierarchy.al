table 50012 "Salesperson Hierarchy"
{

    fields
    {
        field(1; "Cal. Year"; Integer)
        {
        }
        field(2; "Cal. Month"; Integer)
        {
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                TESTFIELD(Code);
            end;
        }
        field(4; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(5; "Reporting To Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate()
            var
                SalesPerRec: Record "Salesperson/Purchaser";
            begin
                IF Rec."Reporting To Code" <> xRec."Reporting To Code" THEN
                    IF SalesPerRec.GET("Reporting To Code") THEN
                        "Reporting To Name" := SalesPerRec.Name
                    ELSE
                        "Reporting To Name" := '';
            end;
        }
        field(6; "Reporting To Name"; Text[50])
        {
            Caption = 'Name';
        }
        field(7; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Cal. Year", "Cal. Month", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        gSalesPerH: Record "Salesperson Hierarchy" temporary;

    [Scope('Cloud')]
    procedure ValidateHierarchy(ThisYear: Integer; ThisMonth: Integer)
    var
        SalesPerH: Record "Salesperson Hierarchy";
        TmpSalesPerH: Record "Salesperson Hierarchy" temporary;
        sumAmt: Decimal;
    begin
        CLEAR(gSalesPerH);
        gSalesPerH.SETFILTER("Cal. Year", '%1', ThisYear);
        gSalesPerH.SETFILTER("Cal. Month", '%1', ThisMonth);
        gSalesPerH.DELETEALL;

        SalesPerH.RESET;
        SalesPerH.SETFILTER("Cal. Year", '%1', ThisYear);
        SalesPerH.SETFILTER("Cal. Month", '%1', ThisMonth);
        SalesPerH.SETFILTER("Reporting To Code", ' ');
        IF SalesPerH.FINDSET THEN
            REPEAT
                IF SalesPerH."Reporting To Code" = '' THEN
                    GetTree(SalesPerH, sumAmt);
            UNTIL SalesPerH.NEXT = 0;

        SalesPerH.RESET;
        SalesPerH.SETFILTER("Cal. Year", '%1', ThisYear);
        SalesPerH.SETFILTER("Cal. Month", '%1', ThisMonth);
        IF SalesPerH.FINDSET THEN
            REPEAT
                IF NOT gSalesPerH.GET(ThisYear, ThisMonth, SalesPerH.Code) THEN
                    ERROR('Proper Reference Not found for : %1 ', SalesPerH.Name);
            UNTIL SalesPerH.NEXT = 0;
    end;

    [Scope('Cloud')]
    procedure InsertHierarchy(ThisYear: Integer; ThisMonth: Integer): Boolean
    var
        SalesperRec: Record "Salesperson/Purchaser";
        SalesperHiRec: Record "Salesperson Hierarchy";
    begin
        SalesperHiRec.SETFILTER("Cal. Year", '%1', ThisYear);
        SalesperHiRec.SETFILTER("Cal. Month", '%1', ThisMonth);
        SalesperHiRec.DELETEALL;

        SalesperRec.RESET;
        IF SalesperRec.FINDSET THEN
            REPEAT
                InsertSalesPersonH(ThisYear, ThisMonth, SalesperRec, SalesperHiRec, 0);
            UNTIL SalesperRec.NEXT = 0;
    end;

    local procedure InsertSalesPersonH(runYear: Integer; runMonth: Integer; SalesperRec: Record "Salesperson/Purchaser"; var SalesperRecH: Record "Salesperson Hierarchy"; SumAmt: Decimal)
    var
        SalesperRec2: Record "Salesperson/Purchaser";
    begin
        SalesperRecH.INIT;
        SalesperRecH."Cal. Year" := runYear;
        SalesperRecH."Cal. Month" := runMonth;
        SalesperRecH.Code := SalesperRec.Code;
        SalesperRecH.Name := SalesperRec.Name;
        SalesperRecH."Reporting To Code" := SalesperRec."Reporting To";
        IF SalesperRec2.GET(SalesperRec."Reporting To") THEN
            SalesperRecH."Reporting To Name" := SalesperRec2.Name;
        SalesperRecH.Amount := SumAmt;
        SalesperRecH.INSERT;
    end;

    local procedure GetTree(pSalesPerH: Record "Salesperson Hierarchy"; var SumAmt: Decimal)
    var
        lSalesperHRec: Record "Salesperson Hierarchy";
        ltotAmt: Decimal;
        lSalesPerRec: Record "Salesperson/Purchaser";
    begin
        ltotAmt := 0;
        lSalesperHRec.RESET;
        lSalesperHRec.SETFILTER("Cal. Year", '%1', pSalesPerH."Cal. Year");
        lSalesperHRec.SETFILTER("Cal. Month", '%1', pSalesPerH."Cal. Month");
        lSalesperHRec.SETFILTER("Reporting To Code", pSalesPerH.Code);
        IF lSalesperHRec.FINDSET THEN
            REPEAT
                GetTree(lSalesperHRec, SumAmt);
                ltotAmt += SumAmt;
            UNTIL lSalesperHRec.NEXT = 0;
        lSalesPerRec.GET(pSalesPerH.Code);
        //SumAmt +=  ltotAmt + GetAmount(lSalesperHRec)
        InsertSalesPersonH(pSalesPerH."Cal. Year", pSalesPerH."Cal. Month", lSalesPerRec, gSalesPerH, SumAmt); //Insert To Temp List to validate
    end;
}

