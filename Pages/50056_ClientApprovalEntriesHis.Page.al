page 50056 "Client Approval Entries His."
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Client Approval Entries His..';
    Editable = false;
    PageType = List;
    SourceTable = "Client Approval Entry";

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
                field("Table Code"; rec."Table Code")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Approve Type"; rec."Approve Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Approved ID"; rec."Approved ID")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Approved"; rec."Date-Time Approved")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Credit Limit (LCY)"; rec."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Amount (LCY)"; rec."Total Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Due Amount (LCY)"; rec."Due Amount (LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

