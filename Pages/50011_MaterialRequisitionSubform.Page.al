page 50011 "Material Requisition Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Transfer Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Bin Code"; Rec."Transfer-from Bin Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Transfer-To Bin Code"; Rec."Transfer-To Bin Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Reserved Quantity Inbnd."; Rec."Reserved Quantity Inbnd.")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Reserved Quantity Shipped"; Rec."Reserved Quantity Shipped")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Reserved Quantity Outbnd."; Rec."Reserved Quantity Outbnd.")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnDrillDown()
                    var
                        TransShptLine: Record "Transfer Shipment Line";
                    begin
                        rec.TESTFIELD("Document No.");
                        rec.TESTFIELD("Item No.");
                        TransShptLine.SETCURRENTKEY("Transfer Order No.", "Item No.", "Shipment Date");
                        TransShptLine.SETRANGE("Transfer Order No.", rec."Document No.");
                        TransShptLine.SETRANGE("Item No.", rec."Item No.");
                        PAGE.RUNMODAL(0, TransShptLine);
                    end;
                }
                field("Qty. to Receive"; rec."Qty. to Receive")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Quantity Received"; rec."Quantity Received")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnDrillDown()
                    var
                        TransRcptLine: Record "Transfer Receipt Line";
                    begin
                        rec.TESTFIELD("Document No.");
                        rec.TESTFIELD("Item No.");
                        TransRcptLine.SETCURRENTKEY("Transfer Order No.", "Item No.", "Receipt Date");
                        TransRcptLine.SETRANGE("Transfer Order No.", rec."Document No.");
                        TransRcptLine.SETRANGE("Item No.", rec."Item No.");
                        PAGE.RUNMODAL(0, TransRcptLine);
                    end;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Receipt Date"; rec."Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
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
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    //ApplicationArea = location;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Reserve)
                {
                    Caption = '&Reserve';
                    Image = Reserve;

                    trigger OnAction()
                    begin
                        rec.FIND;
                        rec.ShowReservation;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByPeriod);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByVariant);
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByLocation);
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDimensions;
                    end;
                }
                group("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = AllLines;
                    action(Shipment)
                    {
                        Caption = 'Shipment';
                        Image = Shipment;

                        trigger OnAction()
                        begin
                            rec.OpenItemTrackingLines(0);
                        end;
                    }
                    action(Receipt)
                    {
                        Caption = 'Receipt';
                        Image = Receipt;

                        trigger OnAction()
                        begin
                            rec.OpenItemTrackingLines(1);
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveTransferLine: Codeunit "Transfer Line-Reserve";
    begin
        COMMIT;
        IF NOT ReserveTransferLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveTransferLine.DeleteLine(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ShortcutDimCode: array[8] of Code[20];


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;
}

