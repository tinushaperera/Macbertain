page 50050 "Salesperson Hierarchy"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Salesperson Hierarchy";

    layout
    {
        area(content)
        {
            field(Year; Year)
            {
                ApplicationArea = All;
            }
            field(Month; Month)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD;
                    FilterRecords(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            repeater(Group)
            {

                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reporting To Code"; rec."Reporting To Code")
                {
                    ApplicationArea = All;
                }
                field("Reporting To Name"; rec."Reporting To Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                Caption = 'Process';
                action("Insert Heirarchy")
                {
                    ApplicationArea = All;
                    Caption = 'Insert Heirarchy';
                    Image = SalesPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.InsertHierarchy(Year, Month);
                    end;
                }
                action("Validate Hierarchy")
                {
                    ApplicationArea = All;
                    Caption = 'Validate Hierarchy';
                    Image = Hierarchy;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.ValidateHierarchy(Year, Month);
                    end;
                }
            }
        }
    }

    var
        Year: Integer;
        Month: Integer;

    local procedure FilterRecords(var SalesperHRec: Record "Salesperson Hierarchy")
    var
        SalesTarget2: Record "Sales Targets";
    begin
        SalesperHRec.FILTERGROUP := 2;
        SalesperHRec.SETFILTER("Cal. Year", '%1', Year);
        SalesperHRec.SETFILTER("Cal. Month", '%1', Month);
        SalesperHRec.FILTERGROUP := 0;
        //Get Last Line No.
    end;
}

