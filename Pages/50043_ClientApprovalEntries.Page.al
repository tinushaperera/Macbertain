page 50043 "Client Approval Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = "Client Approval Entry";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table No."; rec."Table No.")
                {
                    ApplicationArea = All;
                }
                field("Table Code"; rec."Table Code")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Approve Type"; rec."Approve Type")
                {
                    ApplicationArea = All;
                }
                field("Approve Lower Limit"; rec."Approve Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Approve Upper Limit"; rec."Approve Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Approved ID"; rec."Approved ID")
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
            }
        }
        area(factboxes)
        {
            part("Customer Detail FactBox"; "Customer Detail FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Table No." = field("Table No."), "Table Code" = field("Table Code"), Type = field(Type), "No." = field("No."), "Line No." = field("Line No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approve)
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ApproveVisible;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CleintApprovalEntry: Record "Client Approval Entry";
                begin
                    /*CurrPage.SETSELECTIONFILTER(CleintApprovalEntry);
                    IF CleintApprovalEntry.FIND('-') THEN
                      REPEAT
                        //CleintApprovalEntry."Approved ID" := USERID;
                        ClientAppMange.ApproveEntry(CleintApprovalEntry);
                      UNTIL CleintApprovalEntry.NEXT = 0;
                    */

                    ClientAppMange.ApproveEntry(Rec);

                end;
            }
            action(Document)
            {
                ApplicationArea = All;
                Caption = 'Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.ShowDocument;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RejectVisible;

                trigger OnAction()
                var
                    CleintApprovalEntry: Record "Client Approval Entry";
                begin
                    /*CurrPage.SETSELECTIONFILTER(CleintApprovalEntry);
                    IF CleintApprovalEntry.FIND('-') THEN
                      REPEAT
                        CleintApprovalEntry."Approved ID" := USERID;
                        ClientAppMange.RejectEntry(CleintApprovalEntry);
                      UNTIL CleintApprovalEntry.NEXT = 0;
                    */

                    ClientAppMange.RejectApproveEntry(Rec);

                end;
            }
            action("Order Approval History")
            {
                ApplicationArea = All;
                Caption = 'Order Approval History';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50056;
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }

    trigger OnInit()
    begin
        ApproveVisible := TRUE;
        RejectVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        User: Record User;
    begin
        CLEAR(FilterStr);
        User.RESET;
        User.SETRANGE("User Name", USERID);
        IF User.FINDFIRST THEN;
        rec.FILTERGROUP(2);
        rec.SETRANGE(Status, rec.Status::Open);
        rec.SETRANGE("Approved ID", USERID);
        rec.FILTERGROUP(0);
    end;

    var
        ClientAppMange: Codeunit "Client Approval Management";
        FilterStr: Text[150];
        ApproveVisible: Boolean;
        RejectVisible: Boolean;
}

