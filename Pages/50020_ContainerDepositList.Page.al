page 50020 "Container Deposit List"
{
    PageType = List;
    SourceTable = "Shipping Guarantee";
    SourceTableView = WHERE("Shipping Guarantee Type" = CONST(Deposit));
    ApplicationArea = All;
    UsageCategory = Lists;
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
                field("Deposit Date"; rec."Deposit Date")
                {
                    ApplicationArea = all;
                }
                field("Deposit Receipt No."; rec."Deposit Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("Value(LCY)"; rec."Value(LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Paid Amount';
                }
                field("Reimbursement Amount"; rec."Reimbursement Amount")
                {
                    ApplicationArea = all;
                }
                field("Cheque No."; rec."Cheque No.")
                {
                    ApplicationArea = all;
                }
                field(Bank; rec.Bank)
                {
                    ApplicationArea = all;
                }
                field("Reimbursement Date"; rec."Reimbursement Date")
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
        rec."Shipping Guarantee Type" := rec."Shipping Guarantee Type"::Deposit;
        rec."Import Job No." := ImpJobNo;
    end;

    var
        ImpJobNo: Code[20];

    procedure SetImportJobNo(No: Code[20])
    begin
        ImpJobNo := No;
    end;
}

