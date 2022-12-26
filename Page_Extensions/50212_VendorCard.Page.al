pageextension 50212 VendorCard extends "Vendor Card"
{
    layout
    {
        addafter("Balance (LCY)")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purchaser Code")
        {
            field("Account Payee"; Rec."Account Payee")
            {
                ApplicationArea = All;
            }
            field("Business Reg.No"; Rec."Business Reg.No")
            {
                ApplicationArea = All;
            }
        }
        modify("Name 2")
        {
            Caption = 'FinAcc No';
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("VAT Registration No.")
        {
            trigger OnDrillDown()
            var
                VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
            begin
                VATRegistrationLogMgt.AssistEditVendorVATReg(Rec);
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}