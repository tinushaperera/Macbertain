// page 50014 "Sample Sales Order"
// {
//     Caption = 'Sample Sales Order';
//     DeleteAllowed = true;
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = "Sales Header";
//     SourceTableView = WHERE("Document Type" = FILTER(Order),
//                             "Order Type" = FILTER(Sample));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; Rec."No.")
//                 {
//                     Importance = Promoted;
//                     Visible = DocNoVisible;

//                     trigger OnAssistEdit()
//                     begin
//                         IF Rec.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Sell-to Customer No."; Rec."Sell-to Customer No.")
//                 {
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         SelltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
//                 {
//                     QuickEntry = false;
//                 }
//                 field("Sell-to Address"; Rec."Sell-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Sell-to Address 2"; Rec."Sell-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Sell-to Post Code"; Rec."Sell-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Sell-to City"; Rec."Sell-to City")
//                 {
//                     QuickEntry = false;
//                 }
//                 field("Create User ID"; Rec."Create User ID")
//                 {
//                     Editable = false;
//                 }
//                 field("Date-Time Created"; Rec."Date-Time Created")
//                 {
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     QuickEntry = false;
//                 }
//                 field("External Document No."; Rec."External Document No.")
//                 {
//                     Importance = Promoted;
//                     ShowMandatory = ExternalDocNoMandatory;
//                 }
//                 field("Salesperson Code"; Rec."Salesperson Code")
//                 {
//                     QuickEntry = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     var
//                         SalesPerRec: Record "Salesperson/Purchaser";
//                         CustRec: Record Customer;
//                         SalesPer: Page "Salesperson/Purchaser Card";
//                     begin
//                         // IF CustRec.GET("Sell-to Customer No.") THEN BEGIN
//                         //     SalesPerRec.SETFILTER(SalesPerRec.Code, '%1|%2', CustRec."Salesperson Code", CustRec."Salesperson Code 2");
//                         //     SalesPer.LOOKUPMODE(TRUE);
//                         //     //SalesPer.RUNMODAL(
//                         //     IF PAGE.RUNMODAL(50008, SalesPerRec) = ACTION::LookupOK THEN
//                         //         "Salesperson Code" := SalesPerRec.Code;

//                         // END;
//                     end;

