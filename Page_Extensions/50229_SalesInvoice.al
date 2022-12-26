pageextension 50229 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        addafter("Job Queue Status")
        {
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Invoice Despatch No."; Rec."Invoice Despatch No.")
            {
                ApplicationArea = All;
            }
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
        modify("Sell-to Post Code")
        {
            Editable = false;
        }
        modify("Sell-to City")
        {
            Editable = false;
        }
        modify("Posting Date")
        {
            Editable = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
        modify("Bill-to Name")
        {
            Editable = false;
        }
        modify("Bill-to Address")
        {
            Editable = false;
        }
        modify("Bill-to Address 2")
        {
            Editable = false;
        }
        modify("Bill-to Post Code")
        {
            Editable = false;
        }
        modify("Bill-to City")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
        modify("Direct Debit Mandate ID")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Editable = false;
        }
        modify("Ship-to Name")
        {
            Editable = false;
        }
        modify("Ship-to Address")
        {
            Editable = false;
        }
        modify("Ship-to Address 2")
        {
            Editable = false;
        }
        modify("Ship-to Post Code")
        {
            Editable = false;
        }
        modify("Ship-to City")
        {
            Editable = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Editable = true;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Transport Method")
        {
            Visible = false;
        }
        modify("Exit Point")
        {
            Visible = false;
        }
        modify("Area")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnDeleteRecord(): Boolean

    begin
        CheckUser();
    end;

    local procedure CheckUser()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."Sales Order Delete" THEN
            ERROR('You do not have permission to delete Sales Invoices');

    end;
}