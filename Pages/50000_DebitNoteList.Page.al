page 50000 "Debit Note List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Debit Notes';
    CardPageID = "Debit Note";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Release,Posting,Invoice,Request Approval';
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Invoice),
                            "Debit Note" = CONST(true));

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
                field("Campaign No."; rec."Campaign No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Visible = false;
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
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job Queue Status"; rec."Job Queue Status")
                {
                    ApplicationArea = all;
                    Visible = false/*JobQueueActive*/;
                }
            }
        }
        area(factboxes)
        {
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
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
                    PromotedCategory = Category6;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDocDim;
                    end;
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
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    ApplicationArea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    ApplicationArea = all;
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
                    ApplicationArea = all;
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
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    ApplicationArea = all;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = all;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        rec.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        rec.SendToPosting(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    ApplicationArea = all;
                    Caption = 'Post and Email';
                    Image = PostMail;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;

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
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Send';
                    Ellipsis = true;
                    Image = PostSendTo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.SendToPosting(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = all;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                    Visible = JobQueueActive;

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

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        rec.SetSecurityFilterOnRespCenter;
        JobQueueActive := SalesSetup.JobQueueActive;
    end;

    var
        ReportPrint: Codeunit "Test Report-Print";
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;


    procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;
}

