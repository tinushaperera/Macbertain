pageextension 50230 SalesOrder extends "Sales Order"
{
    layout
    {
        addafter("Sell-to City")
        {
            field("Blocked Reason"; Rec."Blocked Reason")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("Create User ID"; Rec."Create User ID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Date-Time Created"; Rec."Date-Time Created")
            {
                ApplicationArea = All;
            }
        }
        addafter("Payment Terms Code")
        {
            field(Remarks; Rec.Remarks)
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
        addafter(SalesLines)
        {
            group("Cash Customer Details")
            {
                Caption = 'Cash Customer Details';
                field("Temporary Receipt No."; Rec."Temporary Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("NIC No."; Rec."NIC No.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Prices Including VAT")
        {
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = All;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
            field("Dicount Exists"; Rec."Dicount Exists")
            {
                ApplicationArea = All;
            }
        }
        addlast(factboxes)
        {
            part("Customer Statistics"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
            }
        }
        modify("Sell-to Customer Name")
        {
            Editable = CustDetailsEditable;
        }
        modify("Sell-to Address")
        {
            Editable = CustDetailsEditable;
        }
        modify("Sell-to Address 2")
        {
            Editable = CustDetailsEditable;
        }
        modify("Sell-to Post Code")
        {
            Editable = false;
        }
        modify("Sell-to City")
        {
            Editable = false;
        }
        modify("Order Date")
        {
            Editable = false;
        }
        modify("Quote No.")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                SalesPerRec: Record "Salesperson/Purchaser";
                CustRec: Record Customer;
                SalesPer: Page "Salesperson/Purchaser Card";
            begin
                IF CustRec.GET(Rec."Sell-to Customer No.") THEN BEGIN
                    SalesPerRec.SETFILTER(SalesPerRec.Code, '%1|%2', CustRec."Salesperson Code", CustRec."Salesperson Code 2");
                    SalesPer.LOOKUPMODE(TRUE);
                    //SalesPer.RUNMODAL(
                    IF PAGE.RUNMODAL(50008, SalesPerRec) = ACTION::LookupOK THEN BEGIN
                        Rec.SalesPersonFilter := CustRec."Salesperson Code" + '|' + CustRec."Salesperson Code 2";
                        Rec.VALIDATE("Salesperson Code", SalesPerRec.Code);
                        //<Chin 20160919 1358
                        //VALIDATE("Shortcut Dimension 1 Code" , SalesPerRec."Global Dimension 1 Code");
                        //ValidateLineBUs(SalesPerRec."Global Dimension 1 Code");
                    END;
                    //>

                END;
            end;

            trigger OnAfterValidate()

            begin
                // SalespersonCodeOnAfterValidate;
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
    }

    actions
    {
        addafter("Archive Document")
        {
            action("Inventory Availability")
            {
                ApplicationArea = All;
                Caption = 'Inventory Availability';
                Image = ItemAvailability;
                Promoted = true;
                PromotedCategory = Process;
                //ApplicationArea = all;
                trigger OnAction()
                var
                    SalesHed: Record "Sales Header";
                begin
                    SalesHed.RESET;
                    SalesHed.SETRANGE("Document Type", Rec."Document Type");
                    SalesHed.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50076, TRUE, TRUE, SalesHed);
                end;
            }
        }
        modify(Approval)
        {
            Visible = false;
        }
        modify("Prepa&yment")
        {
            Visible = false;
        }
        modify(Release)
        {
            Visible = false;
        }
        modify(Plan)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            trigger OnAfterAction()
            var
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                SalesSetupRec: Record "Sales & Receivables Setup";
                ClientAppMgmt: Codeunit "Client Approval Management";
                CheckDuplicateSalesLine: Record "Sales Line";
                ItemCode: Code[20];
                VarientCode: Code[20];
                Comfirmed: Boolean;
            begin
                CheckDuplicateSalesLine.RESET;
                CheckDuplicateSalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code");
                CheckDuplicateSalesLine.SETRANGE("Document Type", CheckDuplicateSalesLine."Document Type"::Order);
                CheckDuplicateSalesLine.SETRANGE(Type, CheckDuplicateSalesLine.Type::Item);
                CheckDuplicateSalesLine.SETRANGE("Document No.", Rec."No.");
                CheckDuplicateSalesLine.FINDFIRST;
                REPEAT
                    IF (ItemCode <> CheckDuplicateSalesLine."No.") OR (VarientCode <> CheckDuplicateSalesLine."Variant Code") THEN BEGIN
                        ItemCode := CheckDuplicateSalesLine."No.";
                        VarientCode := CheckDuplicateSalesLine."Variant Code";
                    END
                    ELSE BEGIN
                        Comfirmed := DIALOG.CONFIRM('Item No and Varient Code is Duplicate then you need to send this order to Approvel ?', TRUE);
                        IF Comfirmed = TRUE THEN BEGIN
                            SalesSetupRec.GET;
                            IF SalesSetupRec."Not Standard Approval" THEN BEGIN
                                // CheckSalesOrderNotBlankFields;
                                ClientAppMgmt.CreateSalesEntry(Rec);
                            END
                            ELSE BEGIN
                                IF ApprovalsMgmt.CheckSalesApprovalPossible(Rec) THEN
                                    ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                            END;
                        END;
                        IF Comfirmed = FALSE THEN
                            EXIT;
                    END;
                UNTIL CheckDuplicateSalesLine.NEXT = 0;

                SalesSetupRec.GET;
                IF SalesSetupRec."Not Standard Approval" THEN BEGIN
                    // CheckSalesOrderNotBlankFields;
                    ClientAppMgmt.CreateSalesEntry(Rec);
                END
                ELSE BEGIN
                    IF ApprovalsMgmt.CheckSalesApprovalPossible(Rec) THEN
                        ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                END;
            end;
        }
        modify(CancelApprovalRequest)
        {
            trigger OnAfterAction()
            var
                ClientAppMgmt: Codeunit "Client Approval Management";
            begin
                //<Chin   20160627 0540
                //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                ClientAppMgmt.CancelAppRequest(Rec);
                //>
            end;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(Post)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                Rec.TESTFIELD(Status, Rec.Status::Released); //<Chin 20160627 1051
            end;
        }
        modify(PostAndSend)
        {
            Visible = true;
        }
        modify("Work Order")
        {
            Visible = false;
        }
        modify("Pick Instruction")
        {
            Visible = false;
        }

    }
    trigger OnAfterGetRecord()

    begin
        SetAddressEditable;
    end;

    trigger OnDeleteRecord(): Boolean

    begin
        CheckUser();
    end;

    trigger OnModifyRecord(): Boolean

    begin
        IF Rec."Document Type" = Rec."Document Type"::Order THEN
            Rec.SetCreditLimit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        //<Chin 20160624 1850
        SalesRecSetup.GET;
        SalesRecSetup.TESTFIELD("Sales Order Entry Code");
        Rec."Entry Code" := SalesRecSetup."Sales Order Entry Code";
        //>
    end;

    var
        SalesRecSetup: Record "Sales & Receivables Setup";
        CustDetailsEditable: Boolean;

    local procedure SetAddressEditable()
    begin
        IF Rec."Sell-to Customer No." = 'CASH' THEN
            CustDetailsEditable := TRUE
        ELSE
            CustDetailsEditable := FALSE;
    end;

    local procedure UpdateLineBUs(BUCode: Code[20])
    var
        SalesLines: Record "Sales Line";
    begin
        SalesLines.SETFILTER("Document Type", '%1', Rec."Document Type");
        SalesLines.SETFILTER("Document No.", '%1', Rec."No.");
        IF SalesLines.FINDSET THEN
            REPEAT
                SalesLines."Shortcut Dimension 1 Code" := BUCode;
                SalesLines.MODIFY;
            UNTIL SalesLines.NEXT = 0;
    end;

    local procedure ValidateLineBUs(BUCode: Code[20])
    var
        SalesLines: Record "Sales Line";
    begin
        SalesLines.SETFILTER("Document Type", '%1', Rec."Document Type");
        SalesLines.SETFILTER("Document No.", '%1', Rec."No.");
        IF SalesLines.FINDSET THEN
            REPEAT
                IF SalesLines."Shortcut Dimension 1 Code" <> BUCode THEN
                    ERROR('Line Dimensions Area different ');
            UNTIL SalesLines.NEXT = 0;
    end;

    local procedure CheckUser()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."Sales Order Delete" THEN
            ERROR('You do not have permission to delete Sales Orders');

    end;
}