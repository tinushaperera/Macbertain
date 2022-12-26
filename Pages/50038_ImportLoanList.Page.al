page 50038 "Import Loan List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Shipping Guarantee";
    SourceTableView = WHERE("Shipping Guarantee Type" = CONST("Import Loan"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Import Job No."; Rec."Import Job No.")
                {
                    ApplicationArea = all;
                }
                field("Loan Granted Date"; Rec."Deposit Date")
                {
                    ApplicationArea = all;
                }
                field("Granted Amount"; Rec."Value(LCY)")
                {
                    ApplicationArea = all;
                }
                field("Facility No."; Rec."Facility No.")
                {
                    ApplicationArea = all;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = all;
                }
                field(Comments; Rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
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
        rec."Shipping Guarantee Type" := rec."Shipping Guarantee Type"::"Import Loan";
        rec."Import Job No." := ImpJobNo;
    end;

    var
        ImpJobNo: Code[20];

    procedure SetImportJobNo(No: Code[20])
    begin
        ImpJobNo := No;
    end;
}

