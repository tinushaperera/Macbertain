pageextension 50235 SalesQuote extends "Sales Quote"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Create User ID"; Rec."Create User ID")
            {
                ApplicationArea = All;
            }
            field("Date-Time Created"; Rec."Date-Time Created")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
        modify("Foreign Trade")
        {
            Editable = false;
        }
        modify("Ship-to Name")
        {
            Editable = false;
        }
        modify("Ship-to City")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }
    }

    actions
    {
        addafter(Approvals)
        {
            action("Sales Quote - Multipal")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = Report 50051;
                ApplicationArea = All;
            }
            action("Sales Quote - Single")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHedd: Record "Sales Header";
                begin
                    SalesHedd.RESET;
                    SalesHedd.SETRANGE("Document Type", Rec."Document Type");
                    SalesHedd.SETRANGE("No.", Rec."No.");
                    IF SalesHedd.FINDFIRST THEN
                        REPORT.RUNMODAL(50021, TRUE, TRUE, SalesHedd);
                end;
            }
        }
        modify(MakeOrder)
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
}