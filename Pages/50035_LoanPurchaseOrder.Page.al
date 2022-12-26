page 50035 "Loan Purchase Order"
{
    Caption = 'Loan Out Order';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            "Order Type" = CONST(Loan));

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
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Address"; rec."Buy-from Address")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Buy-from Address 2"; rec."Buy-from Address 2")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Buy-from City"; rec."Buy-from City")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Vendor Order No."; rec."Vendor Order No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = VendorInvoiceNoMandatory;
                }
                field("Order Type"; rec."Order Type")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
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
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
            part(PurchLines; "Purchase Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; rec."Pay-to Contact No.")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Address"; rec."Pay-to Address")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Pay-to Address 2"; rec."Pay-to Address 2")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Pay-to Post Code"; rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Pay-to City"; rec."Pay-to City")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Payment Discount %"; rec."Payment Discount %")
                {
                    ApplicationArea = all;
                }
                field("Pmt. Discount Date"; rec."Pmt. Discount Date")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Payment Reference"; rec."Payment Reference")
                {
                    ApplicationArea = all;
                }
                field("Creditor No."; rec."Creditor No.")
                {
                    ApplicationArea = all;
                }
                field("On Hold"; rec."On Hold")
                {
                    ApplicationArea = all;
                }
                field("Prices Including VAT"; rec."Prices Including VAT")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
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
                    Importance = Additional;
                }
                field("Ship-to Address 2"; rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Importance = Additional;
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
                field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Lead Time Calculation"; rec."Lead Time Calculation")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Promised Receipt Date"; rec."Promised Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
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
                        CLEAR(ChangeExchangeRate);
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
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Visible = false;
                field("Prepayment %"; rec."Prepayment %")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; rec."Compress Prepayment")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Payment Terms Code"; rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Due Date"; rec."Prepayment Due Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Prepmt. Payment Discount %"; rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Pmt. Discount Date"; rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
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
            part("Item Replenishment FactBox"; "Item Replenishment FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Buy-from Vendor No.");
                Visible = false;
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = true;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
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
                ApplicationArea = All;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
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
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        rec.OpenPurchaseOrderStatistics;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
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
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
            }
            group(Warehouse1)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                // separator()
                // {
                // }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                // action("Whse. Receipt Lines")
                // {
                //     Caption = 'Whse. Receipt Lines';
                //     Image = ReceiptLines;
                //     RunObject = Page "Whse. Receipt Lines";
                //     RunPageLink = "Source Type" = CONST(39),
                //                   "Source Subtype" = FIELD("Document Type"),
                //                   "Source No." = FIELD("No.");
                //     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                // }
                // separator()
                // {
                // }
                group("Dr&op Shipment1")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Get &Sales Order1")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                }
                group("Speci&al Order1")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Get &Sales Order2")
                    {
                        AccessByPermission = TableData 110 = R;
                        Caption = 'Get &Sales Order';
                        Image = "Order";

                        trigger OnAction()
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
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
                    ApplicationArea = All;
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
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                // separator()
                // {
                // }
                action(Release1)
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
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
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
                action(MoveNegativeLines)
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
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Get &Sales Order3")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Get &Sales Order")
                    {
                        AccessByPermission = TableData 110 = R;
                        Caption = 'Get &Sales Order';
                        Image = "Order";

                        trigger OnAction()
                        var
                            DistIntegration: Codeunit "Dist. Integration";
                            PurchHeader: Record "Purchase Header";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData 410 = R;
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit "ICInboxOutboxMgt";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                            ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
                // separator()
                // {
                // }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
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
                    //         rec.VALIDATE(rec."Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(rec."Incoming Document Entry No."));
                    //     end;
                    // }
                    action(IncomingDocAttachFile)
                    {
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
                            IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
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
            group("Request Approval")
            {
                Caption = 'Request Approval';
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
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData 7316 = R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        IF NOT rec.FIND('=><') THEN
                            rec.INIT;
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7340 = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        rec.CreateInvtPutAwayPick;

                        IF NOT rec.FIND('=><') THEN
                            rec.INIT;
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
                action(Post3)
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
                action("Post and &Print")
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
                action("Test Report")
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
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        rec.CancelBackgroundPosting;
                    end;
                }
                // separator()
                // {
                // }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment Test &Report")
                    {
                        Caption = 'Prepayment Test &Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
                        end;
                    }
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
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
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
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

    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //<CHin 2016/05/09
        Rec."Order Type" := Rec."Order Type"::Loan;
        //>
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    begin
        SetDocNoVisible;

        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit "ArchiveManagement";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        [InDataSet]

        JobQueueVisible: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
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

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit "DocumentNoVisibility";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET;
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;
}

