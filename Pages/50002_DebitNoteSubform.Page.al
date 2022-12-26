page 50002 "Debit Note Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));

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
                        // TypeOnAfterValidate;
                        // NoOnAfterValidate;
                        // TypeChosen := HasTypeToFillMandatotyFields;

                        // IF xRec."No." <> '' THEN
                        //     RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    //ShowMandatory = TypeChosen;

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
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    //ShowMandatory = TypeChosen;

                    trigger OnValidate()
                    begin
                        // QuantityOnAfterValidate;
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        // UnitofMeasureCodeOnAfterValida;
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field(PriceExists; rec.PriceExists)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    Visible = false;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    //ShowMandatory = TypeChosen;

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                // field(LineDiscExists; LineDiscExists)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Sales Line Disc. Exists';
                //     Editable = false;
                //     Visible = false;
                // }
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        //  RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //  RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Inv. Discount Amount"; rec."Inv. Discount Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Qty. to Assign"; rec."Qty. to Assign")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        // ShowItemChargeAssgnt;
                        // UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; rec."Qty. Assigned")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        // ShowItemChargeAssgnt;
                        // UpdateForm(FALSE);
                    end;
                }
                field("Tax Category"; rec."Tax Category")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Tax Group Code"; rec."Tax Group Code")
                {
                    ApplicationArea = all;
                }
                field("Tax Liable"; rec."Tax Liable")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Work Type Code"; rec."Work Type Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Blanket Order Line No."; rec."Blanket Order Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("FA Posting Date"; rec."FA Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Depreciation Book Code"; rec."Depreciation Book Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Use Duplication List"; rec."Use Duplication List")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = all;
                    Visible = false;
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
                field("Deferral Code"; rec."Deferral Code")
                {
                    ApplicationArea = all;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") and (Rec.Type <> Rec.Type::" ");
                    // Enabled = (Type <> Type::"Fixed Asset") AND (Type <> Type::" ");
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    //ApplicationArea = all;
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
                    //ApplicationArea = all;
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
                    //ApplicationArea = all;
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
                    //ApplicationArea = all;
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
                    //ApplicationArea = all;
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
                    //ApplicationArea = all;
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
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    //ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    //ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
            }
            group(Grp1)
            {
                group(Gep2)
                {
                    field("Invoice Discount Amount"; TotalSalesLine."Inv. Discount Amount")
                    {
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
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = true;
                    }
                }
                group(Group1)
                {
                    field("Total Amount Excl. VAT"; TotalSalesLine.Amount)
                    {
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
                        AutoFormatExpression = TotalSalesHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                    }
                    field(RefreshTotals; RefreshMessageText)
                    {
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get &Price")
                {
                    // AccessByPermission = TableData "Sales Price" = R;
                    Caption = 'Get &Price';
                    Ellipsis = true;
                    Image = Price;

                    trigger OnAction()
                    begin
                        ShowPrices
                    end;
                }
                action("Get Li&ne Discount")
                {
                    // AccessByPermission = TableData "Sales Line Discount" = R;
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Image = LineDiscount;

                    trigger OnAction()
                    begin
                        ShowLineDisc
                    end;
                }
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData 90 = R;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    AccessByPermission = TableData 279 = R;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(GetShipmentLines)
                {
                    AccessByPermission = TableData 110 = R;
                    Caption = 'Get &Shipment Lines';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        GetShipment;
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
                        rec.ShowItemChargeAssgnt;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines;
                    end;
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
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        IF SalesHeader.GET(rec."Document Type", rec."Document No.") THEN;

        DocumentTotals.SalesUpdateTotalsControls(Rec, TotalSalesHeader, TotalSalesLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, CurrPage.EDITABLE, VATAmount);

        TypeChosen := rec.HasTypeToFillMandatoryFields();
    end;

    trigger OnAfterGetRecord()
    begin
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
    end;

    var
        TotalSalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        //SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to run this function while in View mode.';
        [InDataSet]
        ItemPanelVisible: Boolean;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        TypeChosen: Boolean;


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
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;


    procedure GetShipment()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Get Shipment", Rec);
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


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices()
    begin
        // SalesHeader.GET(rec."Document Type", rec."Document No.");
        // CLEAR(SalesPriceCalcMgt);
        // SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        // SalesHeader.GET(rec."Document Type", rec."Document No.");
        // CLEAR(SalesPriceCalcMgt);
        // SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;


    procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
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
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    local procedure QuantityOnAfterValidate()
    begin
        IF rec.Reserve = rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            rec.AutoReserve;
        END;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF rec.Reserve = rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            rec.AutoReserve;
        END;
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD;

        SalesHeader.GET(rec."Document Type", rec."Document No.");
        IF DocumentTotals.SalesCheckNumberOfLinesLimit(SalesHeader) THEN
            DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
        CurrPage.UPDATE;
    end;


}

