page 50041 "Pending Sample Order List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Sample Sales Orders';
    CardPageID = "Sample Sales Order";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Order),
                            "Order Type" = CONST(Sample),
                            Status = CONST("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Campaign No."; rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Discount %"; rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Completely Shipped"; rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Status"; rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Visible = JobQueueActive;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(36),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
#if not CLEAN21
            part("Power BI Report FactBox"; "Power BI Report FactBox")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                ObsoleteReason = 'Use the part PowerBIEmbeddedReportPart instead';
                ObsoleteState = Pending;
                ObsoleteTag = '21.0';
            }
#endif
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
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
                    ApplicationArea = Dimensions;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDocDim();
                    end;
                }
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
                        rec.OpenSalesOrderStatistics();
                    end;
                }
                action("A&pprovals")
                {

                    ApplicationArea = Suite;
                    Caption = 'A&pprovals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsSales(Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
            }
            group(Documents)
            {

                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
            }
            group(WarehouseGrp)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                // action("Whse. Shipment Lines")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Whse. Shipment Lines';
                //     Image = ShipmentLines;
                //     RunObject = Page "Whse. Shipment Lines";
                //     RunPageLink = "Source Type" = CONST(37),
                //                   "Source Subtype" = FIELD("Document Type"),
                //                   "Source No." = FIELD("No.");
                //     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                // }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrderListInNAV)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order List';
                    Enabled = CRMIntegrationEnabled;
                    Image = "Order";
                    ToolTip = 'Open the Dynamics CRM Sales Order List page in NAV';
                    Visible = CRMIntegrationEnabled;

                    trigger OnAction()
                    var
                        CRMSalesorder: Record "CRM Salesorder";
                    begin
                        PAGE.RUN(PAGE::"CRM Sales Order List", CRMSalesorder);
                    end;
                }
            }
        }
        area(processing)
        {
            group(ReleaseGrp)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = All;
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
                action(Reopen)
                {
                    ApplicationArea = All;
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
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Pla&nning';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesOrderPlanningForm: Page "Sales Order Planning";
                    begin
                        SalesOrderPlanningForm.SetSalesOrder(rec."No.");
                        SalesOrderPlanningForm.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Order Promising Line" = R;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            ICInOutboxMgt.SendSalesDoc(Rec, false);
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
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(rec.RecordId);
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
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    begin
                        rec.CreateInvtPutAwayPick();

                        if not rec.Find('=><') then
                            rec.Init();
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
                action(Post)
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
                    var
                        SalesHeader: Record "Sales Header";
                        SalesBatchPostMgt: Codeunit "Sales Batch Post Mgt.";
                        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
                    begin
                        CurrPage.SetSelectionFilter(SalesHeader);
                        if SalesHeader.Count > 1 then begin
                            BatchProcessingMgt.SetParametersForPageID(Page::"Sales Order List");

                            SalesBatchPostMgt.SetBatchProcessor(BatchProcessingMgt);
                            SalesBatchPostMgt.RunWithUI(SalesHeader, rec.Count, ReadyToPostQst);
                        end else
                            PostDocument(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                // action("Post and &Print")
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
                //         SendToPosting(CODEUNIT::"Sales-Post + Print");
                //     end;
                // }
                // action("Post and Email")
                // {
                //     Caption = 'Post and Email';
                //     Ellipsis = true;
                //     Image = PostMail;

                //     trigger OnAction()
                //     var
                //         SalesPostPrint: Codeunit "82";
                //     begin
                //         SalesPostPrint.PostAndEmail(Rec);
                //     end;
                // }
                action("Test Report")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        rec.CancelBackgroundPosting;
                    end;
                }
                action("Preview Posting")
                {
                    ApplicationArea = All;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;

                    trigger OnAction()
                    begin
                        ShowPreview
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Work Order")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Print Confirmation';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                ApplicationArea = All;
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 209;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        SetControlVisibility();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

        if CRMIntegrationEnabled then
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(rec.RecordId);

#if not CLEAN21
        // Contextual Power BI FactBox: send data to filter the report in the FactBox
        //CurrPage."Power BI Report FactBox".PAGE.SetCurrentListSelection(rec."No.", false, PowerBIVisible);
#endif
        CurrPage.PowerBIEmbeddedReportPart.PAGE.SetCurrentListSelection(rec."No.");
    end;

    trigger OnAfterGetRecord()
    begin
        StatusStyleTxt := rec.GetStatusStyleText();
    end;

    trigger OnInit()
    begin
#if not CLEAN21
        PowerBIVisible := false;
        //CurrPage."Power BI Report FactBox".PAGE.InitFactBox(CurrPage.ObjectId(false), CurrPage.Caption, PowerBIVisible);
#endif
        CurrPage.PowerBIEmbeddedReportPart.PAGE.InitPageRatio(PowerBIServiceMgt.GetFactboxRatio());
        CurrPage.PowerBIEmbeddedReportPart.PAGE.SetPageContext(CurrPage.ObjectId(false));
    end;

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CRMConnectionSetup: Record "CRM Connection Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        rec.SetRange("Date Filter", 0D, WorkDate());

        JobQueueActive := SalesSetup.JobQueueActive();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        BidirectionalSalesOrderIntEnabled := CRMConnectionSetup.IsBidirectionalSalesOrderIntEnabled();
        IsOfficeAddin := OfficeMgt.IsAvailable();

        rec.CopySellToCustomerFilter();
        if OnlyShowHeadersWithVat then
            SetFilterOnPositiveVatPostingGroups();
    end;

    var
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        PowerBIServiceMgt: Codeunit "Power BI Service Mgt.";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        [InDataSet]
        JobQueueActive: Boolean;
        OnlyShowHeadersWithVat: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        BidirectionalSalesOrderIntEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
#if not CLEAN21
        PowerBIVisible: Boolean;
#endif
        [InDataSet]
        StatusStyleTxt: Text;
        ReadyToPostQst: Label 'The number of orders that will be posted is %1. \Do you want to continue?', Comment = '%1 - selected count';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;

    procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        rec.SendToPosting(PostingCodeunitID);

        CurrPage.Update(false);
    end;

    procedure SkipShowingLinesWithoutVAT()
    begin
        OnlyShowHeadersWithVat := true;
    end;

    local procedure PrintForUsage(UsageParam: Option)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePrintForUsage(Rec, UsageParam, IsHandled);
        if IsHandled then
            exit;

        DocPrint.PrintSalesOrder(Rec, UsageParam);
    end;

    local procedure SetFilterOnPositiveVatPostingGroups()
    var
        VatPostingSetup: Record "VAT Posting Setup";
        VatBusPostingCodeFilter: Text;
    begin
        VatPostingSetup.SetFilter("VAT %", '>0');
        VatPostingSetup.SetLoadFields("VAT Bus. Posting Group");
        if not VatPostingSetup.FindSet() then
            exit;
        repeat
            if StrPos(VatBusPostingCodeFilter, VatPostingSetup."VAT Bus. Posting Group") < 1 then begin
                if VatBusPostingCodeFilter <> '' then
                    VatBusPostingCodeFilter += '|';
                VatBusPostingCodeFilter += VatPostingSetup."VAT Bus. Posting Group";
            end;
        until VatPostingSetup.Next() = 0;
        Rec.SetFilter("VAT Bus. Posting Group", VatBusPostingCodeFilter);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforePrintForUsage(var SalesHeader: Record "Sales Header"; UsageParam: Option; var IsHandled: Boolean)
    begin
    end;
}

