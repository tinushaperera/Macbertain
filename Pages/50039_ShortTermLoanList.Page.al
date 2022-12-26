page 50039 "Short Term Loan List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Shipping Guarantee";
    SourceTableView = WHERE("Shipping Guarantee Type" = CONST(STL));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Import Job No."; rec."Import Job No.")
                {
                    ApplicationArea = all;
                }
                field("Loan Granted Date"; rec."Deposit Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF Rec."Deposit Date" <> xRec."Deposit Date" THEN
                            rec."Maturity Date" := rec."Deposit Date" + 90;
                    end;
                }
                field("Granted Amount"; rec."Value(LCY)")
                {
                    ApplicationArea = all;
                }
                field("Facility No."; rec."Facility No.")
                {
                    ApplicationArea = all;
                }
                field("Maturity Date"; rec."Maturity Date")
                {
                    ApplicationArea = all;
                }
                field(Comments; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
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
        rec."Shipping Guarantee Type" := rec."Shipping Guarantee Type"::STL;
        rec."Import Job No." := ImpJobNo;
    end;

    var
        ImpJobNo: Code[20];


    procedure SetImportJobNo(No: Code[20])
    begin
        ImpJobNo := No;
    end;
}

