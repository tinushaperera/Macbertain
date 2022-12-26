pageextension 50201 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter(City)
        {
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Region Code"; Rec."Region Code")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
        addafter("Primary Contact No.")
        {
            field(Contact; Rec.Contact)
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter("Salesperson Code")
        {
            field("Salesperson Code 2"; Rec."Salesperson Code 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Name")
        {
            field("Customer Registered Date"; Rec."Customer Registered Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Customer Grade"; Rec."Customer Grade")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter(Balance)
        {
            field("Bank Guarantee Amount"; Rec."Bank Guarantee Amount")
            {
                ApplicationArea = All;
                DrillDownPageId = "Bank Guarantee List";
            }
            field("Promissory Note Amount"; Rec."Promissory Note Amount")
            {
                ApplicationArea = All;
                DrillDownPageId = "Customer Security List";
            }
            field("PD Check Amount"; Rec."PD Check Amount")
            {
                ApplicationArea = All;
                Caption = 'PD Cheque Amount';
            }

        }
        addafter("Credit Limit (LCY)")
        {
            field("Ship to Address Exists"; Rec."Ship to Address Exists")
            {
                ApplicationArea = All;
            }
            field("Blocked Reason"; Rec."Blocked Reason")
            {
                ApplicationArea = All;
                Caption = 'FinAcc No';
            }

        }
        addafter("Last Date Modified")
        {
            field(Reject; Rec.Reject)
            {
                ApplicationArea = All;
                Editable = RejectEditable;
            }
            field("Reject Reason"; Rec."Reject Reason")
            {
                ApplicationArea = All;
                Editable = RejectEditable;
            }
        }
        addafter("Home Page")
        {
            field("Industry Type"; Rec."Industry Type")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Business Registration No."; Rec."Business Registration No.")
            {
                ApplicationArea = All;
            }
            field("NIC No."; Rec."NIC No.")
            {
                ApplicationArea = All;
            }
            field("Invoice Copies"; Rec."Invoice Copies")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("VAT Registration No.")
        {
            field("NBT Registration No."; Rec."NBT Registration No.")
            {
                ApplicationArea = All;
            }
            field("SVAT Registration No."; Rec."SVAT Registration No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Allow Line Disc.")
        {
            field("Prevent Cus.Statement Print"; Rec."Prevent Cus.Statement Print")
            {
                ApplicationArea = All;
            }
        }
        modify(General)
        {
            Editable = CardEditable;
        }

        modify("Country/Region Code")
        {
            ShowMandatory = true;
        }
        modify("No.")
        {
            ShowMandatory = true;
        }
        modify(Address)
        {
            ShowMandatory = true;
        }
        modify("Address 2")
        {
            ShowMandatory = true;
        }
        modify(County)
        {
            Editable = false;
        }
        modify(City)
        {
            ShowMandatory = true;
        }
        modify("Phone No.")
        {
            ShowMandatory = true;
        }
        modify("Primary Contact No.")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            ShowMandatory = true;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Service Zone Code")
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            ShowMandatory = true;
        }
        modify("Name 2")
        {
            Caption = 'FinAcc No';
        }
        modify(Blocked)
        {
            Visible = false;
            trigger OnAfterValidate()

            begin
                CurrPage.Update();
            end;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify(Invoicing)
        {
            Editable = CardEditable;
        }
        modify("Invoice Disc. Code")
        {
            Visible = false;
        }
        modify("Copy Sell-to Addr. to Qte From")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Editable = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Editable = false;
        }
        modify("VAT Registration No.")
        {
            Editable = true;

            trigger OnDrillDown()
            var
                VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
            begin
                VATRegistrationLogMgt.AssistEditCustomerVATReg(Rec);
            end;
        }
        modify("Customer Price Group")
        {
            Editable = true;
            ShowMandatory = true;
        }
        modify("Customer Posting Group")
        {
            Editable = true;
        }
        modify("Allow Line Disc.")
        {
            Editable = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify(Payments)
        {
            Editable = CardEditable;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Editable = true;
        }
        modify("Payment Method Code")
        {
            Editable = true;
        }
        modify("Reminder Terms Code")
        {
            Visible = false;
        }
        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Print Statements")
        {
            Editable = false;
        }
        modify("Last Statement No.")
        {
            Editable = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Preferred Bank Account Code")
        {
            Visible = false;
        }
        modify(Shipping)
        {
            Editable = CardEditable;
        }
        modify("Combine Shipments")
        {
            Visible = false;
        }
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            ShowMandatory = true;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            Visible = false;
        }
        modify("Customized Calendar")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Editable = true;
        }
        modify("Language Code")
        {
            Visible = false;
        }
    }

    actions
    {
        addafter("Request Approval")
        {
            action(SendToApprove)
            {
                Caption = 'Send To Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    IF Rec.Blocked = Rec.Blocked::New THEN BEGIN
                        Rec.CheckNotBlankFields;
                        Rec.Blocked := Rec.Blocked::"Pending Approval";
                        // Rec.SendApproveRequestMail;
                    END;
                    IF Rec.Blocked = Rec.Blocked::All THEN BEGIN
                        Rec.CheckNotBlankFields;
                        Rec.Blocked := Rec.Blocked::"Pending Approval";
                        // Rec.SendApproveRequestMail;
                    END;
                end;
            }
            action(ApproveCust)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    UserSetupRec: Record "User Setup";
                    MailMgt: Codeunit "Email Logging Dispatcher";
                begin
                    UserSetupRec.GET(USERID);
                    Rec.TESTFIELD(Blocked, Rec.Blocked::"Pending Approval");
                    Rec.TESTFIELD(Reject, FALSE);//NS
                    UserSetupRec.TESTFIELD("Customer Approval", TRUE);
                    Rec.VALIDATE(Blocked, Rec.Blocked::" ");
                    Rec."Approved Date" := TODAY;
                    IF Rec."Customer Registered Date" = 0D THEN
                        Rec."Customer Registered Date" := TODAY;
                    COMMIT;
                    // Rec.SendApproveMail;
                end;
            }
            action("Block Customer")
            {
                Caption = 'Block Customer';
                Image = CapableToPromise;
                ApplicationArea = all;
                trigger OnAction()
                var
                    UserSetupRec: Record "User Setup";
                begin
                    UserSetupRec.GET(USERID);
                    Rec.TESTFIELD(Blocked, Rec.Blocked::" ");
                    UserSetupRec.TESTFIELD("Customer Approval", TRUE);
                    Rec.VALIDATE(Blocked, Rec.Blocked::All);
                end;
            }
            action("Customer Securities")
            {
                Image = CustomerRating;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Customer Security List";
                ApplicationArea = all;
                Visible = false;
            }
        }
        modify(Dimensions)
        {
            Visible = true;
        }
        modify(ShipToAddresses)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Approval)
        {
            Enabled = false;
            Visible = false;
        }
        modify(Approve)
        {
            Enabled = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }

    }

    trigger OnModifyRecord(): Boolean
    var
        Customer: Record Customer;
    begin
        IF (Rec.Blocked = xRec.Blocked) THEN BEGIN // Blocked::" " THEN BEGIN
            Rec.VALIDATE(Blocked, Rec.Blocked::All);
            Rec.MODIFY;
        END;
        IF Rec.Blocked = Rec.Blocked::"Pending Approval" THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
    end;

    trigger OnOpenPage()

    begin
        GettingUserControls();
    end;

    trigger OnAfterGetRecord()

    begin
        IF Rec.Blocked = Rec.Blocked::"Pending Approval" THEN
            CardEditable := FALSE
        ELSE
            CardEditable := TRUE;
    end;

    local procedure GettingUserControls()
    var
        UserSetup: Record "User Setup";
    begin
        CLEAR(UserSetup);
        UserSetup.GET(USERID);
        IF UserSetup."Reject Editable" THEN
            RejectEditable := TRUE;
    end;

    var
        CardEditable: Boolean;
        RejectEditable: Boolean;
}