page 50022 "Pending Sales Order List"
{
    Caption = 'Sales Orders';
    CardPageID = "Sales Order";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Order),
                            "Order Type" = CONST(Order),
                            Status = CONST("Pending Approval"));
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Post Code"; rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Contact"; rec."Sell-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Post Code"; rec."Bill-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Contact"; rec."Bill-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Campaign No."; rec."Campaign No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Discount %"; rec."Payment Discount %")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Completely Shipped"; rec."Completely Shipped")
                {
                    ApplicationArea = all;
                }
                field("Job Queue Status"; rec."Job Queue Status")
                {
                    ApplicationArea = all;
                    Visible = JobQueueActive;
                }
            }
        }
        area(factboxes)
        {
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            part(IncomingDocAttachFactBox; 193)
            {
                ShowFilter = false;
                Visible = false;
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
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDocDim;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        rec.OpenSalesOrderStatistics;
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
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
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
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
                //     RunPageLink = "Source Type" = CONST(37),
                //                   "Source Subtype" = FIELD("Document Type"),
                //                   "Source No." = FIELD("No.");
                //     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                // }
                action("In&vt. Put-away/Pick Lines")
                {
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
            group(Release1)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Visible = false;
                action(Release2)
                {
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
                action("Send IC Sales Order Cnfmn.")
                {
                    AccessByPermission = TableData 410 = R;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit "ICInboxOutboxMgt";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                            ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Visible = false;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // begin
                    //     IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                    //         ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    // end;
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
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group(Warehouse1)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7342 = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

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
                Visible = false;
                action(Post)
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
                        rec.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
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
                        rec.SendToPosting(CODEUNIT::"Sales-Post + Print");
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
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Reservation Avail.";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            rec.FILTERGROUP(0);
        END;

        rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        JobQueueActive := SalesSetup.JobQueueActive;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    end;

    var
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;


    procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;
}

