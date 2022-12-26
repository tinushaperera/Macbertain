page 50013 "Material Requisition"
{
    Caption = 'Material Requisition';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Transfer Header";
    SourceTableView = WHERE(MRN = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer-from Code';
                    Importance = Promoted;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer-to Code';
                    Importance = Promoted;
                }
                field("In-Transit Code"; rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Created User ID"; rec."Created User ID")
                {
                    ApplicationArea = All;
                }
                field("Date Time Created"; rec."Date Time Created")
                {
                    ApplicationArea = All;
                }
                field("Date Time Released"; rec."Date Time Released")
                {
                    ApplicationArea = All;
                }
            }
            part("TransferLines"; "MRN Subform")
            {
                Caption = 'MRN Subform';
                SubPageLink = "Document No." = field("No."), "Derived From Line No." = filter(0);
            }
            group("Transfer-from")
            {
                Caption = 'Transfer-from';
                Visible = false;
                field("Transfer-from Name"; rec."Transfer-from Name")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Name 2"; rec."Transfer-from Name 2")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Address"; rec."Transfer-from Address")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Address 2"; rec."Transfer-from Address 2")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Post Code"; rec."Transfer-from Post Code")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from City"; rec."Transfer-from City")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Contact"; rec."Transfer-from Contact")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        OutboundWhseHandlingTimeOnAfte;
                    end;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        ShippingAgentCodeOnAfterValida;
                    end;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShippingAgentServiceCodeOnAfte;
                    end;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShippingTimeOnAfterValidate;
                    end;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        IF rec."Shipping Advice" <> xRec."Shipping Advice" THEN
                            IF NOT CONFIRM(Text000, FALSE, rec.FIELDCAPTION("Shipping Advice")) THEN
                                ERROR('');
                    end;
                }
            }
            group("Transfer-to")
            {
                Caption = 'Transfer-to';
                Visible = false;
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ApplicationArea = all;
                }
                field("Transfer-to Name 2"; Rec."Transfer-to Name 2")
                {
                    ApplicationArea = all;
                }
                field("Transfer-to Address"; Rec."Transfer-to Address")
                {
                    ApplicationArea = all;
                }
                field("Transfer-to Address 2"; Rec."Transfer-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Transfer-to Post Code"; Rec."Transfer-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Transfer-to City"; Rec."Transfer-to City")
                {
                    ApplicationArea = all;
                }
                field("Transfer-to Contact"; Rec."Transfer-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ReceiptDateOnAfterValidate;
                    end;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        InboundWhseHandlingTimeOnAfter;
                    end;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Area"; rec."Area")
                {
                    ApplicationArea = all;
                }
                field("Entry/Exit Point"; rec."Entry/Exit Point")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
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
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Transfer Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    RunObject = Page "Inventory Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Transfer Order"),
                                  "No." = FIELD("No.");
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
                action(MRN)
                {
                    ApplicationArea = all;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TransOrders: Record "Transfer Header";
                    begin
                        TransOrders.RESET;
                        TransOrders.SETRANGE("No.", rec."No.");
                        IF TransOrders.FINDFIRST THEN;
                        REPORT.RUNMODAL(50027, TRUE, TRUE, TransOrders);
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
                    RunObject = Page "Posted Transfer Shipments";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                }
                action("Re&ceipts")
                {
                    ApplicationArea = all;
                    Caption = 'Re&ceipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Transfer Receipts";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Whse. Shi&pments")
                {
                    ApplicationArea = all;
                    Caption = 'Whse. Shi&pments';
                    Image = Shipment;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(0),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("&Whse. Receipts")
                {
                    ApplicationArea = all;
                    Caption = '&Whse. Receipts';
                    Image = Receipt;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(1),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = all;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = FILTER("Inbound Transfer" | "Outbound Transfer"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DocPrint: Codeunit "Document-Print";
                begin
                    DocPrint.PrintTransferHeader(Rec);
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Approve)
                {
                    ApplicationArea = all;
                    Caption = 'Approve';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Release Transfer Document";
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Reo&pen")
                {
                    ApplicationArea = all;
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    begin
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Create Whse. S&hipment")
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 7320 = R;
                    Caption = 'Create Whse. S&hipment';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
                    end;
                }
                action("Create &Whse. Receipt")
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 7316 = R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    ApplicationArea = all;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Get Bin Content")
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 7302 = R;
                    Caption = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;

                    trigger OnAction()
                    var
                        BinContent: Record "Bin Content";
                        GetBinContent: Report "Whse. Get Bin Content";
                    begin
                        BinContent.SETRANGE("Location Code", rec."Transfer-from Code");
                        GetBinContent.SETTABLEVIEW(BinContent);
                        GetBinContent.InitializeTransferHeader(Rec);
                        GetBinContent.RUNMODAL;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Request Approval")
                {
                    ApplicationArea = all;
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        AprMail: Codeunit "Mail Notification Management";
                    begin
                        IF rec.Status = rec.Status::Open THEN BEGIN
                            rec.VALIDATE(Status, Rec."Status New"::"Pending Approval");//PJ calll
                            //Send Mail to Approve User
                            //AprMail.SendTransferOrderAprReqMail(Rec);
                        END;
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = all;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "TransferOrder-Post (Yes/No)";
                    ShortCutKey = 'F9';
                }
                action("Post and &Print")
                {
                    ApplicationArea = all;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "TransferOrder-Post + Print";
                    ShortCutKey = 'Shift+F9';
                }
            }
        }
        area(reporting)
        {
            action("Inventory - Inbound Transfer")
            {
                ApplicationArea = all;
                Caption = 'Inventory - Inbound Transfer';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory - Inbound Transfer";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //RJ
        PageEdit := NOT rec."Completely Received";
        TransOrderApp := UserSetup."Transfer Order Approval" AND PageEdit;
        //
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        rec.TESTFIELD(Status, rec.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //RJ
        PageEdit := NOT rec."Completely Received";
        TransOrderApp := UserSetup."Transfer Order Approval" AND PageEdit;
        //
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.MRN := TRUE; //RJ
        rec."Created User ID" := USERID;
        rec."Date Time Created" := CREATEDATETIME(WORKDATE, TIME);
    end;

    trigger OnOpenPage()
    begin
        //RJ
        UserSetup.GET(USERID);
        TransOrderApp := UserSetup."Transfer Order Approval";
        PageEdit := TRUE;
        //
    end;

    var
        Text000: Label 'Do you want to change %1 in all related records in the warehouse?';
        UserSetup: Record "User Setup";
        TransOrderApp: Boolean;
        PageEdit: Boolean;

    local procedure PostingDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentServiceCodeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentCodeOnAfterValida()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingTimeOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure OutboundWhseHandlingTimeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ReceiptDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure InboundWhseHandlingTimeOnAfter()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;
}