//                     trigger OnValidate()
//                     begin
//                         SalespersonCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//             }
//             group("Cash Customer Details")
//             {
//                 Caption = 'Cash Customer Details';
//                 Visible = false;
//                 field("Temporary Receipt No."; Rec."Temporary Receipt No.")
//                 {
//                 }
//                 field("NIC No."; Rec."NIC No.")
//                 {
//                 }
//                 field("Vehicle No."; Rec."Vehicle No.")
//                 {
//                 }
//             }
//             // part(SalesLines; 50016)
//             // {
//             //     Editable = DynamicEditable;
//             //     SubPageLink = "Document No." = FIELD("No.");
//             //     UpdatePropagation = Both;
//             // }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 Visible = false;
//                 field("Payment Terms Code"; Rec."Payment Terms Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; Rec."Payment Discount %")
//                 {
//                 }
//                 field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
//                 {
//                 }
//                 field("Payment Method Code"; Rec."Payment Method Code")
//                 {
//                 }
//                 field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
//                 {
//                 }
//                 field("Prices Including VAT"; Rec."Prices Including VAT")
//                 {

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
//                 {
//                 }
//                 // field("Credit Card No."; Rec."Credit Card No.")
//                 // {
//                 // }
//                 // field(GetCreditcardNumber; Rec.GetCreditcardNumber)
//                 // {
//                 //     Caption = 'Cr. Card Number (Last 4 Digits)';
//                 // }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Code"; Rec."Ship-to Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Ship-to Name"; Rec."Ship-to Name")
//                 {
//                 }
//                 field("Ship-to Address"; Rec."Ship-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to Address 2"; Rec."Ship-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to City"; Rec."Ship-to City")
//                 {
//                 }
//                 field("Location Code"; Rec."Location Code")
//                 {
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 Visible = false;
//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         // CLEAR(ChangeExchangeRate);
//                         // IF "Posting Date" <> 0D THEN
//                         //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
//                         // ELSE
//                         //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
//                         // IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                         //     VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                         //     CurrPage.UPDATE;
//                         // END;
//                         // CLEAR(ChangeExchangeRate);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         CurrPage.UPDATE;
//                         SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
//                     end;
//                 }
//                 field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
//                 {
//                 }
//                 field("Transaction Type"; Rec."Transaction Type")
//                 {
//                 }
//                 field("Transaction Specification"; Rec."Transaction Specification")
//                 {
//                 }
//                 field("Transport Method"; Rec."Transport Method")
//                 {
//                 }
//                 field("Exit Point"; Rec."Exit Point")
//                 {
//                 }
//                 // field(Area;Area)
//                 // {
//                 // }
//             }
//             group(Prepayment1)
//             {
//                 Caption = 'Prepayment';
//                 Visible = false;
//                 field("Prepayment %"; Rec."Prepayment %")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment"; Rec."Compress Prepayment")
//                 {
//                 }
//                 field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
//                 {
//                 }
//                 field("Prepayment Due Date"; Rec."Prepayment Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
//                 {
//                 }
//                 field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
//                 {
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part("Pending Approval FactBox"; "Pending Approval FactBox")
//             {
//                 SubPageLink = "Table ID" = CONST(36),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//             }
//             part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = true;
//             }
//             part("Customer Statistics FactBox"; "Customer Statistics FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = false;
//             }
//             part("Customer Details FactBox"; "Customer Details FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = false;
//             }
//             part("Sales Line FactBox"; "Sales Line FactBox")
//             {
//                 // Provider = SalesLines;
//                 // SubPageLink = "Document Type" = FIELD("Document Type"),
//                 //               "Document No." = FIELD("No."),
//                 //               "Line No." = FIELD("Line No.");
//                 // Visible = true;
//             }
//             part("Item Invoicing FactBox"; "Item Invoicing FactBox")
//             {
//                 // Provider = SalesLines;
//                 // SubPageLink = "No." = FIELD("No.");
//                 // Visible = false;
//             }
//             // part(""; 9092)
//             // {
//             //     SubPageLink = "Table ID" = CONST(36),
//             //                   "Document Type" = FIELD("Document Type"),
//             //                   "Document No." = FIELD("No.");
//             //     Visible = false;
//             // }
//             part(IncomingDocAttachFactBox; 193)
//             {
//                 ShowFilter = false;
//                 Visible = false;
//             }
//             // part(""; 9108)
//             // {
//             //     Provider = SalesLines;
//             //     SubPageLink = "No." = FIELD("No.");
//             //     Visible = false;
//             // }
//             // part(""; 9109)
//             // {
//             //     Provider = SalesLines;
//             //     SubPageLink = "No." = FIELD("No.");
//             //     Visible = false;
//             // }
//             // part(""; 9081)
//             // {
//             //     SubPageLink = "No." = FIELD("Bill-to Customer No.");
//             //     Visible = false;
//             // }
//             part(WorkflowStatus; 1528)
//             {
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart("Links"; Links)
//             {
//                 Visible = false;
//             }
//             systempart("Notes"; Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("O&rder")
//             {
//                 Caption = 'O&rder';
//                 Image = "Order";
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         Rec.OpenSalesOrderStatistics;
//                         SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Card)
//                 {
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Customer Card";
//                     RunPageLink = "No." = FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348 = R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         Rec.ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action("A&pprovals")
//                 {
//                     Caption = 'A&pprovals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 67;
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                 }
//                 action("Credit Cards Transaction Lo&g Entries")
//                 {
//                     Caption = 'Credit Cards Transaction Lo&g Entries';
//                     Image = CreditCardLog;
//                     // RunObject = Page 829;
//                     // RunPageLink = "Document No." = FIELD("No."),
//                     //               "Customer No." = FIELD("Bill-to Customer No.");
//                 }
//                 action("Assembly Orders")
//                 {
//                     AccessByPermission = TableData 90 = R;
//                     Caption = 'Assembly Orders';
//                     Image = AssemblyOrder;

