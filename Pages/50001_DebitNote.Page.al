page 50001 "Debit Note"
{
    Caption = 'Debit Note';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));

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
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF rec.GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                            IF rec."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                rec.SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Additional;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Additional;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Additional;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Importance = Promoted;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    ShowMandatory = ExternalDocNoMandatory;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                }
                field("Posting Description"; rec."Posting Description")
                {
                    ApplicationArea = all;
                }
                field("Incoming Document Entry No."; rec."Incoming Document Entry No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
            part(Debitnotelines; "Debit Note Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Tax Area Code"; rec."Tax Area Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Visible = false;
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Address"; rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Additional;
                }
                field("Ship-to Address 2"; rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Additional;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Ship-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Package Tracking No."; rec."Package Tracking No.")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                    Visible = false;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        IF rec."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            rec.VALIDATE(rec."Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
            }
        }
        area(factboxes)
        {
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
                ApplicationArea = all;
            }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;

            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
                ApplicationArea = all;
            }
            part("Dimensions FactBox"; "Dimensions FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
                ApplicationArea = all;
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                Provider = DebitNoteLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                Provider = DebitNoteLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
                ApplicationArea = all;
            }
            part("Incoming Doc. Attach. FactBox"; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                Provider = DebitNoteLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Workflow Status FactBox"; "Workflow Status FactBox")
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
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Customer)
                {
                    ApplicationArea = all;
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", rec."Document Type", rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                // separator()
                // {
                // }
            }
            // group("Credit Card")
            // {
            //     Caption = 'Credit Card';
            //     Image = CreditCardLog;
            //     action("Credit Cards Transaction Lo&g Entries")
            //     {
            //         Caption = 'Credit Cards Transaction Lo&g Entries';
            //         Image = CreditCardLog;
            //         RunObject = Page 829;
            //         RunPageLink = "Document Type" = FIELD("Document Type"),
            //                       "Document No." = FIELD("No."),
            //                       "Customer No." = FIELD("Bill-to Customer No.");
            //     }
            // }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = all;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = all;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = all;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(36),
                                  "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(Release1)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 19 = R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                // separator()
                // {
                // }
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = all;
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                // separator()
                // {
                // }
                action("Copy Document")
                {
                    ApplicationArea = all;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = all;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(rec."Incoming Document Entry No.");
                        end;
                    }
                    // action(SelectIncomingDoc)
                    // {
                    //     AccessByPermission = TableData 130 = R;
                    //     Caption = 'Select Incoming Document';
                    //     Image = SelectLineToApply;
                    //     //The property 'ToolTip' cannot be empty.
                    //     //ToolTip = '';

                    //     trigger OnAction()
                    //     var
                    //         IncomingDocument: Record "Incoming Document";
                    //     begin
                    //         rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(rec."Incoming Document Entry No."));
                    //     end;
                    // }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = all;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = all;
                        Caption = 'Remove Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        begin
                            rec."Incoming Document Entry No." := 0;
                        end;
                    }
                }
            }
            // group("Credit Card")
            // {
            //     Caption = 'Credit Card';
            //     Image = AuthorizeCreditCard;
            //     action(Authorize)
            //     {
            //         Caption = 'Authorize';
            //         Image = AuthorizeCreditCard;

            //         trigger OnAction()
            //         begin
            //             Authorize;
            //         end;
            //     }
            //     action("Void A&uthorize")
            //     {
            //         Caption = 'Void A&uthorize';
            //         Image = VoidCreditCard;

            //         trigger OnAction()
            //         begin
            //             Void;
            //         end;
            //     }
            // }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    ApplicationArea = all;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = all;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Send';
                    Ellipsis = true;
                    Image = PostSendTo;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.SendToPosting(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    ApplicationArea = all;
                    Caption = 'Post and Email';
                    Image = PostMail;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit "Sales-Post + Print";
                    begin
                        SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = all;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = all;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = rec."Job queue Status" = rec."Job Queue Status"::"Scheduled for Posting";

                    trigger OnAction()
                    begin
                        rec.CancelBackgroundPosting;
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = all;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
            }
        }
    }

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    //     ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    // end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Responsibility Center" := UserMgt.GetSalesFilter;
        rec."Debit Note" := TRUE;  //RJ
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            rec.FILTERGROUP(0);
        END;

        SetDocNoVisible;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
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
        CurrPage.DebitNoteLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        IF rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
            IF rec."Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                rec.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.DebitNoteLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
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
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Invoice, rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.GET;
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;
}

