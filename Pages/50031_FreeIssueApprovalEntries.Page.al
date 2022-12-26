page 50031 "Free Issue Approval Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = "Client Approval Entry";
    SourceTableView = WHERE("Approve Type" = CONST("Free Issue"));
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
                    ApplicationArea = all;
                }
                field("Table Code"; rec."Table Code")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Approve Type"; rec."Approve Type")
                {
                    ApplicationArea = all;
                }
                field("Approve Lower Limit"; rec."Approve Lower Limit")
                {
                    ApplicationArea = all;
                }
                field("Approve Upper Limit"; rec."Approve Upper Limit")
                {
                    ApplicationArea = all;
                }
                field("Sender ID"; rec."Sender ID")
                {
                    ApplicationArea = all;
                }
                field("Approved ID"; rec."Approved ID")
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
            }
        }
        area(factboxes)
        {
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ApproveVisible;

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

                end;
            }
        }
    }

    trigger OnInit()
    begin
        ApproveVisible := FALSE;
        RejectVisible := FALSE;
    end;

    trigger OnOpenPage()
    var
        User: Record "user";
    begin
        CLEAR(FilterStr);
        User.RESET;
        User.SETRANGE("User Name", USERID);
        IF User.FINDFIRST THEN;
        rec.FILTERGROUP(2);
        rec.SETRANGE(Status, Rec.Status::Open);
        //SETRANGE("Sender ID",USERID);
        rec.FILTERGROUP(0);
    end;

    var
        ClientAppMange: Codeunit "Client Approval Management";
        FilterStr: Text[150];
        ApproveVisible: Boolean;
        RejectVisible: Boolean;
}