//                     trigger OnAction()
//                     var
//                         AssembleToOrderLink: Record "Assemble-to-Order Link";
//                     begin
//                         AssembleToOrderLink.ShowAsmOrders(Rec);
//                     end;
//                 }
//             }
//             group(ActionGroupCRM)
//             {
//                 Caption = 'Dynamics CRM';
//                 Visible = CRMIntegrationEnabled;
//                 action(CRMGoToSalesOrder)
//                 {
//                     Caption = 'Sales Order';
//                     Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
//                     Image = CoupledOrder;
//                     ToolTip = 'Open the coupled Microsoft Dynamics CRM sales order.';

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit "CRM Integration Management";
//                     begin
//                         CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RECORDID);
//                     end;
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action("S&hipments")
//                 {
//                     Caption = 'S&hipments';
//                     Image = Shipment;
//                     RunObject = Page 142;
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action(Invoices)
//                 {
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     RunObject = Page 143;
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//             }
//             group(Warehouse1)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                     RunPageLink = "Source Document" = CONST("Sales Order"),
//                                   "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Document", "Source No.", "Location Code");
//                 }
//                 action("Whse. Shipment Lines")
//                 {
//                     Caption = 'Whse. Shipment Lines';
//                     Image = ShipmentLines;
//                     RunObject = Page 7341;
//                     RunPageLink = "Source Type" = CONST(37),
//                                   "Source Subtype" = FIELD("Document Type"),
//                                   "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 Image = Prepayment;
//                 action(PagePostedSalesPrepaymentInvoices)
//                 {
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 143;
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//                 action("Prepayment Credi&t Memos")
//                 {
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 144;
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     RunObject = Page 660;
//                     RunPageLink = "Table ID" = CONST(36),
//                                   "Document Type" = FIELD("Document Type"),
//                                   "Document No." = FIELD("No.");
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                 }
//             }
//             group(Release1)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 action(Release)
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "Release Sales Document";
//                     begin
//                         ReleaseSalesDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "Release Sales Document";
//                     begin
//                         ReleaseSalesDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(CalculateInvoiceDiscount)
//                 {
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                         SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action("Get St&d. Cust. Sales Codes")
//                 {
//                     Caption = 'Get St&d. Cust. Sales Codes';
//                     Ellipsis = true;
//                     Image = CustomerCode;

