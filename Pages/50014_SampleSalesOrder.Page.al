page 50014 "Sample Sales Order"
{
    Caption = 'Sample Sales Order';
    DeleteAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            "Order Type" = FILTER(Sample));

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
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Sell-to Address"; rec."Sell-to Address")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Sell-to Address 2"; rec."Sell-to Address 2")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Sell-to Post Code"; rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Sell-to City"; rec."Sell-to City")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Create User ID"; rec."Create User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date-Time Created"; rec."Date-Time Created")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    ShowMandatory = ExternalDocNoMandatory;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    QuickEntry = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SalesPerRec: Record "Salesperson/Purchaser";
                        CustRec: Record Customer;
                        SalesPer: Page "Salesperson/Purchaser Card";
                    begin
                        IF CustRec.GET(rec."Sell-to Customer No.") THEN BEGIN
                            SalesPerRec.SETFILTER(SalesPerRec.Code, '%1|%2', CustRec."Salesperson Code", CustRec."Salesperson Code 2");
                            SalesPer.LOOKUPMODE(TRUE);
                            //SalesPer.RUNMODAL(
                            IF PAGE.RUNMODAL(50008, SalesPerRec) = ACTION::LookupOK THEN
                                rec."Salesperson Code" := SalesPerRec.Code;

                        END;
                    end;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
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
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    QuickEntry = false;
                }
            }
            group("Cash Customer Details")
            {
                Caption = 'Cash Customer Details';
                Visible = false;
                field("Temporary Receipt No."; rec."Temporary Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("NIC No."; rec."NIC No.")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
            }
            part(SalesLines; "Sample Sales Order Subform")
            {
                ApplicationArea = all;
                Editable = DynamicEditable;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
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
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Direct Debit Mandate ID"; rec."Direct Debit Mandate ID")
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
                // field("Credit Card No."; rec."Credit Card No.")
                // {
                // }
                // field(GetCreditcardNumber; rec.GetCreditcardNumber)
                // {
                //     Caption = 'Cr. Card Number (Last 4 Digits)';
                // }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
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
                field("Ship-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
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
                        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("EU 3-Party Trade"; rec."EU 3-Party Trade")
                {
                    ApplicationArea = all;
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
                field("Exit Point"; rec."Exit Point")
                {
                    ApplicationArea = all;
                }
                field("Area"; rec."Area")
                {
                    ApplicationArea = all;
                }
            }
            group(Prepayment1)
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
            }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("Document No."),
                              "Line No." = field("Line No.");
                Visible = true;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Item Warehouse FactBox"; "Item Warehouse FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
            // systempart(; Notes)
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
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        rec.OpenSalesOrderStatistics;
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
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
                action("A&pprovals")
                {
                    ApplicationArea = all;
                    Caption = 'A&pprovals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                // action("Credit Cards Transaction Lo&g Entries")
                // {
                //     Caption = 'Credit Cards Transaction Lo&g Entries';
                //     Image = CreditCardLog;
                //     RunObject = Page "DO Payment Trans. Log Entries";
                //     RunPageLink = "Document No." = FIELD("No."),
                //                   "Customer No." = FIELD("Bill-to Customer No.");
                // }
                action("Assembly Orders")
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 90 = R;
                    Caption = 'Assembly Orders';
                    Image = AssemblyOrder;

                    trigger OnAction()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrder)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Order';
                    Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
                    Image = CoupledOrder;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM sales order.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(rec.RECORDID);
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = all;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = all;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = all;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                // action("Whse. Shipment Lines")
                // {
                //     Caption = 'Whse. Shipment Lines';
                //     Image = ShipmentLines;
                //     RunObject = Page "Whse. Shipment Lines";
                //     RunPageLink = "Source Type" = CONST(37),
                //                   "Source Subtype" = FIELD("Document Type"),
                //                   "Source No." = FIELD("No.");
                //     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                // }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Image = Prepayment;
                action(PagePostedSalesPrepaymentInvoices)
                {
                    ApplicationArea = all;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = all;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
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
                    ApplicationArea = all;
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
                    ApplicationArea = all;
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
                    ApplicationArea = all;
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
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

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
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = all;
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = all;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action(MoveNegativeLines)
                {
                    ApplicationArea = all;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    AccessByPermission = TableData 410 = R;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                            ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
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
                    //         rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(rec."Incoming Document Entry No."));
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
                            IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
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
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;
                action("Order &Promising")
                {
                    AccessByPermission = TableData 99000880 = R;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    Caption = 'Demand Overview';
                    Image = Forecast;

                    trigger OnAction()
                    var
                        DemandOverview: Page "Demand Overview";
                    begin
                        DemandOverview.SetCalculationParameter(TRUE);
                        DemandOverview.Initialize(0D, 1, rec."No.", '', '');
                        DemandOverview.RUNMODAL;
                    end;
                }
                action("Pla&nning")
                {
                    Caption = 'Pla&nning';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(rec."No.");
                        SalesPlanForm.RUNMODAL;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
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
                        SalesSetupRec: Record "Sales & Receivables Setup";
                        ClientAppMgmt: Codeunit "Client Approval Management";
                    begin
                        //<Chin 20160627 1317
                        SalesSetupRec.GET;
                        IF SalesSetupRec."Not Standard Approval" THEN
                            ClientAppMgmt.CreateSalesEntry(Rec)
                        ELSE BEGIN
                            if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                                ApprovalsMgmt.OnSendSalesDocForApproval(Rec); //TL 
                        END;
                        //>
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
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ClientAppMgmt: Codeunit "Client Approval Management";
                    begin
                        //<Chin   20160627 0540
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        ClientAppMgmt.CancelAppRequest(Rec);
                        //>
                    end;
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
            group(Warehouse1)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7342 = R;
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
                action("Create &Whse. Shipment")
                {
                    AccessByPermission = TableData 7320 = R;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT rec.FIND('=><') THEN
                            rec.INIT;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
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
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    Caption = 'Post and Email';
                    Ellipsis = true;
                    Image = PostMail;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit "Sales-Post + Print";
                    begin
                        SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
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
                action(PreviewPosting)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment &Test Report")
                    {
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Work Order")
                {
                    ApplicationArea = all;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    Caption = 'Pick Instruction';
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
            }
            group("&Order Confirmation")
            {
                Caption = '&Order Confirmation';
                Image = Email;
                action("Email Confirmation")
                {
                    Caption = 'Email Confirmation';
                    Ellipsis = true;
                    Image = Email;

                    trigger OnAction()
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                action("Print Confirmation")
                {
                    Caption = 'Print Confirmation';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        DynamicEditable := CurrPage.EDITABLE;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(rec.RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CheckUser; //RJ
        CurrPage.SAVERECORD;
        EXIT(rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Responsibility Center" := UserMgt.GetSalesFilter;
        rec."Order Type" := rec."Order Type"::Sample;  //<Chin 20160303.0953
        //<Chin 20160624 1849
        SalesRecSetup.GET;
        SalesRecSetup.TESTFIELD("Sales Order Entry Code");
        rec."Entry Code" := SalesRecSetup."Sample Order Entry Code";
        //>
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            rec.FILTERGROUP(0);
        END;

        rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        SetDocNoVisible;

        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    end;

    var
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        ChangeExchangeRate: Page "Change Exchange Rate";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        [InDataSet]

        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        DynamicEditable: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        ShowWorkflowStatus: Boolean;
        SalesRecSetup: Record "Sales & Receivables Setup";

    local procedure Post(PostingCodeunitID: Integer)
    begin
        rec.SendToPosting(PostingCodeunitID);
        IF rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
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
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
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

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, rec."No.");
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

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;

    local procedure CheckUser()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."Sales Order Delete" THEN
            ERROR('You do not have permission to delete Sample Sales Orders');

    end;
}

