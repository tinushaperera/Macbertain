page 50042 "Client Approval Setup"
{
    PageType = List;
    SourceTable = "Client Approval User Setup";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table No."; rec."Table No.")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; rec."Table Name")
                {
                    ApplicationArea = All;
                }
                field("Table Code"; rec."Table Code")
                {
                    ApplicationArea = All;
                }
                field("Approve Type"; rec."Approve Type")
                {
                    ApplicationArea = All;
                }
                field("Approval Sequence No."; rec."Approval Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Approve Lower Limit"; rec."Approve Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Approve Upper Limit"; rec."Approve Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Approve User ID"; rec."Approve User ID")
                {
                    ApplicationArea = All;
                }
                field("Approval Method"; rec."Approval Method")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        rec.MODIFY;
                        //CurrPage.UPDATE(TRUE);
                    end;
                }
                field("Sequence Line No."; rec."Sequence Line No.")
                {
                    ApplicationArea = All;
                }
                field("Send Request Mail"; rec."Send Request Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Request E-Mail';
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