//                     // trigger OnAction()
//                     // var
//                     //     StdCustSalesCode: Record "172";
//                     // begin
//                     //     StdCustSalesCode.InsertSalesLines(Rec);
//                     // end;
//                 }
//                 action(CopyDocument)
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CopySalesDoc.SetSalesHeader(Rec);
//                         CopySalesDoc.RUNMODAL;
//                         CLEAR(CopySalesDoc);
//                     end;
//                 }
//                 action(MoveNegativeLines)
//                 {
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegSalesLines);
//                         MoveNegSalesLines.SetSalesHeader(Rec);
//                         MoveNegSalesLines.RUNMODAL;
//                         MoveNegSalesLines.ShowDocument;
//                     end;
//                 }
//                 action("Archive Document")
//                 {
//                     Caption = 'Archi&ve Document';
//                     Image = Archive;

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchiveSalesDocument(Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Send IC Sales Order Cnfmn.")
//                 {
//                     AccessByPermission = TableData 410 = R;
//                     Caption = 'Send IC Sales Order Cnfmn.';
//                     Image = IntercompanyOrder;

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                             ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
//                     end;
//                 }
//                 group(IncomingDocument)
//                 {
//                     Caption = 'Incoming Document';
//                     Image = Documents;
//                     action(IncomingDocCard)
//                     {
//                         Caption = 'View Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = ViewOrder;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         // trigger OnAction()
//                         // var
//                         //     IncomingDocument: Record "Incoming Document";
//                         // begin
//                         //     IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
//                         // end;
//                     }
//                     action(SelectIncomingDoc)
//                     {
//                         AccessByPermission = TableData 130 = R;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         // trigger OnAction()
//                         // var
//                         //     IncomingDocument: Record "130";
//                         // begin
//                         //     VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
//                         // end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = NOT HasIncomingDocument;
//                         Image = Attach;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         // trigger OnAction()
//                         // var
//                         //     IncomingDocumentAttachment: Record "133";
//                         // begin
//                         //     IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
//                         // end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         Caption = 'Remove Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = RemoveLine;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         // trigger OnAction()
//                         // begin
//                         //     "Incoming Document Entry No." := 0;
//                         // end;
//                     }
//                 }
//             }
//             group(Plan)
//             {
//                 Caption = 'Plan';
//                 Image = Planning;
//                 action("Order &Promising")
//                 {
//                     AccessByPermission = TableData 99000880 = R;
//                     Caption = 'Order &Promising';
//                     Image = OrderPromising;

//                     // trigger OnAction()
//                     // var
//                     //     OrderPromisingLine: Record "99000880" temporary;
//                     // begin
//                     //     OrderPromisingLine.SETRANGE("Source Type", "Document Type");
//                     //     OrderPromisingLine.SETRANGE("Source ID", "No.");
//                     //     PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
//                     // end;
//                 }
//                 action("Demand Overview")
//                 {
//                     Caption = 'Demand Overview';
//                     Image = Forecast;

//                     // trigger OnAction()
//                     // var
//                     //     DemandOverview: Page "5830";
//                     // begin
//                     //     DemandOverview.SetCalculationParameter(TRUE);
//                     //     DemandOverview.Initialize(0D, 1, "No.", '', '');
//                     //     DemandOverview.RUNMODAL;
//                     // end;
//                 }
//                 action("Pla&nning")
//                 {
//                     Caption = 'Pla&nning';
//                     Image = Planning;

//                     // trigger OnAction()
//                     // var
//                     //     SalesPlanForm: Page "99000883";
//                     // begin
//                     //     SalesPlanForm.SetSalesOrder("No.");
//                     //     SalesPlanForm.RUNMODAL;
//                     // end;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 Image = SendApprovalRequest;
//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     // trigger OnAction()
//                     // var
//                     //     ApprovalsMgmt: Codeunit "1535";
//                     //     SalesSetupRec: Record "311";
//                     //     ClientAppMgmt: Codeunit "50004";
//                     // begin
//                     //     //<Chin 20160627 1317
//                     //     SalesSetupRec.GET;
//                     //     IF SalesSetupRec."Not Standard Approval" THEN
//                     //         ClientAppMgmt.CreateSalesEntry(Rec)
//                     //     ELSE BEGIN
//                     //         IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
//                     //             ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
//                     //     END;
//                     //>
//                     // end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     // trigger OnAction()
//                     // var
//                     //     ApprovalsMgmt: Codeunit "1535";
//                     //     ClientAppMgmt: Codeunit "50004";
//                     // begin
//                     //     //<Chin   20160627 0540
//                     //     //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
//                     //     ClientAppMgmt.CancelAppRequest(Rec);
//                     //     //>
//                     // end;
//                 }
//             }
//             group("Credit Card")
//             {
//                 Caption = 'Credit Card';
//                 Image = AuthorizeCreditCard;
//                 action(Authorize)
//                 {
//                     Caption = 'Authorize';
//                     Image = AuthorizeCreditCard;

//                     // trigger OnAction()
//                     // begin
//                     //     Authorize;
//                     // end;
//                 }
//                 action("Void A&uthorize")
//                 {
//                     Caption = 'Void A&uthorize';
//                     Image = VoidCreditCard;

//                     // trigger OnAction()
//                     // begin
//                     //     Void;
//                     // end;
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("Create Inventor&y Put-away/Pick")
//                 {
//                     AccessByPermission = TableData 7342 = R;
//                     Caption = 'Create Inventor&y Put-away/Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     // trigger OnAction()
//                     // begin
//                     //     CreateInvtPutAwayPick;

//                     //     IF NOT FIND('=><') THEN
//                     //         INIT;
//                     // end;
//                 }
//                 action("Create &Whse. Shipment")
//                 {
//                     AccessByPermission = TableData 7320 = R;
//                     Caption = 'Create &Whse. Shipment';
//                     Image = NewShipment;

//                     // trigger OnAction()
//                     // var
//                     //     GetSourceDocOutbound: Codeunit "5752";
//                     // begin
//                     //     GetSourceDocOutbound.CreateFromSalesOrder(Rec);

//                     //     IF NOT FIND('=><') THEN
//                     //         INIT;
//                     // end;
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post1)
//                 {
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post (Yes/No)");
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post + Print");
//                     end;
//                 }
//                 action("Post and Email")
//                 {
//                     Caption = 'Post and Email';
//                     Ellipsis = true;
//                     Image = PostMail;

