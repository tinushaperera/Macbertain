report 50154 "Stock Age Analysis-W/O Cost"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/StockAgeAnalysisWOCost.rdl';
    Caption = 'Stock Age Analysis';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Inventory Posting Group", "Date Filter", "Location Filter";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ItemTableCaptItemFilter; TABLECAPTION + ': ' + ItemFilter)
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
            column(DatePred1; DateText[1])
            {
            }
            column(DatePred2; DateText[2])
            {
            }
            column(DatePred3; DateText[3])
            {
            }
            column(DatePred4; DateText[4])
            {
            }
            column(DatePred5; DateText[5])
            {
            }
            column(com_address; ComRec.Address)
            {
            }
            column(com_address2; ComRec."Address 2")
            {
            }
            column(com_city; ComRec.City)
            {
            }
            column(phone_no; ComRec."Phone No.")
            {
            }
            column(com_fax; ComRec."Fax No.")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", Open)
                                    WHERE(Open = CONST(true));
                RequestFilterFields = "Item No.", "Location Code";
                column(LocCode; "Location Code")
                {
                }
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
                column(InvtQty1_ItemLedgEntry; CalInvtQty[1])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InvtQty2_ItemLedgEntry; CalInvtQty[2])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InvtQty3_ItemLedgEntry; CalInvtQty[3])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InvtQty4_ItemLedgEntry; CalInvtQty[4])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InvtQty5_ItemLedgEntry; CalInvtQty[5])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(TotalInvtQty; CalTotalInvtQty)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(LocName; Loc.Name)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Inx: Integer;
                begin
                    TotalInvtValue_Item := 0;
                    FOR i := 1 TO 5 DO BEGIN
                        InvtValue[i] := 0;
                        CalInvtQty[i] := 0;
                    END;
                    CalTotalInvtQty := 0;

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
                    //NS
                    FOR Inx := 1 TO 5 DO BEGIN
                        CalInvtQty[Inx] := InvtQty[Inx];//CalInvtQty[Inx] + InvtQty[Inx];
                        CalTotalInvtQty := CalTotalInvtQty + InvtQty[Inx];
                    END;
                    Loc.GET("Location Code");
                end;

                trigger OnPreDataItem()
                begin
                    /*
                    TotalInvtValue_Item := 0;
                    FOR i := 1 TO 5 DO BEGIN
                      InvtValue[i] := 0;
                      CalInvtQty[i] := 0;
                    END;
                    CalTotalInvtQty := 0;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "Costing Method" = "Costing Method"::Average THEN
                    ItemCostMgt.CalculateAverageCost(Item, AverageCost, AverageCostACY);

                PrintLine := FALSE;
            end;

            trigger OnPreDataItem()
            var
                DateInt: Integer;
                Loop: Integer;
            begin
                // CurrReport.CREATETOTALS(InvtValue, TotalInvtValue_Item);
                IF PeriodLength = PeriodLength::"180D" THEN
                    DateInt := 180
                ELSE
                    IF PeriodLength = PeriodLength::"90D" THEN
                        DateInt := 90
                    ELSE
                        IF PeriodLength = PeriodLength::"60D" THEN
                            DateInt := 60
                        ELSE
                            DateInt := 30;

                FOR i := 2 TO 4 DO BEGIN
                    DateText[i] := FORMAT(Loop + 1) + '-' + FORMAT(Loop + DateInt) + ' Days';
                    Loop := Loop + DateInt;
                END;
                IF ComRec.GET THEN;
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
                    field(AgingBy; AgingBy)
                    {
                        Caption = 'Aging by';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //IF PeriodStartDate[5] = 0D THEN
            PeriodStartDate[5] := TODAY;//CALCDATE('<CM>',WORKDATE);
                                        //IF FORMAT(PeriodLength) = '' THEN
                                        //EVALUATE(PeriodLength,'<1M>');
            AgingBy := AgingBy::"Document Date";
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS + ' ,' + "Item Ledger Entry".GETFILTERS;

        PeriodStartDate[6] := 99991231D;
        EVALUATE(NegPeriodLength, STRSUBSTNO('-%1', FORMAT(PeriodLength)));
        FOR i := 1 TO 3 DO
            PeriodStartDate[5 - i] := CALCDATE(NegPeriodLength, PeriodStartDate[6 - i]);
    end;

    var
        Text002: Label 'Enter the ending date';
        ItemCostMgt: Codeunit ItemCostManagement;

        ItemFilter: Text[250];
        InvtValue: array[6] of Decimal;
        InvtValueRTC: array[6] of Decimal;
        InvtQty: array[6] of Decimal;
        UnitCost: Decimal;
        PeriodStartDate: array[6] of Date;
        PeriodLength: Option "30D","60D","90D","180D";
        i: Integer;
        TotalInvtValue_Item: Decimal;
        TotalInvtValueRTC: Decimal;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        ItemAgeCompositionValueCaptionLbl: Label 'Stock Age Analysis';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        BeforeCaptionLbl: Label '...Before';
        InventoryValueCaptionLbl: Label 'Inventory Value';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        TotalCaptionLbl: Label 'Total';
        CalInvtQty: array[6] of Decimal;
        CalTotalInvtQty: Decimal;
        AgingBy: Option "Posting Date","Document Date";
        DateText: array[5] of Text[15];
        Loc: Record Location;
        ComRec: Record "Company Information";


    procedure CalcRemainingQty()
    begin
        IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
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
        END
        ELSE BEGIN
            WITH "Item Ledger Entry" DO BEGIN
                FOR i := 1 TO 5 DO
                    InvtQty[i] := 0;

                TotalInvtQty := "Remaining Quantity";
                FOR i := 1 TO 5 DO
                    IF ("Document Date" > PeriodStartDate[i]) AND
                       ("Document Date" <= PeriodStartDate[i + 1])
                    THEN
                        IF "Remaining Quantity" <> 0 THEN BEGIN
                            InvtQty[i] := "Remaining Quantity";
                            EXIT;
                        END;
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


    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: Option "30D","60D","90D","180D")
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;
}

