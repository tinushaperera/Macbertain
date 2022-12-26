pageextension 50223 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        addafter("Quote No.")
        {
            field("GRN Invoice No."; Rec."GRN Invoice No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purchaser Code")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Queue Status")
        {
            field("Create User ID"; Rec."Create User ID")
            {
                ApplicationArea = All;
            }
            field("Create Date Time"; Rec."Create Date Time")
            {
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
        modify("Buy-from Vendor Name")
        {
            Editable = false;
        }
        modify("Buy-from City")
        {
            Editable = false;
        }
        modify("Buy-from Contact")
        {
            Editable = false;
        }
        modify("Vendor Invoice No.")
        {
            Editable = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
        modify(Prepayment)
        {
            Visible = false;
        }
    }

    actions
    {
        addafter("Test Report")
        {
            action("Purchase Order - Local")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    PurchHedd: Record "Purchase Header";
                begin
                    PurchHedd.RESET;
                    PurchHedd.SETRANGE("Document Type", PurchHedd."Document Type"::Order);
                    PurchHedd.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50001, TRUE, TRUE, PurchHedd);
                end;
            }
            action("Purchase Order - FA")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    PurchHedd: Record "Purchase Header";
                begin
                    PurchHedd.RESET;
                    PurchHedd.SETRANGE("Document Type", PurchHedd."Document Type"::Order);
                    PurchHedd.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50018, TRUE, TRUE, PurchHedd);
                end;
            }
        }
        modify(SendApprovalRequest)
        {
            trigger OnAfterAction()
            var
                CheckDuplicatePurchaseLine: Record "Purchase Line";
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                ItemCode: Code[20];
                VarientCode: Code[20];
                Comfirmed: Boolean;
            begin
                CheckDuplicatePurchaseLine.RESET;
                CheckDuplicatePurchaseLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code");
                CheckDuplicatePurchaseLine.SETRANGE("Document Type", CheckDuplicatePurchaseLine."Document Type"::Order);
                CheckDuplicatePurchaseLine.SETRANGE(Type, CheckDuplicatePurchaseLine.Type::Item);
                CheckDuplicatePurchaseLine.SETRANGE("Document No.", Rec."No.");
                IF CheckDuplicatePurchaseLine.FINDFIRST THEN
                    REPEAT
                        IF (ItemCode <> CheckDuplicatePurchaseLine."No.") OR (VarientCode <> CheckDuplicatePurchaseLine."Variant Code") THEN BEGIN
                            ItemCode := CheckDuplicatePurchaseLine."No.";
                            VarientCode := CheckDuplicatePurchaseLine."Variant Code";
                        END
                        ELSE BEGIN
                            Comfirmed := DIALOG.CONFIRM('Item No and Varient Code is Duplicate then you need to send this order to Approvel ?', TRUE);
                            IF Comfirmed = TRUE THEN BEGIN
                                IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
                                    ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                            END;
                            IF Comfirmed = FALSE THEN
                                EXIT;
                        END;
                    UNTIL CheckDuplicatePurchaseLine.NEXT = 0;
            end;
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        //RJ
        Rec."Order Type" := Rec."Order Type"::"Local";
        //
        Rec."Create User ID" := USERID;
        Rec."Create Date Time" := CREATEDATETIME(WORKDATE, TIME);
    end;

    var
        myInt: Integer;
}