//                     // trigger OnAction()
//                     // var
//                     //     SalesPostPrint: Codeunit "82";
//                     // begin
//                     //     SalesPostPrint.PostAndEmail(Rec);
//                     // end;
//                 }
//                 action("Test Report")
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = JobQueueVisible;

//                     // trigger OnAction()
//                     // begin
//                     //     CancelBackgroundPosting;
//                     // end;
//                 }
//                 action(PreviewPosting)
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;

//                     trigger OnAction()
//                     begin
//                         ShowPreview;
//                     end;
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Image = Prepayment;
//                     action("Prepayment &Test Report")
//                     {
//                         Caption = 'Prepayment &Test Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintSalesHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         // trigger OnAction()
//                         // var
//                         //     SalesPostYNPrepmt: Codeunit "443";
//                         // begin
//                         //     IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                         //         SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
//                         // end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         // trigger OnAction()
//                         // var
//                         //     SalesPostYNPrepmt: Codeunit "443";
//                         // begin
//                         //     IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                         //         SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
//                         // end;
//                     }
//                     action(PostPrepaymentCreditMemo)
//                     {
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         // trigger OnAction()
//                         // var
//                         //     SalesPostYNPrepmt: Codeunit "443";
//                         // begin
//                         //     IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                         //         SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
//                         // end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         // trigger OnAction()
//                         // var
//                         //     SalesPostYNPrepmt: Codeunit "443";
//                         // begin
//                         //     IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                         //         SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
//                         // end;
//                     }
//                 }
//             }
//             group("&Print")
//             {
//                 Caption = '&Print';
//                 Image = Print;
//                 action("Work Order")
//                 {
//                     Caption = 'Work Order';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
//                     end;
//                 }
//                 action("Pick Instruction")
//                 {
//                     Caption = 'Pick Instruction';
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
//                     end;
//                 }
//             }
//             group("&Order Confirmation")
//             {
//                 Caption = '&Order Confirmation';
//                 Image = Email;
//                 action("Email Confirmation")
//                 {
//                     Caption = 'Email Confirmation';
//                     Ellipsis = true;
//                     Image = Email;

//                     trigger OnAction()
//                     begin
//                         DocPrint.EmailSalesHeader(Rec);
//                     end;
//                 }
//                 action("Print Confirmation")
//                 {
//                     Caption = 'Print Confirmation';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
//                     end;
//                 }
//             }
//         }
//     }

//     // trigger OnAfterGetCurrRecord()
//     // var
//     //     CRMCouplingManagement: Codeunit "5331";
//     // begin
//     //     DynamicEditable := CurrPage.EDITABLE;
//     //     CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//     //     CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
//     //     ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
//     // end;

//     trigger OnAfterGetRecord()
//     begin
//         // SetControlVisibility;
//     end;

//     // trigger OnDeleteRecord(): Boolean
//     // begin
//     //     CheckUser; //RJ
//     //     CurrPage.SAVERECORD;
//     //     EXIT(ConfirmDeletion);
//     // end;

