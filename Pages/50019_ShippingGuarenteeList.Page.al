page 50019 "Shipping Guarentee List"
{
    PageType = List;
    SourceTable = "Shipping Guarantee";
    SourceTableView = WHERE("Shipping Guarantee Type" = CONST(Guarantee));
    ApplicationArea = All;
    UsageCategory = Lists;
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
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Import Job No."; Rec."Import Job No.")
                {
                    ApplicationArea = all;
                }
                field("Facility No."; Rec."Facility No.")
                {
                    ApplicationArea = all;
                }
                field("Deposit Date"; Rec."Deposit Date")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ApplicationArea = all;
                }
                field("Value(LCY)"; Rec."Value(LCY)")
                {
                    ApplicationArea = all;
                }
                field("B\L Number"; Rec."B\L Number")
                {
                    ApplicationArea = all;
                }
                field("Cancel Date"; Rec."Cancel Date")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Maturity Date"; Rec."Maturity Date")
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
        rec."Shipping Guarantee Type" := rec."Shipping Guarantee Type"::Guarantee;
        rec."Import Job No." := ImpJobNo;
    end;

    var
        ImpJobNo: Code[20];


    procedure SetImportJobNo(No: Code[20])
    begin
        ImpJobNo := No;
    end;
}

