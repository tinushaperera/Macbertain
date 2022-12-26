pageextension 50205 CustomerList extends "Customer List"
{
    layout
    {
        addafter("Phone No.")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
        }
        addafter("Sales (LCY)")
        {
            field("PD Check Amount"; Rec."PD Check Amount")
            {
                ApplicationArea = All;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Contact)
        {
            field("Customer Registered Date"; Rec."Customer Registered Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
            }
            field("Customer Grade"; Rec."Customer Grade")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
        addafter("Salesperson Code")
        {
            field("Salesperson Code 2"; Rec."Salesperson Code 2")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Business Registration No."; Rec."Business Registration No.")
            {
                Visible = true;
                ApplicationArea = All;
            }
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
            field("NBT Registration No."; Rec."NBT Registration No.")
            {
                ApplicationArea = All;
            }
            field("NIC No."; Rec."NIC No.")
            {
                ApplicationArea = All;
            }
            field("Region Code"; Rec."Region Code")
            {
                ApplicationArea = All;
            }
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
            }
            field("Blocked Reason"; Rec."Blocked Reason")
            {
                ApplicationArea = All;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }

        }
        modify("Name 2")
        {
            Caption = 'FinAcc No';
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = true;
        }
        modify("Sales (LCY)")
        {
            Visible = true;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = true;
        }
        modify("Last Date Modified")
        {
            Visible = true;
        }
    }

    actions
    {
        addafter("Co&mments")
        {
            action("Reminder Letters")
            {
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Stock Age Analysis-W/O Cost-N";
            }
        }
        addafter("Sales Journal")
        {
            action(SetOverDueApproval)
            {
                ApplicationArea = all;
                Caption = 'Set Over Due Approval';
                Image = OverdueMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    NotifyMgt: Codeunit "Mail Notification Management";
                begin

                    NotifyMgt.SetCustomerOverDueApproval();

                    CurrPage.UPDATE;
                    MESSAGE('Overdue Approvals Refreshed');
                end;
            }
        }
        modify("Request Approval")
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
}