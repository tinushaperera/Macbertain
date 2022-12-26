report 50011 "Item Age Comp - Qty.-Variant"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ItemAgeCompQtyVariant.rdl';
    Caption = 'Item Age Composition - Qty.';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TblCptnItemFilter; TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(Item2PeriodStartDate; FORMAT(PeriodStartDate[2] + 1))
            {
            }
            column(Item3PeriodStartDate; FORMAT(PeriodStartDate[3]))
            {
            }
            column(Item31PeriodStartDate; FORMAT(PeriodStartDate[3] + 1))
            {
            }
            column(Item4PeriodStartDate; FORMAT(PeriodStartDate[4]))
            {
            }
            column(Item41PeriodStartDate; FORMAT(PeriodStartDate[4] + 1))
            {
            }
            column(Item5PeriodStartDate; FORMAT(PeriodStartDate[5]))
            {
            }
            column(ItemAgeCompositionQtyCaption; ItemAgeCompositionQtyCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AfterCaption; AfterCaptionLbl)
            {
            }
            column(BeforeCaption; BeforeCaptionLbl)
            {
            }
            column(TotalInvtQtyCaption; TotalInvtQtyCaptionLbl)
            {
            }
            column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date")
                                    WHERE(Open = CONST(true));
                column(No_Item; Item."No.")
                {
                }
                column(InvtQty1_ItemLedgEntry; InvtQty[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty2_ItemLedgEntry; InvtQty[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty3_ItemLedgEntry; InvtQty[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty4_ItemLedgEntry; InvtQty[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(InvtQty5_ItemLedgEntry; InvtQty[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(TotalInvtQty; TotalInvtQty)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Desc_Item; Item.Description)
                {
                }
                column(PrintLine; PrintLine)
                {
                }
                column(VariantCode; "Variant Code")
                {
                }
                column(ItmCatDescription; ItmCatRec.Description)
                {
                }
                column(ProdctGroupDescription; ProdGropRec.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Remaining Quantity" = 0 THEN
                        CurrReport.SKIP;
                    PrintLine := TRUE;

                    FOR i := 1 TO 5 DO
                        InvtQty[i] := 0;

                    TotalInvtQty := "Remaining Quantity";
                    FOR i := 1 TO 5 DO
                        IF ("Posting Date" > PeriodStartDate[i]) AND
                           ("Posting Date" <= PeriodStartDate[i + 1])
                        THEN
                            InvtQty[i] := "Remaining Quantity";

                    ItemVrntRec.RESET;
                    ItemVrntRec.SETRANGE("Item No.", "Item No.");
                    ItemVrntRec.SETRANGE(Code, "Variant Code");
                    IF ItemVrntRec.FINDSET THEN;

                    IF ItemRec.GET("Item No.") THEN;
                    IF ItmCatRec.GET(ItemRec."Item Category Code") THEN;

                    ProdGropRec.RESET;
                    ProdGropRec.SETRANGE("Item Category Code", ItemRec."Item Category Code");
                    ProdGropRec.SETRANGE(Code, ItemRec."MCB Product Group Code");
                    IF ProdGropRec.FINDFIRST THEN;
                end;

                trigger OnPreDataItem()
                begin
                    // CurrReport.CREATETOTALS(TotalInvtQty, InvtQty);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PrintLine := FALSE;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(EndingDate; PeriodStartDate[5])
                    {
                        Caption = 'Ending Date';

                        trigger OnValidate()
                        begin
                            IF PeriodStartDate[5] = 0D THEN
                                ERROR(Text002);
                        end;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength) = '' THEN
                                EVALUATE(PeriodLength, '<0D>');
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodStartDate[5] = 0D THEN
                PeriodStartDate[5] := CALCDATE('<CM>', WORKDATE);
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;

        PeriodStartDate[6] := 99991231D;
        EVALUATE(NegPeriodLength, STRSUBSTNO('-%1', FORMAT(PeriodLength)));
        FOR i := 1 TO 3 DO
            PeriodStartDate[5 - i] := CALCDATE(NegPeriodLength, PeriodStartDate[6 - i]);
    end;

    var
        Text002: Label 'Enter the ending date';
        ItemFilter: Text[250];
        InvtQty: array[6] of Decimal;
        PeriodStartDate: array[7] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        ItemAgeCompositionQtyCaptionLbl: Label 'Item Age Composition - Quantity';
        PageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        BeforeCaptionLbl: Label '...Before';
        TotalInvtQtyCaptionLbl: Label 'Inventory';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        ItemVrntRec: Record "Item Variant";
        ItmCatRec: Record "Item Category";
        ItemRec: Record Item;
        ProdGropRec: Record "MCB Product Group";// mcd product group -> RJ saild 


    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;
}

