page 50037 "Loan Purchase Return Order"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Loan Purchase Return Order';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER("Return Order"),
                            "Order Type" = CONST(Return));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Buy-from Address"; rec."Buy-from Address")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Buy-from Address 2"; rec."Buy-from Address 2")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Buy-from City"; rec."Buy-from City")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    QuickEntry = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Order Type"; rec."Order Type")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    QuickEntry = false;
                }
            }
            part(PurchLines; "Purchase Return Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Visible = false;
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address"; rec."Ship-to Address")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address 2"; rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF rec."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Entry Point"; rec."Entry Point")
                {
                    ApplicationArea = all;
                }
                field("Area"; rec."Area")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No."),
                              Status = CONST(Open);
                Visible = false;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part("Purchase Line FactBox"; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            // systempart(;Links)
            // {
            //     Visible = false;
            // }
            // systempart(;Notes)
            // {
            //     Visible = true;
            // }
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
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Mat. Loan Out")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Loan Out Entry";
                }
                action("Co&mments")
                {
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
                    Caption = 'Return Shipments';
                    Image = Shipment;
                    RunObject = Page "Posted Return Shipments";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                action("Cred&it Memos")
                {
                    Caption = 'Cred&it Memos';
                    Image = CreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                // separator()
                // {
                // }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                // action("Whse. Shipment Lines")
                // {
                //     Caption = 'Whse. Shipment Lines';
                //     Image = ShipmentLines;
                //     RunObject = Page "Whse. Shipment Lines";
                //     RunPageLink = "Source Type" = CONST(39),
                //                   "Source Subtype" = FIELD("Document Type"),
                //                   "Source No." = FIELD("No.");
                //     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                // }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Return Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(38),
                                  "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            action("&Print")
            {
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
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
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
                action(GetPostedDocumentLinesToReverse)
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse';
                    Ellipsis = true;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.GetPstdDocLinesToReverse();

                        CurrPage.PurchLines.Page.PurchaseDocTotalsNotUpToDate();
                        CurrPage.PurchLines.Page.Update(false);
                    end;
                }
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Purchase Header Apply", Rec);
                    end;
                }
                // separator()
                // {
                // }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData 24 = R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                // separator()
                // {
                // }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archive Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Return Order")
                {
                    AccessByPermission = TableData 410 = R;
                    Caption = 'Send IC Return Order';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutMgt: Codeunit "ICInboxOutboxMgt";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                            ICInOutMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
                // separator()
                // {
                // }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = Approval;
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

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
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                // separator()
                // {
                // }
            }
            group(Warehouse2)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Shipment")
                {
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
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7342 = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        rec.CreateInvtPutAwayPick;
                    end;
                }
                // separator()
                // {
                // }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purch. Ret. Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        rec.CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(rec.RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(rec.ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Chin
        rec."Order Type" := rec."Order Type"::Return;
        //
        rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            rec.FILTERGROUP(0);
        END;

        SetDocNoVisible;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";


        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit "ArchiveManagement";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        // [InDataSet]

        JobQueueVisible: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        rec.SendToPosting(PostingCodeunitID);
        IF rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit "DocumentNoVisibility";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Return Order", rec."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting";
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;
}

