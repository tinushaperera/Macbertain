page 50023 "Sales Targets"
{
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Sales Targets";
    ApplicationArea = All;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            field(Year; Year)
            {
                ApplicationArea = all;
            }
            field(Month; Month)
            {
                ApplicationArea = all;

                trigger OnValidate()
                var
                    incMgt: Codeunit "Incentive Management";
                begin
                    CurrPage.SAVERECORD;
                    FilterRecords(Rec);
                    CurrPage.UPDATE(FALSE);

                    LineEditable := incMgt.SalesTagertsEditable(Year, Month);
                end;
            }
            repeater(General)
            {
                IndentationColumn = rec.Indentation;
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                }
                field("SalepPerson Name"; rec."SalepPerson Name")
                {
                    ApplicationArea = all;
                }
                field(Designation; rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("Territory Code"; rec."Territory Code")
                {
                    ApplicationArea = all;
                }
                field("Product Category Code"; rec."Product Category Code")
                {
                    ApplicationArea = all;
                }
                field("Target Value"; rec."Target Value")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Target Year" := Year;
        rec."Target Month" := Month;
        IF rec."Line No." = 0 THEN BEGIN
            LastLineNo += 1000;
            rec."Line No." := LastLineNo;
        END;
    end;

    trigger OnOpenPage()
    begin
        FilterRecords(Rec);
    end;

    var
        Year: Integer;
        Month: Integer;
        LastLineNo: Integer;
        LineEditable: Boolean;

    local procedure FilterRecords(var SalesTargets: Record "Sales Targets")
    var
        SalesTarget2: Record "Sales Targets";
    begin
        SalesTargets.FILTERGROUP := 2;
        SalesTargets.SETRANGE("Target Year", Year);
        SalesTargets.SETRANGE("Target Month", Month);
        SalesTargets.FILTERGROUP := 0;
        IF SalesTargets.FIND('-') THEN;
        LastLineNo := 0;
        SalesTarget2.RESET;
        SalesTarget2.SETFILTER("Target Year", '%1', Year);
        SalesTarget2.SETFILTER("Target Month", '%1', Month);
        IF SalesTarget2.FINDFIRST THEN
            REPEAT
                IF LastLineNo < SalesTarget2."Line No." THEN
                    LastLineNo := SalesTarget2."Line No.";
            UNTIL SalesTarget2.NEXT = 0;
    end;
}

