report 50028 "Item Age Comp - Value-Variant"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ItemAgeCompValueVariant.rdl';
    Caption = 'Item Age Composition - Value';

    dataset
    {
        dataitem("Inventory Valuation"; "Inventory Valuation")
        {
            DataItemTableView = SORTING("No.", "Variant Code", "User ID");
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ItemTableCaptItemFilter; Item.TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(PeriodStartDate21; FORMAT(PeriodStartDate[2] + 1))
            {
            }
            column(PeriodStartDate3; FORMAT(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate31; FORMAT(PeriodStartDate[3] + 1))
            {
            }
            column(PeriodStartDate4; FORMAT(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate41; FORMAT(PeriodStartDate[4] + 1))
            {
            }
            column(PeriodStartDate5; FORMAT(PeriodStartDate[5]))
            {
            }
            column(PrintLine; PrintLine)
            {
            }
            column(InvtValueRTC1; InvtValueRTC[1])
            {
            }
            column(InvtValueRTC2; InvtValueRTC[2])
            {
            }
            column(InvtValueRTC5; InvtValueRTC[5])
            {
            }
            column(InvtValueRTC4; InvtValueRTC[4])
            {
            }
            column(InvtValueRTC3; InvtValueRTC[3])
            {
            }
            column(TotalInvtValueRTC; TotalInvtValueRTC)
            {
            }
            column(InvtValue1_Item; InvtValue[1])
            {
                AutoFormatType = 1;
            }
            column(InvtValue2_Item; InvtValue[2])
            {
                AutoFormatType = 1;
            }
            column(InvtValue3_Item; InvtValue[3])
            {
                AutoFormatType = 1;
            }
            column(InvtValue4_Item; InvtValue[4])
            {
                AutoFormatType = 1;
            }
            column(InvtValue5_Item; InvtValue[5])
            {
                AutoFormatType = 1;
            }
            column(TotalInvtValue_Item; TotalInvtValue_Item)
            {
                AutoFormatType = 1;
            }
            column(ItemAgeCompositionValueCaption; ItemAgeCompositionValueCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AfterCaption; AfterCaptionLbl)
            {
            }
            column(BeforeCaption; BeforeCaptionLbl)
            {
            }
            column(InventoryValueCaption; InventoryValueCaptionLbl)
            {
            }
            column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Variant Code" = FIELD("Variant Code"),
                               "Location Code" = FIELD("Location Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", Open)
                                    WHERE(Open = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    IF "Remaining Quantity" = 0 THEN
                        CurrReport.SKIP;
                    PrintLine := TRUE;
                    CalcRemainingQty;

                    IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
                        TotalInvtValue_Item += AverageCost * TotalInvtQty;
                        InvtValue[i] += AverageCost * InvtQty[i];

                        TotalInvtValueRTC += AverageCost * TotalInvtQty;
                        InvtValueRTC[i] += AverageCost * InvtQty[i];
                    END ELSE BEGIN
                        CalcUnitCost;
                        TotalInvtValue_Item += UnitCost * ABS(TotalInvtQty);
                        InvtValue[i] += UnitCost * ABS(InvtQty[i]);

                        TotalInvtValueRTC += UnitCost * ABS(TotalInvtQty);
                        InvtValueRTC[i] += UnitCost * ABS(InvtQty[i]);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    TotalInvtValue_Item := 0;
                    FOR i := 1 TO 5 DO
                        InvtValue[i] := 0;
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(TotalInvtValue_ItemLedgEntry; TotalInvtValue_Item)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue5_ItemLedgEntry; InvtValue[5])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue4_ItemLedgEntry; InvtValue[4])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue3_ItemLedgEntry; InvtValue[3])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue2_ItemLedgEntry; InvtValue[2])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue1_ItemLedgEntry; InvtValue[1])
                {
                    AutoFormatType = 1;
                }
                column(Description_Item; Item.Description)
                {
                }
                column(No_Item; Item."No.")
                {
                }
                column(Variant_Code; "Inventory Valuation"."Variant Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Item.GET("No.");
                Item.SETFILTER("Variant Filter", "Inventory Valuation"."Variant Code");
                IF Item."Costing Method" = Item."Costing Method"::Average THEN
                    ItemCostMgt.CalculateAverageCost(Item, AverageCost, AverageCostACY);

                PrintLine := FALSE;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("User ID", USERID);
                // CurrReport.CREATETOTALS(InvtValue, TotalInvtValue_Item);
            end;
        }
        dataitem("Integer Fotter"; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                IF NOT PrintToExcel THEN
                    CurrReport.SKIP;
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
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print To Excel';
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
        Item: Record Item;
        ItemCostMgt: Codeunit ItemCostManagement;
        ItemFilter: Text[250];
        InvtValue: array[6] of Decimal;
        InvtValueRTC: array[6] of Decimal;
        InvtQty: array[6] of Decimal;
        UnitCost: Decimal;
        PeriodStartDate: array[6] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtValue_Item: Decimal;
        TotalInvtValueRTC: Decimal;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        ItemAgeCompositionValueCaptionLbl: Label 'Item Age Composition - Value';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        BeforeCaptionLbl: Label '...Before';
        InventoryValueCaptionLbl: Label 'Inventory Value';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        TotalCaptionLbl: Label 'Total';
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        BlankLineNo: Integer;
        Text001: Label 'Inventory Value';
        Text003: Label 'Data';


    procedure CalcRemainingQty()
    begin
        WITH "Item Ledger Entry" DO BEGIN
            FOR i := 1 TO 5 DO
                InvtQty[i] := 0;

            TotalInvtQty := "Remaining Quantity";
            FOR i := 1 TO 5 DO
                IF ("Posting Date" > PeriodStartDate[i]) AND
                   ("Posting Date" <= PeriodStartDate[i + 1])
                THEN
                    IF "Remaining Quantity" <> 0 THEN BEGIN
                        InvtQty[i] := "Remaining Quantity";
                        EXIT;
                    END;
        END;
    end;


    procedure CalcUnitCost()
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
            UnitCost := 0;

            IF FIND('-') THEN
                REPEAT
                    IF "Partial Revaluation" THEN
                        SumUnitCost(UnitCost, "Cost Amount (Actual)" + "Cost Amount (Expected)", "Valued Quantity")
                    ELSE
                        SumUnitCost(UnitCost, "Cost Amount (Actual)" + "Cost Amount (Expected)", "Item Ledger Entry".Quantity);
                UNTIL NEXT = 0;
        END;
    end;

    local procedure SumUnitCost(var UnitCost: Decimal; CostAmount: Decimal; Quantity: Decimal)
    begin
        UnitCost := UnitCost + CostAmount / ABS(Quantity);
    end;

    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;
}

