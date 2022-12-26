pageextension 50227 SalesCrMemoPage extends "Sales Credit Memo"
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
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
        addafter("Applies-to Doc. No.")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }
        addafter("Payment Method Code")
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Billing)
        {
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        modify("Sell-to Customer No.")
        {
            Editable = true;
        }
        modify("Sell-to Customer Name")
        {
            Editable = false;
        }
        modify("Sell-to Address")
        {
            Editable = false;
        }
        modify("Sell-to Address 2")
        {
            Editable = false;
        }
        modify("Sell-to City")
        {
            Editable = false;
        }
        modify("Document Date")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }

    }

    actions
    {
        addafter(Dimensions)
        {
            action("Credit Note - Non St.")
            {
                Caption = 'Credit Note - Non St.';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    SalesCredHedd: Record "Sales Header";
                begin
                    SalesCredHedd.RESET;
                    SalesCredHedd.SETRANGE("Document Type", Rec."Document Type");
                    SalesCredHedd.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50017, TRUE, TRUE, SalesCredHedd);
                end;
            }
            action("Credit Note")
            {
                Caption = 'Credit Note';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    SalesHedd: Record "Sales Header";
                begin
                    SalesHedd.RESET;
                    SalesHedd.SETRANGE("Document Type", Rec."Document Type");
                    SalesHedd.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50026, TRUE, TRUE, SalesHedd);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean

    begin
        CheckUser;
    end;

    local procedure CheckUser()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."Sales Order Delete" THEN
            ERROR('You do not have permission to delete Sales Credit Memos');

    end;
}