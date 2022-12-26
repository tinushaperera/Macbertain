report 50092 "Inventory Valuation-Variants"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/InventoryValuationVariants.rdl';
    Caption = 'Inventory Valuation';
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Inventory Valuation"; "Inventory Valuation")
        {
            DataItemTableView = SORTING("Inventory Posting Group");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group";
            column(BoM_Text; BoM_TextLbl)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(STRSUBSTNO___1___2__Item_TABLECAPTION_ItemFilter_; STRSUBSTNO('%1: %2', TABLECAPTION, ItemFilter))
            {
            }
            column(STRSUBSTNO_Text005_StartDateText_; STRSUBSTNO(Text005, StartDateText))
            {
            }
            column(STRSUBSTNO_Text005_FORMAT_EndDate__; STRSUBSTNO(Text005, FORMAT(EndDate)))
            {
            }
            column(ShowExpected; ShowExpected)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(ItemUnitCost; ItemUnitCost)
            {
            }
            column(InvCostPostedToGL_Control53; InvCostPostedToGL)
            {
                AutoFormatType = 1;
            }
            column(ValueOfQtyOnHand; ValueOfQtyOnHand)
            {
                AutoFormatType = 1;
            }
            column(ValueOfRcdIncreases; ValueOfRcdIncreases)
            {
                AutoFormatType = 1;
            }
            column(CostOfShipDecreases; CostOfShipDecreases)
            {
                AutoFormatType = 1;
            }
            column(ValueOfQtyOnHand___ValueOfRcdIncreases___CostOfShipDecreases; ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases)
            {
                AutoFormatType = 1;
            }
            column(Item_Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(Inventory_ValuationCaption; Inventory_ValuationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(This_report_includes_entries_that_have_been_posted_with_expected_costs_Caption; This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl)
            {
            }
            column(Value_Entry__Item_No__Caption; "Value Entry".FIELDCAPTION("Item No."))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Size_DescriptionCaptiom; FIELDCAPTION("Size Description"))
            {
            }
            column(Color_DescriptionCaption; FIELDCAPTION("Color Description"))
            {
            }
            column(Item_Cat_DescriptionCaption; FIELDCAPTION("Item Cat. Description"))
            {
            }
            column(Product_Group_DescriptionCaption; FIELDCAPTION("Product Group Description"))
            {
            }
            column(InvIncreasesCaption; InvIncreasesCaptionLbl)
            {
            }
            column(InvDecreasesCaption; InvDecreasesCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(QuantityCaption_Control31; QuantityCaption_Control31Lbl)
            {
            }
            column(QuantityCaption_Control40; QuantityCaption_Control40Lbl)
            {
            }
            column(InvCostPostedToGL_Control53Caption; InvCostPostedToGL_Control53CaptionLbl)
            {
            }
            column(QuantityCaption_Control58; QuantityCaption_Control58Lbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Expected_Cost_Included_TotalCaption; Expected_Cost_Included_TotalCaptionLbl)
            {
            }
            column(Expected_Cost_TotalCaption; Expected_Cost_TotalCaptionLbl)
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemTableView = SORTING("Item No.", "Posting Date", "Item Ledger Entry Type");
                MaxIteration = 1;
                column(InvCostPostedToGL; InvCostPostedToGL)
                {
                    AutoFormatType = 1;
                }
                column(Value_Entry___Cost_Amount__Actual__; "Cost Amount (Actual)")
                {
                }
                column(Value_Entry__Invoiced_Quantity_; "Invoiced Quantity")
                {
                }
                column(CostOfInvDecreases; CostOfInvDecreases)
                {
                    AutoFormatType = 1;
                }
                column(InvDecreases; InvDecreases)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ValueOfInvIncreases; ValueOfInvIncreases)
                {
                    AutoFormatType = 1;
                }
                column(InvIncreases; InvIncreases)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ValueOfInvoicedQty; ValueOfInvoicedQty)
                {
                    AutoFormatType = 1;
                }
                column(InvoicedQty; InvoicedQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(Item__Base_Unit_of_Measure_; "Inventory Valuation"."Base Unit of Measure")
                {
                }
                column(Item_Description; "Inventory Valuation".Description)
                {
                }
                column(Value_Entry__Item_No__; "Item No.")
                {
                }
                column(QtyOnHand; QtyOnHand)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(RcdIncreases; RcdIncreases)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ShipDecreases; ShipDecreases)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(Value_Entry__Item_Ledger_Entry_Quantity_; "Item Ledger Entry Quantity")
                {
                }
                column(CostPostedToGL; CostPostedToGL)
                {
                    AutoFormatType = 1;
                }
                column(ExpCostPostedToGL; ExpCostPostedToGL)
                {
                    AutoFormatType = 1;
                }
                column(Expected_Cost_IncludedCaption; Expected_Cost_IncludedCaptionLbl)
                {
                }
                column(Value_Entry_Variant_Code_; "Variant Code")
                {
                }
                column(Item_Cat_Description_; "Inventory Valuation"."Item Cat. Description")
                {
                }
                column(Product_Group_Description_; "Inventory Valuation"."Product Group Description")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ItemVarient.GET("Item No.", "Variant Code") THEN;

                    CalcCostAtStartDate;

                    CalcCostOfIncreases;
                    CalcCostOfDecreases;
                    CalcCostOfTransfers;

                    CalcCostAtEndDate;

                    ValueOfQtyOnHand += ValueOfInvoicedQty;
                    ValueOfRcdIncreases += ValueOfInvIncreases;
                    CostOfShipDecreases += CostOfInvDecreases;
                    CostPostedToGL := ExpCostPostedToGL + InvCostPostedToGL;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Item No.", "Inventory Valuation"."No.");
                    SETRANGE("Variant Code", "Inventory Valuation"."Variant Code");
                    SETFILTER("Location Code", "Inventory Valuation".GETFILTER("Location Filter"));
                    SETFILTER("Global Dimension 1 Code", "Inventory Valuation".GETFILTER("Global Dimension 1 Filter"));
                    SETFILTER("Global Dimension 2 Code", "Inventory Valuation".GETFILTER("Global Dimension 2 Filter"));
                    IF EndDate <> 0D THEN
                        SETRANGE("Posting Date", 0D, EndDate);
                    CurrReport.CREATETOTALS(
                      QtyOnHand, RcdIncreases, ShipDecreases, "Item Ledger Entry Quantity",
                      InvoicedQty, InvIncreases, InvDecreases, "Invoiced Quantity");
                    CurrReport.CREATETOTALS(
                      ValueOfQtyOnHand, ValueOfRcdIncreases, CostOfShipDecreases, CostPostedToGL, ExpCostPostedToGL,
                      ValueOfInvoicedQty, ValueOfInvIncreases, CostOfInvDecreases, "Cost Amount (Actual)",
                      InvCostPostedToGL);
                end;
            }

            trigger OnAfterGetRecord()
            var
                StocKeeUnit: Record "Stockkeeping Unit";
            begin
                CALCFIELDS("Assembly BOM");
                //Get Item Unit Cost
                StocKeeUnit.SETRANGE("Item No.", "No.");
                StocKeeUnit.SETRANGE("Variant Code", "Variant Code");
                IF StocKeeUnit.FINDSET THEN
                    ItemUnitCost := StocKeeUnit."Unit Cost"
                ELSE
                    ItemUnitCost := 0;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("User ID", USERID);
                CurrReport.CREATETOTALS(QtyOnHand, RcdIncreases, ShipDecreases, "Value Entry"."Item Ledger Entry Quantity");
                CurrReport.CREATETOTALS(InvoicedQty, InvIncreases, InvDecreases);
                CurrReport.CREATETOTALS(
                  ValueOfQtyOnHand, ValueOfRcdIncreases, CostOfShipDecreases, CostPostedToGL, ExpCostPostedToGL);
                CurrReport.CREATETOTALS(
                  ValueOfInvoicedQty, ValueOfInvIncreases, CostOfInvDecreases,
                  "Value Entry"."Cost Amount (Actual)", InvCostPostedToGL);
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
                    field(StartDate; StartDate)
                    {
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; EndDate)
                    {
                        Caption = 'Ending Date';
                    }
                    field(IncludeExpectedCost; ShowExpected)
                    {
                        Caption = 'Include Expected Cost';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF (StartDate = 0D) AND (EndDate = 0D) THEN
                EndDate := WORKDATE;
        end;
    }

    labels
    {
        Inventory_Posting_Group_NameCaption = 'Inventory Posting Group Name';
        Expected_CostCaption = 'Expected Cost';
    }

    trigger OnPreReport()
    begin
        IF (StartDate = 0D) AND (EndDate = 0D) THEN
            EndDate := WORKDATE;

        IF StartDate IN [0D, 00000101D] THEN
            StartDateText := ''
        ELSE
            StartDateText := FORMAT(StartDate - 1);

        ItemFilter := "Inventory Valuation".GETFILTERS;
    end;

    var
        Text005: Label 'As of %1';
        ItemVarient: Record "Item Variant";
        StartDate: Date;
        EndDate: Date;
        ShowExpected: Boolean;
        ItemFilter: Text[250];
        StartDateText: Text[10];
        ValueOfInvoicedQty: Decimal;
        ValueOfQtyOnHand: Decimal;
        ValueOfInvIncreases: Decimal;
        ValueOfRcdIncreases: Decimal;
        CostOfInvDecreases: Decimal;
        CostOfShipDecreases: Decimal;
        InvCostPostedToGL: Decimal;
        CostPostedToGL: Decimal;
        InvoicedQty: Decimal;
        QtyOnHand: Decimal;
        InvIncreases: Decimal;
        RcdIncreases: Decimal;
        InvDecreases: Decimal;
        ShipDecreases: Decimal;
        ExpCostPostedToGL: Decimal;
        BoM_TextLbl: Label 'Base UoM';
        Inventory_ValuationCaptionLbl: Label 'Inventory Valuation';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl: Label 'This report includes entries that have been posted with expected costs.';
        InvIncreasesCaptionLbl: Label 'Increases (LCY)';
        InvDecreasesCaptionLbl: Label 'Decreases (LCY)';
        QuantityCaptionLbl: Label 'Quantity';
        ValueCaptionLbl: Label 'Value';
        QuantityCaption_Control31Lbl: Label 'Quantity';
        QuantityCaption_Control40Lbl: Label 'Quantity';
        InvCostPostedToGL_Control53CaptionLbl: Label 'Cost Posted to G/L';
        QuantityCaption_Control58Lbl: Label 'Quantity';
        TotalCaptionLbl: Label 'Total';
        Expected_Cost_Included_TotalCaptionLbl: Label 'Expected Cost Included Total';
        Expected_Cost_TotalCaptionLbl: Label 'Expected Cost Total';
        Expected_Cost_IncludedCaptionLbl: Label 'Expected Cost Included';
        ItemUnitCost: Decimal;
        Inx: Integer;

    local procedure AddAmounts(ValueEntry: Record "Value Entry"; var CostAmtExp: Decimal; var CostAmtActual: Decimal; var InvQty: Decimal; var Qty: Decimal; Sign: Integer)
    begin
        WITH ValueEntry DO BEGIN
            CostAmtExp += "Cost Amount (Expected)" * Sign;
            CostAmtActual += "Cost Amount (Actual)" * Sign;
            InvQty += "Invoiced Quantity" * Sign;
            Qty += "Item Ledger Entry Quantity" * Sign;
        END;
    end;

    local procedure GetOutboundItemEntry(ItemLedgerEntryNo: Integer): Boolean
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
        IF NOT ItemApplnEntry.FINDFIRST THEN
            EXIT(TRUE);

        ItemLedgEntry.SETRANGE("Item No.", "Inventory Valuation"."No.");
        ItemLedgEntry.SETRANGE("Variant Code", "Inventory Valuation"."Variant Code");
        ItemLedgEntry.SETFILTER("Location Code", "Inventory Valuation".GETFILTER("Location Filter"));
        ItemLedgEntry.SETFILTER("Global Dimension 1 Code", "Inventory Valuation".GETFILTER("Global Dimension 1 Filter"));
        ItemLedgEntry.SETFILTER("Global Dimension 2 Code", "Inventory Valuation".GETFILTER("Global Dimension 2 Filter"));
        ItemLedgEntry."Entry No." := ItemApplnEntry."Outbound Item Entry No.";
        EXIT(NOT ItemLedgEntry.FIND);
    end;


    procedure SetStartDate(DateValue: Date)
    begin
        StartDate := DateValue;
    end;


    procedure SetEndDate(DateValue: Date)
    begin
        EndDate := DateValue;
    end;


    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewShowExpected: Boolean)
    begin
        StartDate := NewStartDate;
        EndDate := NewEndDate;
        ShowExpected := NewShowExpected;
    end;

    local procedure CalcCostAtStartDate()
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            IF StartDate = 0D THEN
                EXIT;

            COPY("Value Entry");

            SETRANGE("Posting Date", 0D, CALCDATE('<-1D>', StartDate));
            CALCSUMS(
              "Item Ledger Entry Quantity",
              "Cost Amount (Actual)",
              "Cost Amount (Expected)",
              "Invoiced Quantity");

            AddAmounts(ValueEntry, ValueOfQtyOnHand, ValueOfInvoicedQty, InvoicedQty, QtyOnHand, 1)
        END;
    end;

    local procedure CalcCostOfIncreases()
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            COPY("Value Entry");

            IF EndDate = 0D THEN
                SETRANGE("Posting Date", StartDate, 99991231D)
            ELSE
                SETRANGE("Posting Date", StartDate, EndDate);

            SETFILTER(
              "Item Ledger Entry Type", '%1|%2|%3|%4',
              "Item Ledger Entry Type"::Purchase,
              "Item Ledger Entry Type"::"Positive Adjmt.",
              "Item Ledger Entry Type"::Output,
              "Item Ledger Entry Type"::"Assembly Output");
            CALCSUMS(
              "Item Ledger Entry Quantity",
              "Cost Amount (Actual)",
              "Cost Amount (Expected)",
              "Invoiced Quantity");

            AddAmounts(ValueEntry, ValueOfRcdIncreases, ValueOfInvIncreases, InvIncreases, RcdIncreases, 1)
        END;
    end;

    local procedure CalcCostOfDecreases()
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            COPY("Value Entry");

            IF EndDate = 0D THEN
                SETRANGE("Posting Date", StartDate, 99991231D)
            ELSE
                SETRANGE("Posting Date", StartDate, EndDate);

            SETFILTER(
              "Item Ledger Entry Type", '%1|%2|%3|%4',
              "Item Ledger Entry Type"::Sale,
              "Item Ledger Entry Type"::"Negative Adjmt.",
              "Item Ledger Entry Type"::Consumption,
              "Item Ledger Entry Type"::"Assembly Consumption");
            CALCSUMS(
              "Item Ledger Entry Quantity",
              "Cost Amount (Actual)",
              "Cost Amount (Expected)",
              "Invoiced Quantity");

            AddAmounts(ValueEntry, CostOfShipDecreases, CostOfInvDecreases, InvDecreases, ShipDecreases, -1);
        END;
    end;

    local procedure CalcCostAtEndDate()
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            COPY("Value Entry");

            IF EndDate = 0D THEN
                SETRANGE("Posting Date", 0D, 99991231D)
            ELSE
                SETRANGE("Posting Date", 0D, EndDate);

            CALCSUMS(
              "Cost Amount (Actual)",
              "Cost Posted to G/L",
              "Expected Cost Posted to G/L",
              "Item Ledger Entry Quantity",
              "Invoiced Quantity");

            ExpCostPostedToGL := "Expected Cost Posted to G/L";
            InvCostPostedToGL := "Cost Posted to G/L";
            "Value Entry" := ValueEntry;
        END;
    end;

    local procedure CalcCostOfTransfers()
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            COPY("Value Entry");
            SETRANGE("Item Ledger Entry Type", "Item Ledger Entry Type"::Transfer);
            IF FIND('-') THEN
                REPEAT
                    IF "Posting Date" >= StartDate THEN
                        IF TRUE IN ["Valued Quantity" < 0, NOT GetOutboundItemEntry("Item Ledger Entry No.")] THEN
                            AddAmounts(ValueEntry, CostOfShipDecreases, CostOfInvDecreases, InvDecreases, ShipDecreases, -1)
                        ELSE
                            AddAmounts(ValueEntry, ValueOfRcdIncreases, ValueOfInvIncreases, InvIncreases, RcdIncreases, 1);
                UNTIL NEXT = 0;
        END;
    end;
}

