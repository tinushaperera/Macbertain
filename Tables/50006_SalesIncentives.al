table 50006 "Sales Incentives"
{

    fields
    {
        field(1; Year; Integer)
        {
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3; "Icentive Type"; Option)
        {
            OptionMembers = Collection,Sales,Debtors,"PD Cheque";
        }
        field(4; "Incentive Sign"; Integer)
        {
        }
        field(5; Designation; Code[30])
        {
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Designation));
        }
        field(6; "BU Product Category"; Code[20])
        {
            TableRelation = "Product Category"."Product Category Code" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(7; "Rate 1"; Decimal)
        {
        }
        field(8; "Rate 2"; Decimal)
        {
        }
        field(9; "Rate 3"; Decimal)
        {
        }
        field(10; "Rate 4"; Decimal)
        {
        }
        field(11; Month; Integer)
        {

            trigger OnValidate()
            begin
                IF (Month < 0) OR (Month > 12) THEN
                    ERROR(Text001);

            end;
        }
    }

    keys
    {
        key(Key1; Year, Month, "Global Dimension 1 Code", "Icentive Type", Designation, "BU Product Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'Not a valid Month code';
        Text002: Label 'Cannot update Sales Incentive for %1 / %2';
        Text003: Label 'Incetive Scheme Cache is not updated to latest';

    [Scope('Cloud')]
    procedure UpdateMonthlyIncentive(pYear: Integer; pMonth: Integer): Boolean
    var
        SalesIncRec: Record "Sales Incentives";
        SalesIncRec2: Record "Sales Incentives";
        SalesSetupRec: Record "Sales & Receivables Setup";
    begin
        SalesSetupRec.GET;

        IF SalesSetupRec."Last Incetive Paid Year" * 12 + SalesSetupRec."Last Incentive Paid Month" >= pYear * 12 + pMonth THEN
            MESSAGE(Text003, pYear, pMonth)
        ELSE BEGIN
            SalesIncRec.RESET;
            SalesIncRec.SETFILTER(Year, '%1', pYear);
            SalesIncRec.SETFILTER(Month, '%1', pMonth);
            SalesIncRec.DELETEALL;
            SalesIncRec2.RESET;
            SalesIncRec2.SETFILTER(Year, '%1', pYear);
            SalesIncRec2.SETFILTER(Month, '%1', 0);
            IF SalesIncRec2.FINDSET THEN BEGIN
                REPEAT
                    SalesIncRec.INIT;
                    SalesIncRec.TRANSFERFIELDS(SalesIncRec2, TRUE);
                    SalesIncRec.Month := pMonth;
                    SalesIncRec.INSERT;
                UNTIL SalesIncRec2.NEXT = 0;
            END;
        END;
    end;
}

