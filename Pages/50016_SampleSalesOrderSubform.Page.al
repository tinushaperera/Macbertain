page 50016 "Sample Sales Order Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                        NoOnAfterValidate;
                        TypeChosen := rec.HasTypeToFillMandatoryFields();

                        SetLocationCodeMandatory;

                        IF xRec."No." <> '' THEN
                            RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = TypeChosen;

                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        IF xRec."No." <> '' THEN
                            RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VariantCodeOnAfterValidate;
                    end;
                }
                field("Purchasing Code"; rec."Purchasing Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Free Issue"; rec."Free Issue")
                {
                    ApplicationArea = all;
                    Editable = FreeIssueEdit;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                    ShowMandatory = LocationCodeMandatory;

                    trigger OnValidate()
                    begin
                        LocationCodeOnAfterValidate;
                    end;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    ShowMandatory = TypeChosen;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                        RedistributeTotalsOnAfterValidate;

                        //<Chin 201602111530
                        rec.CreateNewLine;
                        CurrPage.UPDATE;
                        //>
                    end;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    Editable = false;
                    ShowMandatory = TypeChosen;

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        IF rec."Qty. to Asm. to Order (Base)" <> 0 THEN BEGIN
                            CurrPage.SAVERECORD;
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    QuickEntry = false;
                }
                field("Qty. to Invoice"; rec."Qty. to Invoice")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Appl.-from Item Entry"; rec."Appl.-from Item Entry")
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
            group(Grp1)
            {
                group(Grp2)
                {
                    Visible = false;
                    field("Invoice Discount Amount"; TotalSalesLine."Inv. Discount Amount")
                    {
                        ApplicationArea = all;
                        AutoFormatExpression = TotalSalesHeader."Currency Code";
                        AutoFormatType = 1;
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;

                        trigger OnValidate()
                        var
                            SalesHeader: Record "Sales Header";
                        begin
                            SalesHeader.GET(rec."Document Type", rec."Document No.");
                            SalesCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalSalesLine."Inv. Discount Amount", SalesHeader);
                            CurrPage.UPDATE(FALSE);
                        end;
                    }
                    field("Invoice Disc. Pct."; SalesCalcDiscByType.GetCustInvoiceDiscountPct(Rec))
                    {
                        ApplicationArea = all;
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = true;
                    }
                }
                group(General1)
                {
                    Visible = false;
                    field("Total Amount Excl. VAT"; TotalSalesLine.Amount)
                    {
                        ApplicationArea = all;
                        AutoFormatExpression = TotalSalesHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = all;
                        AutoFormatExpression = TotalSalesHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field("Total Amount Incl. VAT"; TotalSalesLine."Amount Including VAT")
                    {
                        ApplicationArea = all;
                        AutoFormatExpression = TotalSalesHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                    }
                    field(RefreshTotals; RefreshMessageText)
                    {
                        ApplicationArea = all;
                        DrillDown = true;
                        Editable = false;
                        Enabled = RefreshMessageEnabled;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
                            CurrPage.UPDATE(FALSE);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("<Action3>")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData 27 = R;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction()
                    begin
                        rec.ShowReservationEntries(TRUE);
                    end;
                }
                action(ItemTrackingLines)
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines;
                    end;
                }
                action("Select Item Substitution")
                {
                    AccessByPermission = TableData 5715 = R;
                    Caption = 'Select Item Substitution';
                    Image = SelectItemSubstitution;

                    trigger OnAction()
                    begin
                        rec.ShowItemSub;
                    end;
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
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        rec.ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    AccessByPermission = TableData 5800 = R;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;

                    trigger OnAction()
                    begin
                        ItemChargeAssgnt;
                    end;
                }
                action(OrderPromising)
                {
                    AccessByPermission = TableData 99000880 = R;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction()
                    begin
                        OrderPromisingLine;
                    end;
                }
                group("Assemble to Order")
                {
                    Caption = 'Assemble to Order';
                    Image = AssemblyBOM;
                    action(AssembleToOrderLines)
                    {
                        AccessByPermission = TableData 90 = R;
                        Caption = 'Assemble-to-Order Lines';

                        trigger OnAction()
                        begin
                            rec.ShowAsmToOrderLines;
                        end;
                    }
                    action("Roll Up &Price")
                    {
                        AccessByPermission = TableData 90 = R;
                        Caption = 'Roll Up &Price';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            rec.RollupAsmPrice;
                        end;
                    }
                    action("Roll Up &Cost")
                    {
                        AccessByPermission = TableData 90 = R;
                        Caption = 'Roll Up &Cost';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            rec.RollUpAsmCost;
                        end;
                    }
                }
                action(DeferralSchedule)
                {
                    Caption = 'Deferral Schedule';
                    Enabled = rec."Deferral Code" <> '';
                    Image = PaymentPeriod;

                    trigger OnAction()
                    begin
                        SalesHeader.GET(rec."Document Type", rec."Document No.");
                        rec.ShowDeferrals(SalesHeader."Posting Date", SalesHeader."Currency Code");
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                // action(GetPrice)
                // {
                //     AccessByPermission = TableData 7002 = R;
                //     Caption = 'Get Price';
                //     Ellipsis = true;
                //     Image = Price;

                //     trigger OnAction()
                //     begin
                //         ShowPrices;
                //     end;
                // }
                // action("Get Li&ne Discount")
                // {
                //     AccessByPermission = TableData 7004 = R;
                //     Caption = 'Get Li&ne Discount';
                //     Ellipsis = true;
                //     Image = LineDiscount;

                //     trigger OnAction()
                //     begin
                //         ShowLineDisc
                //     end;
                // }
                action(ExplodeBOM_Functions)
                {
                    AccessByPermission = TableData 90 = R;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert Ext. Texts")
                {
                    AccessByPermission = TableData 279 = R;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(Reserve)
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;

                    trigger OnAction()
                    begin
                        rec.FIND;
                        rec.ShowReservation;
                    end;
                }
                action(OrderTracking)
                {
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        ShowTracking;
                    end;
                }
                action("Nonstoc&k Items")
                {
                    AccessByPermission = TableData 5718 = R;
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;

                    trigger OnAction()
                    begin
                        ShowNonstockItems;
                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Purchase &Order")
                    {
                        AccessByPermission = TableData 120 = R;
                        Caption = 'Purchase &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            OpenPurchOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(OpenSpecialPurchaseOrder)
                    {
                        AccessByPermission = TableData 120 = R;
                        Caption = 'Purchase &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            OpenSpecialPurchOrderForm;
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF SalesHeader.GET(rec."Document Type", rec."Document No.") THEN;

        DocumentTotals.SalesUpdateTotalsControls(Rec, TotalSalesHeader, TotalSalesLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, CurrPage.EDITABLE, VATAmount);


        TypeChosen := rec.HasTypeToFillMandatoryFields();
        SetLocationCodeMandatory;
    end;

    trigger OnAfterGetRecord()
    begin
        Ed_Fields;//Chin 201602111528
        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        IF (rec.Quantity <> 0) AND rec.ItemExists(rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReserveSalesLine.DeleteLine(Rec);
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.InitType;
        CLEAR(ShortcutDimCode);
        Ed_Fields;//Chin 201602111539
        rec."Order Type" := rec."Order Type"::Sample;
    end;

    var
        TotalSalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        //SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';
        [InDataSet]
        ItemPanelVisible: Boolean;
        TypeChosen: Boolean;
        LocationCodeMandatory: Boolean;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        DisCountEdit: Boolean;
        QtyEdit: Boolean;
        FreeIssueEdit: Boolean;
        SaleRecSetup: Record "Sales & Receivables Setup";
        User: Record "User Setup";


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        IF rec."Prepmt. Amt. Inv." <> 0 THEN
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;


    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        rec.TESTFIELD("Purchase Order No.");
        PurchHeader.SETRANGE("No.", rec."Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;


    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchOrder: Page "Purchase Order";
    begin
        rec.TESTFIELD("Special Order Purchase No.");
        PurchHeader.SETRANGE("No.", rec."Special Order Purchase No.");
        IF NOT PurchHeader.ISEMPTY THEN BEGIN
            PurchOrder.SETTABLEVIEW(PurchHeader);
            PurchOrder.EDITABLE := FALSE;
            PurchOrder.RUN;
        END ELSE BEGIN
            PurchRcptHeader.SETRANGE("Order No.", rec."Special Order Purchase No.");
            IF PurchRcptHeader.COUNT = 1 THEN
                PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
            ELSE
                PAGE.RUN(PAGE::"Posted Purchase Receipts", PurchRcptHeader);
        END;
    end;


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            COMMIT;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure ShowNonstockItems()
    begin
        rec.ShowNonstock;
    end;


    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetSalesLine(Rec);
        TrackingForm.RUNMODAL;
    end;


    procedure ItemChargeAssgnt()
    begin
        rec.ShowItemChargeAssgnt;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices()
    begin
        SalesHeader.GET(rec."Document Type", rec."Document No.");
        // CLEAR(SalesPriceCalcMgt);
        //SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        SalesHeader.GET(rec."Document Type", rec."Document No.");
        //CLEAR(SalesPriceCalcMgt);
        //SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure OrderPromisingLine()
    var
        OrderPromisingLine: Record "Order Promising Line" temporary;
        OrderPromisingLines: Page "Order Promising Lines";
    begin
        OrderPromisingLine.SETRANGE("Source Type", rec."Document Type");
        OrderPromisingLine.SETRANGE("Source ID", rec."Document No.");
        OrderPromisingLine.SETRANGE("Source Line No.", rec."Line No.");

        // OrderPromisingLines.SetSourceType(OrderPromisingLine."Source Type"::Sales);
        OrderPromisingLines.SETTABLEVIEW(OrderPromisingLine);
        OrderPromisingLines.RUNMODAL;
    end;

    local procedure TypeOnAfterValidate()
    begin
        ItemPanelVisible := rec.Type = rec.Type::Item;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (rec.Type = rec.Type::"Charge (Item)") AND (rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;

        SaveAndAutoAsmToOrder;

        IF rec.Reserve = rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            IF (rec."Outstanding Qty. (Base)" <> 0) AND (rec."No." <> xRec."No.") THEN BEGIN
                rec.AutoReserve;
                CurrPage.UPDATE(FALSE);
            END;
        END;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    local procedure VariantCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;

        IF (rec.Reserve = rec.Reserve::Always) AND
           (rec."Outstanding Qty. (Base)" <> 0) AND
           (rec."Location Code" <> xRec."Location Code")
        THEN BEGIN
            CurrPage.SAVERECORD;
            rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        IF (rec.Reserve = rec.Reserve::Always) AND (rec."Outstanding Qty. (Base)" <> 0) THEN BEGIN
            CurrPage.SAVERECORD;
            rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure QuantityOnAfterValidate()
    var
        UpdateIsDone: Boolean;
    begin
        IF rec.Type = rec.Type::Item THEN
            CASE rec.Reserve OF
                rec.Reserve::Always:
                    BEGIN
                        CurrPage.SAVERECORD;
                        rec.AutoReserve;
                        CurrPage.UPDATE(FALSE);
                        UpdateIsDone := TRUE;
                    END;
                rec.Reserve::Optional:
                    IF (rec.Quantity < xRec.Quantity) AND (xRec.Quantity > 0) THEN BEGIN
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(FALSE);
                        UpdateIsDone := TRUE;
                    END;
            END;

        IF (rec.Type = rec.Type::Item) AND
           (rec.Quantity <> xRec.Quantity) AND
           NOT UpdateIsDone
        THEN
            CurrPage.UPDATE(TRUE);
    end;

    local procedure QtyToAsmToOrderOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        IF rec.Reserve = rec.Reserve::Always THEN
            rec.AutoReserve;
        CurrPage.UPDATE(TRUE);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF rec.Reserve = rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        IF (rec.Reserve = rec.Reserve::Always) AND
           (rec."Outstanding Qty. (Base)" <> 0) AND
           (rec."Shipment Date" <> xRec."Shipment Date")
        THEN BEGIN
            CurrPage.SAVERECORD;
            rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        IF (rec.Type = rec.Type::Item) AND rec.IsAsmToOrderRequired THEN BEGIN
            CurrPage.SAVERECORD;
            rec.AutoAsmToOrder;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure SetLocationCodeMandatory()
    var
        InventorySetup: Record "Inventory Setup";
    begin
        InventorySetup.GET;
        LocationCodeMandatory := InventorySetup."Location Mandatory" AND (rec.Type = rec.Type::Item);
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD;

        SalesHeader.GET(rec."Document Type", rec."Document No.");
        IF DocumentTotals.SalesCheckNumberOfLinesLimit(SalesHeader) THEN
            DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
        CurrPage.UPDATE;
    end;


    procedure Ed_Fields()
    begin
        IF rec."Purchasing Code" = SaleRecSetup."Free Issue Code" THEN
            FreeIssueEdit := FALSE
        ELSE
            FreeIssueEdit := TRUE;

        IF NOT User."Sales Order Editable" THEN BEGIN
            DisCountEdit := FALSE;
            IF rec."Purchasing Code" = SaleRecSetup."Free Issue Code" THEN
                QtyEdit := FALSE
            ELSE
                QtyEdit := TRUE;
        END
        ELSE BEGIN
            DisCountEdit := TRUE;
            QtyEdit := TRUE;
        END
    end;
}