//     trigger OnInit()
//     begin
//         // SetExtDocNoMandatoryCondition;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         // CheckCreditMaxBeforeInsert;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         // "Responsibility Center" := UserMgt.GetSalesFilter;
//         // "Order Type" := "Order Type"::Sample;  //<Chin 20160303.0953
//         // //<Chin 20160624 1849
//         // SalesRecSetup.GET;
//         // SalesRecSetup.TESTFIELD("Sales Order Entry Code");
//         // "Entry Code" := SalesRecSetup."Sample Order Entry Code";
//         //>
//     end;

//     // trigger OnOpenPage()
//     // var
//     //     CRMIntegrationManagement: Codeunit "5330";
//     // begin
//     //     IF UserMgt.GetSalesFilter <> '' THEN BEGIN
//     //         FILTERGROUP(2);
//     //         SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
//     //         FILTERGROUP(0);
//     //     END;

//     //     SETRANGE("Date Filter", 0D, WORKDATE - 1);

//     //     SetDocNoVisible;

//     //     CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
//     // end;

//     var
//         CopySalesDoc: Report "Copy Sales Document";
//         MoveNegSalesLines: Report "Move Negative Sales Lines";
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//         ReportPrint: Codeunit "Test Report-Print";
//         DocPrint: Codeunit "Document-Print";
//         ArchiveManagement: Codeunit ArchiveManagement;
//         SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
//         ChangeExchangeRate: Page "Change Exchange Rate";
//         UserMgt: Codeunit "User Management";
//         Usage: Option "Order Confirmation","Work Order","Pick Instruction";
//         [InDataSet]

//         JobQueueVisible: Boolean;
//         Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
//         Text002: Label 'The update has been interrupted to respect the warning.';
//         DynamicEditable: Boolean;
//         HasIncomingDocument: Boolean;
//         DocNoVisible: Boolean;
//         ExternalDocNoMandatory: Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         CRMIntegrationEnabled: Boolean;
//         CRMIsCoupledToRecord: Boolean;
//         ShowWorkflowStatus: Boolean;
//         SalesRecSetup: Record "Sales & Receivables Setup";

//     local procedure Post(PostingCodeunitID: Integer)
//     begin
//         // SendToPosting(PostingCodeunitID);
//         // IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
//         //     CurrPage.CLOSE;
//         // CurrPage.UPDATE(FALSE);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         // CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure SelltoCustomerNoOnAfterValidat()
//     begin
//         // IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
//         //     IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
//         //         SETRANGE("Sell-to Customer No.");
//         // CurrPage.UPDATE;
//     end;

//     local procedure SalespersonCodeOnAfterValidate()
//     begin
//         // CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure BilltoCustomerNoOnAfterValidat()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     // local procedure SetDocNoVisible()
//     // var
//     //     DocumentNoVisibility: Codeunit "1400";
//     //     DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     // begin
//     //     DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, "No.");
//     // end;

//     // local procedure SetExtDocNoMandatoryCondition()
//     // var
//     //     SalesReceivablesSetup: Record "311";
//     // begin
//     //     SalesReceivablesSetup.GET;
//     //     ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
//     // end;

//     local procedure ShowPreview()
//     var
//         SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
//     begin
//         SalesPostYesNo.Preview(Rec);
//     end;

//     // local procedure SetControlVisibility()
//     // var
//     //     ApprovalsMgmt: Codeunit "1535";
//     // begin
//     //     JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//     //     HasIncomingDocument := "Incoming Document Entry No." <> 0;
//     //     SetExtDocNoMandatoryCondition;

//     //     OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//     //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//     // end;

//     // local procedure CheckUser()
//     // var
//     //     UserSetup: Record "91";
//     // begin
//     //     UserSetup.GET(USERID);
//     //     IF NOT UserSetup."Sales Order Delete" THEN
//     //         ERROR('You do not have permission to delete Sample Sales Orders');

//     // end;
// }

