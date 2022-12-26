pageextension 50222 PurchaseInvoice extends "Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("Create User ID"; Rec."Create User ID")
            {
                ApplicationArea = All;
            }
            field("Create Date Time"; Rec."Create Date Time")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purchaser Code")
        {
            field("Import Job No."; Rec."Import Job No.")
            {
                Style = Ambiguous;
                StyleExpr = true;
                ApplicationArea = All;
            }
        }
        addafter("Tax Area Code")
        {
            field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            {
                ApplicationArea = All;
            }
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}