page 50046 "Material Loan-Out"
{
    ApplicationArea = All;
    Caption = 'Material Loan - Out';
    CardPageID = "Loan Purchase Return Order";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST("Return Order"),
                            "Order Type" = CONST(Return));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            systempart(RecordLinks; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Return Order")
            {
                Caption = '&Return Order';
                Image = Return;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        rec.OpenPurchaseOrderStatistics;
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsPurchase(Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("Return Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Return Shipments';
                    Image = Shipment;
                    RunObject = Page "Posted Return Shipments";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                action("Cred&it Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Cred&it Memos';
                    Image = CreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }

            }
            group(Warehousegrp)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5774;
                    RunPageLink = "Source Document" = CONST("Purchase Return Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                // action("Whse. Shipment Lines")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Whse. Shipment Lines';
                //     Image = ShipmentLines;
                //     RunObject = Page 7341;
                //     RunPageLink = "Source Type" = CONST(39),
                //                   "Source Subtype" = FIELD("Document Type"),
                //                   "Source No." = FIELD("No.");
                //     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                // }
            }
        }
        area(processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(ReleaseGrp)
            {

                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                // separator()
                // {
                // }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                // action("Get Posted Doc&ument Lines to Reverse")
                // {
                //     Caption = 'Get Posted Doc&ument Lines to Reverse';
                //     Ellipsis = true;
                //     Image = ReverseLines;

                //     trigger OnAction()
                //     begin
                //         GetPstdDocLinesToRevere;
                //     end;
                // }
                // action(GetPostedDocumentLinesToReverse1)
                // {
                //     ApplicationArea = PurchReturnOrder;
                //     Caption = 'Get Posted Doc&ument Lines to Reverse';
                //     Ellipsis = true;
                //     Image = ReverseLines;
                //     ToolTip = 'Copy one or more posted purchase document lines in order to reverse the original order.';

                //     trigger OnAction()
                //     begin
                //         rec.GetPstdDocLinesToReverse();
                //         CurrPage.PurchLines.Page.PurchaseDocTotalsNotUpToDate();
                //         CurrPage.PurchLines.Page.Update(false);
                //     end;
                // }
                action("Send IC Return Order")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 410 = R;
                    Caption = 'Send IC Return Order';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                            ICInOutMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(rec.RecordId);
                    end;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    begin
                        rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 7320 = R;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromPurchaseReturnOrder(Rec);
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(TestReport)
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                // action(Preview)
                // {
                //     Caption = 'Preview Posting';
                //     Image = ViewPostedOrder;

                //     trigger OnAction()

                //     begin
                //         ShowPreview();
                //     end;
                // }
                // action(PostAndPrint)
                // {
                //     Caption = 'Post and &Print';
                //     Ellipsis = true;
                //     Image = PostPrint;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     ShortCutKey = 'Shift+F9';

                //     trigger OnAction()
                //     begin
                //         SendToPosting(CODEUNIT::"Purch.-Post + Print");
                //     end;
                // }
                action(PostBatch)
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purch. Ret. Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(rec."Incoming Document Entry No.") then
                            IncomingDocument.RemoveLinkToRelatedRecord();
                        rec."Incoming Document Entry No." := 0;
                        rec.Modify(true);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    var
    //  PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //SetOpenPage();

        ActivateFields();

        SetPostingGroupEditable();
        CheckShowBackgrValidationNotification();
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Document-Print";
        GLSetup: Record "General Ledger Setup";
        OpenPostedPurchaseReturnOrderQst: Label 'The return order is posted as number %1 and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';
        DocumentIsPosted: Boolean;
        [InDataSet]
        IsJournalTemplNameVisible: Boolean;
        [InDataSet]
        IsPaymentMethodCodeVisible: Boolean;
        [InDataSet]
        IsPostingGroupEditable: Boolean;
        [InDataSet]
        IsPurchaseLinesEditable: Boolean;
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        IsBuyFromCountyVisible: Boolean;
        IsPayToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;
        PurchaseDocCheckFactboxVisible: Boolean;
        FormatAddress: Codeunit "Format Address";
        PurchSetup: Record "Purchases & Payables Setup";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;

    local procedure ActivateFields()
    begin
        IsBuyFromCountyVisible := FormatAddress.UseCounty(Rec."Buy-from Country/Region Code");
        IsPayToCountyVisible := FormatAddress.UseCounty(Rec."Pay-to Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
        GLSetup.Get();
        IsJournalTemplNameVisible := GLSetup."Journal Templ. Name Mandatory";
        IsPaymentMethodCodeVisible := not GLSetup."Hide Payment Method Code";
        IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();
    end;

    procedure SetPostingGroupEditable()
    begin
        PurchSetup.GetRecordOnce();
        IsPostingGroupEditable := PurchSetup."Allow Multiple Posting Groups";
    end;

    local procedure CheckShowBackgrValidationNotification()
    var
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
    begin
        if DocumentErrorsMgt.CheckShowEnableBackgrValidationNotification() then
            SetControlAppearance();
    end;

    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsHandled: Boolean;
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := not PurchaseHeader.Get(Rec."Document Type", Rec."No.");

        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.Close();
        CurrPage.Update(false);

        IsHandled := false;
        //OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
            ShowPostedConfirmationMessage();
    end;

    procedure CallPostDocument(PostingCodeunitID: Integer)
    begin
        PostDocument(PostingCodeunitID);
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        ReturnOrderPurchaseHeader: Record "Purchase Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not ReturnOrderPurchaseHeader.Get(Rec."Document Type", Rec."No.") then begin
            PurchCrMemoHdr.SetRange("No.", Rec."Last Posting No.");
            if PurchCrMemoHdr.FindFirst() then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseReturnOrderQst, PurchCrMemoHdr."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode())
                then
                    InstructionMgt.ShowPostedDocument(PurchCrMemoHdr, Page::"Purchase Return Order");
        end;
    end;
}

