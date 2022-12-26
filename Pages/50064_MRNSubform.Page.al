page 50064 "MRN Subform"
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
            repeater(Gen)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Received"; rec."Quantity Received")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("Receipt Date"; rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                        ApplicationArea = All;
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByPeriod);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromTransLine(Rec, ItemAvailFormsMgt.ByVariant);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
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
                        ApplicationArea = All;
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
                    ApplicationArea = All;
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
                        ApplicationArea = All;
                        Caption = 'Shipment';
                        Image = Shipment;

                        trigger OnAction()
                        begin
                            rec.OpenItemTrackingLines("Transfer Direction"::Outbound);
                        end;
                    }
                    action(Receipt)
                    {
                        ApplicationArea = All;
                        Caption = 'Receipt';
                        Image = Receipt;

                        trigger OnAction()
                        begin
                            rec.OpenItemTrackingLines("Transfer Direction"::Inbound);
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
