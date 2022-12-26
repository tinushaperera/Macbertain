page 50026 "Debtor Incentive Scheme"
{
    ApplicationArea = All;
    UsageCategory = Tasks;
    PageType = Worksheet;
    SourceTable = "Sales Incentives";
    SourceTableView = WHERE("Icentive Type" = CONST(Debtors),
                            Month = CONST(0));

    layout
    {
        area(content)
        {
            field(Year; ThisYear)
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD;
                    FilterRecords(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            field(BU; ThisBU)
            {
                ApplicationArea = all;
                CaptionClass = '1,1,1';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD;
                    FilterRecords(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            repeater(Group)
            {
                field(Designation; rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("Over (90 - 119) days %"; rec."Rate 1")
                {
                    ApplicationArea = all;
                }
                field("Over 120 days %"; rec."Rate 2")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Year := ThisYear;
        //"Global Dimension 1 Code" := ThisBU;
        //"Icentive Type" := "Icentive Type"::Collection;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Year := ThisYear;
        rec."Global Dimension 1 Code" := ThisBU;
        rec."Icentive Type" := rec."Icentive Type"::Debtors;
        rec."Incentive Sign" := -1;
        rec.Month := 0;
    end;

    trigger OnOpenPage()
    begin
        //ThisYear := 2016;
        //ThisBU := 'BU1';
        FilterRecords(Rec);
    end;

    var
        ThisYear: Integer;
        ThisBU: Code[30];

    local procedure FilterRecords(var SalesIncentive: Record "Sales Incentives")
    begin
        SalesIncentive.FILTERGROUP := 2;
        SalesIncentive.SETRANGE(Year, ThisYear);
        SalesIncentive.SETRANGE("Global Dimension 1 Code", ThisBU);
        SalesIncentive.FILTERGROUP := 0;
        IF SalesIncentive.FIND('-') THEN;
    end;
}

