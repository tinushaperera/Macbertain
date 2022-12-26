report 50038 "Customized Debtor Age Anly"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CustomizedDebtorAgeAnly.rdl';
    Caption = 'Debtor Age Anlysis Sum- Sales Person Wise';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("Customer Posting Group");
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(FormatEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(PostingDate; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(TableCaptnCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AgingByDueDate; AgingBy = AgingBy::"Due Date")
            {
            }
            column(AgedbyDocumnetDate; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(OnlyCusPstGrp; OnlyCusPostGrp)
            {
            }
            column(GrandTotalCLE5RemAmt; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmt; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmt; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmt; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmt; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLEAmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE4CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(AgedAccReceivableCptn; AgedAccReceivableCptnLbl)
            {
            }
            column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
            {
            }
            column(AllAmtinLCYCptn; AllAmtinLCYCptnLbl)
            {
            }
            column(AgedOverdueAmtCptn; AgedOverdueAmtCptnLbl)
            {
            }
            column(CLEEndDateAmtLCYCptn; CLEEndDateAmtLCYCptnLbl)
            {
            }
            column(CLEEndDateDueDateCptn; CLEEndDateDueDateCptnLbl)
            {
            }
            column(CLEEndDateDocNoCptn; CLEEndDateDocNoCptnLbl)
            {
            }
            column(CLEEndDatePstngDateCptn; CLEEndDatePstngDateCptnLbl)
            {
            }
            column(CLEEndDateDocTypeCptn; CLEEndDateDocTypeCptnLbl)
            {
            }
            column(OriginalAmtCptn; OriginalAmtCptnLbl)
            {
            }
            column(TotalLCYCptn; TotalLCYCptnLbl)
            {
            }
            column(NewPagePercustomer; NewPagePercustomer)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(SalesPerCode; "Salesperson Code")
            {
            }
            column(PDBal; "PD Check Amount")
            {
            }
            column(TotPDAmt; TotPDAmt)
            {
            }
            column(GrndTotPDAmt; GrandTotPDAmt)
            {
            }
            column(AmtLCY; "Sales (LCY)")
            {
            }
            column(SAmt; SalesAmt)
            {
            }
            column(TotSAmt; TotSalesAmt)
            {
            }
            column(PaymentTermsCode_Customer; "Payment Terms Code")
            {
            }
            column(CreditLimitLCY_Customer; Customer."Credit Limit (LCY)")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");
                RequestFilterFields = "Salesperson Code", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Region Code", "Territory Code";

                trigger OnAfterGetRecord()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(CustLedgEntry);
                        UNTIL CustLedgEntry.NEXT = 0;

                    IF "Closed by Entry No." <> 0 THEN BEGIN
                        CustLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(CustLedgEntry);
                            UNTIL CustLedgEntry.NEXT = 0;
                    END;


                    CustLedgEntry.RESET;
                    CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(CustLedgEntry);
                        UNTIL CustLedgEntry.NEXT = 0;
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenCustLedgEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");
                RequestFilterFields = "Salesperson Code", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Region Code", "Territory Code";

                trigger OnAfterGetRecord()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        CALCFIELDS("Remaining Amt. (LCY)");
                        IF "Remaining Amt. (LCY)" = 0 THEN
                            CurrReport.SKIP;
                    END;
                    InsertTemp(OpenCustLedgEntry);
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    END;
                end;
            }
            dataitem(CurrencyLoop; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempCustLedgEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(Name1_Cust; Customer.Name)
                    {
                        IncludeCaption = true;
                    }
                    column(No_Cust; Customer."No.")
                    {
                        IncludeCaption = true;
                    }
                    column(CusPostGrp_Cust; CustLedgEntryEndingDate."Salesperson Code")
                    {
                    }
                    column(Dimension_Name; SPCode.Name)
                    {
                    }
                    column(CLEEndDateRemAmtLCY; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE1RemAmtLCY; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE2RemAmtLCY; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE3RemAmtLCY; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE4RemAmtLCY; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE5RemAmtLCY; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CLEEndDateAmtLCY; CustLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CLEEndDueDate; FORMAT(CustLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(CLEEndDateDocNo; CustLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(CLEDocType; FORMAT(CustLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(CLEPostingDate; FORMAT(CustLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedCLE5TempRemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE4TempRemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE3TempRemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE2TempRemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE1TempRemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(RemAmt_CLEEndDate; CustLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CLEEndDate; CustLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Name_Cust; STRSUBSTNO(Text005, Customer.Name))
                    {
                    }
                    column(TotalCLE1AmtLCY; TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmtLCY; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmtLCY; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmtLCY; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmtLCY; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmtLCY; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(BUWise1RemAmtLCY; BUWiseCusLdgrEntry[1]."Remaining Amt. (LCY)")
                    {
                    }
                    column(BUWise2RemAmtLCY; BUWiseCusLdgrEntry[2]."Remaining Amt. (LCY)")
                    {
                    }
                    column(BUWise3RemAmtLCY; BUWiseCusLdgrEntry[3]."Remaining Amt. (LCY)")
                    {
                    }
                    column(BUWise4RemAmtLCY; BUWiseCusLdgrEntry[4]."Remaining Amt. (LCY)")
                    {
                    }
                    column(BUWise5RemAmtLCY; BUWiseCusLdgrEntry[5]."Remaining Amt. (LCY)")
                    {
                    }
                    column(CurrrencyCode; CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmt; TotalCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmt; TotalCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmt; TotalCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmt; TotalCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmt; TotalCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1Amt; TotalCustLedgEntry[1].Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCheck; CustFilterCheck)
                    {
                    }
                    column(GrandTotalCLE1AmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE5PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE3PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE2PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE1PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE5RemAmtLCY; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE4RemAmtLCY; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE3RemAmtLCY; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE2RemAmtLCY; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE1RemAmtLCY; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CLEPayAmount; TotPayAmt)
                    {
                    }
                    column(CLEPayAmountLCY; TotPayAmtLCY)
                    {
                    }
                    column(CusPostGrpTotCLEPayAmt; CusPostGrpTotPayAmt)
                    {
                    }
                    column(CusPostGrpTotCLEPayAmtLCY; CusPostGrpTotPayAmtLCY)
                    {
                    }
                    column(GrandTotCLEPayAmount; GrandTotPayAmt)
                    {
                    }
                    column(GrandTotCLEPayAmountLCY; GrandTotPayAmtLCY)
                    {
                    }
                    column(BalanceTotal; BalanceTotal)
                    {
                    }
                    column(TotPayAmt; TotPayAmt)
                    {
                    }
                    column(DateWiseTotal; DateWiseTotal)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                        Integer1: Integer;
                        SalesRecSetup: Record "Sales & Receivables Setup";
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempCustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF TempCustLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;
                        BalanceTotal := 0;
                        TotPayAmt := 0;
                        TotPayAmtLCY := 0;
                        CustLedgEntryEndingDate := TempCustLedgEntry;
                        DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                        IF DetailedCustomerLedgerEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                IF SPCode.GET(CustLedgEntryEndingDate."Salesperson Code") THEN;
                                IF (DetailedCustomerLedgerEntry."Entry Type" =
                                    DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (CustLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN BEGIN
                                    IF CustLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        DetailedCustomerLedgerEntry."Posting Date" :=
                                          CustLedgEntryEndingDate."Document Date"
                                    ELSE
                                        IF (CustLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustLedgEntryEndingDate."Due Date"
                                END;

                                IF (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) OR
                                   (TempCustLedgEntry.Open AND
                                    (AgingBy = AgingBy::"Due Date") AND
                                    (CustLedgEntryEndingDate."Due Date" > EndingDate) AND
                                    (CustLedgEntryEndingDate."Posting Date" <= EndingDate)) THEN BEGIN
                                    IF DetailedCustomerLedgerEntry."Entry Type" IN
                                       [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    THEN BEGIN
                                        CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Amount (LCY)" :=
                                          CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    END;
                                    IF DetailedCustomerLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                        CustLedgEntryEndingDate."Remaining Amount" :=
                                          CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                          CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    END;
                                END;
                            UNTIL DetailedCustomerLedgerEntry.NEXT = 0;

                        IF CustLedgEntryEndingDate."Remaining Amount" = 0 THEN
                            CurrReport.SKIP;

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                BEGIN
                                    IF CustLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                        CustLedgEntryEndingDate."Remaining Amount" := 0;
                                        CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                    END;
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                END;
                        END;
                        CLEAR(AgedCustLedgEntry);

                        GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";

                        AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";

                        BUWiseCusLdgrEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        //  TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                        // TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[1].Amount := CustLedgEntryEndingDate."Remaining Amount";

                        TotalCustLedgEntry[1]."Amount (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";



                        IF PeriodIndex = 1 THEN BEGIN
                            TotalCustLedgEntry[1]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[1]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        END
                        ELSE BEGIN
                            TotalCustLedgEntry[1]."Remaining Amount" := 0;
                            TotalCustLedgEntry[1]."Remaining Amt. (LCY)" := 0;
                        END;

                        IF PeriodIndex = 2 THEN BEGIN
                            TotalCustLedgEntry[2]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[2]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        END
                        ELSE BEGIN
                            TotalCustLedgEntry[2]."Remaining Amount" := 0;
                            TotalCustLedgEntry[2]."Remaining Amt. (LCY)" := 0;
                        END;


                        IF PeriodIndex = 3 THEN BEGIN
                            TotalCustLedgEntry[3]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[3]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        END
                        ELSE BEGIN
                            TotalCustLedgEntry[3]."Remaining Amount" := 0;
                            TotalCustLedgEntry[3]."Remaining Amt. (LCY)" := 0;
                        END;

                        IF PeriodIndex = 4 THEN BEGIN
                            TotalCustLedgEntry[4]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[4]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            IF TotalCustLedgEntry[4]."Remaining Amt. (LCY)" > 0 THEN
                                VAR90Amt := TotalCustLedgEntry[4]."Remaining Amt. (LCY)"; //RJ
                        END
                        ELSE BEGIN
                            TotalCustLedgEntry[4]."Remaining Amount" := 0;
                            TotalCustLedgEntry[4]."Remaining Amt. (LCY)" := 0;
                            VAR90Amt := 0; //RJ
                        END;

                        IF PeriodIndex = 5 THEN BEGIN
                            TotalCustLedgEntry[5]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[5]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            IF TotalCustLedgEntry[5]."Remaining Amt. (LCY)" > 0 THEN
                                VAR120Amt := TotalCustLedgEntry[5]."Remaining Amt. (LCY)"; //RJ
                        END
                        ELSE BEGIN
                            TotalCustLedgEntry[5]."Remaining Amount" := 0;
                            TotalCustLedgEntry[5]."Remaining Amt. (LCY)" := 0;
                            VAR120Amt := 0; //RJ
                        END;

                        SalesRecSetup.GET; //RJ
                        CreateDebtorEntry(SalesRecSetup."Current Salary Year", SalesRecSetup."Current Salary Month", CustLedgEntryEndingDate); //RJ

                        IF (CustLedgEntryEndingDate."Remaining Amt. (LCY)" < 0) THEN BEGIN
                            TotPayAmt := CustLedgEntryEndingDate."Remaining Amount";
                            TotPayAmtLCY := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            CusPostGrpTotPayAmt += CustLedgEntryEndingDate."Remaining Amount";
                            CusPostGrpTotPayAmtLCY += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            GrandTotPayAmt := CustLedgEntryEndingDate."Remaining Amount";
                            GrandTotPayAmtLCY += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        END;


                    end;

                    trigger OnPostDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            UpdateCurrencyTotals;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN BEGIN
                            IF (TempCurrency.Code = '') OR (TempCurrency.Code = GLSetup."LCY Code") THEN
                                TempCustLedgEntry.SETFILTER("Currency Code", '%1|%2', GLSetup."LCY Code", '')
                            ELSE
                                TempCustLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                        END;



                        PageGroupNo := NextPageGroupNo;
                        IF NewPagePercustomer AND (NumberOfCurrencies > 0) THEN
                            NextPageGroupNo := PageGroupNo + 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalCustLedgEntry);

                    IF Number = 1 THEN BEGIN
                        IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF TempCurrency.NEXT = 0 THEN
                            CurrReport.BREAK;

                    IF TempCurrency.Code <> '' THEN
                        CurrencyCode := TempCurrency.Code
                    ELSE
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPagePercustomer THEN
                    PageGroupNo += 1;
                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempCustLedgEntry.RESET;
                TempCustLedgEntry.DELETEALL;
                IF CusPostGroup <> "Customer Posting Group" THEN BEGIN
                    CusPostGroup := "Customer Posting Group";
                    CustPostGroup(CusPostGroup);
                    CusPostGrpTotPayAmt := 0;
                    CusPostGrpTotPayAmtLCY := 0;
                END;
            end;

            trigger OnPreDataItem()
            var
                MonthSaleIncRec: Record "Monthly Sales Incentive";
                SalesRecSetup: Record "Sales & Receivables Setup";
            begin
                SalesRecSetup.GET;
                //TmpSalesIncRec.DELETEALL ;
                MonthSaleIncRec.RESET;
                MonthSaleIncRec.SETFILTER(Year, '%1', SalesRecSetup."Current Salary Year");
                MonthSaleIncRec.SETFILTER(Month, '%1', SalesRecSetup."Current Salary Month");
                MonthSaleIncRec.SETRANGE("Field Type", MonthSaleIncRec."Field Type"::Column);
                MonthSaleIncRec.SETFILTER("Field Name", '%1|%2', 'COLUMN6', 'COLUMN4');
                MonthSaleIncRec.DELETEALL;
            end;
        }
        dataitem(CurrencyTotals; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(CurrNo; Number = 1)
            {
            }
            column(TempCurrCode; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE6RemAmt; AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE1RemAmt; AgedCustLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE2RemAmt; AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE3RemAmt; AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE4RemAmt; AgedCustLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE5RemAmt; AgedCustLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(CurrSpecificationCptn; CurrSpecificationCptnLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempCurrency2.NEXT = 0 THEN
                        CurrReport.BREAK;

                CLEAR(AgedCustLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF TempCurrencyAmount.Date <> 99991231D THEN
                            AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        ELSE
                            AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    UNTIL TempCurrencyAmount.NEXT = 0;
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
                    field(AgedAsOf; EndingDate)
                    {
                        Caption = 'Aged As Of';
                    }
                    field(Agingby; AgingBy)
                    {
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                    }
                    field(AmountsinLCY; PrintAmountInLCY)
                    {
                        Caption = 'Print Amounts in LCY';
                        Visible = false;
                    }
                    field(OnlyCusPostGrp; OnlyCusPostGrp)
                    {
                        Caption = 'Only Customer Posting Group';
                        Editable = false;
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        Caption = 'Print Details';
                        Visible = false;
                    }
                    field(HeadingType; HeadingType)
                    {
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                    }
                    field(perCustomer; NewPagePercustomer)
                    {
                        Caption = 'New Page per Customer';
                        Visible = false;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF EndingDate = 0D THEN
                EndingDate := WORKDATE;
            PrintToExcel := FALSE;
            OnlyCusPostGrp := TRUE;
            PrintAmountInLCY := TRUE;
        end;
    }

    labels
    {
        BalanceCaption = 'Balance';
    }

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;

        GLSetup.GET;

        CalcDates;
        CreateHeadings;


        PageGroupNo := 1;
        NextPageGroupNo := 1;
        CustFilterCheck := (CustFilter <> 'No.');
    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        CustLedgEntryEndingDate: Record "Cust. Ledger Entry";
        TotalCustLedgEntry: array[5] of Record "Cust. Ledger Entry";
        BUWiseCusLdgrEntry: array[5] of Record "Cust. Ledger Entry";
        GrandTotalCustLedgEntry: array[5] of Record "Cust. Ledger Entry";
        AgedCustLedgEntry: array[6] of Record "Cust. Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        SPCode: Record "Salesperson/Purchaser";
        CustFilter: Text[250];
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        OnlyCusPostGrp: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        Text008: Label 'All Amounts in LCY';
        CusPostGroup: Code[10];
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        PrintToExcel: Boolean;
        Text011: Label 'Data';
        Text012: Label 'Aged Accounts Receivable';
        Text013: Label 'Company Name';
        Text014: Label 'Report No.';
        Text015: Label 'Report Name';
        Text016: Label 'User ID';
        Text017: Label 'Date';
        Text018: Label 'Customer Filters';
        Text019: Label 'Cust. Ledger Entry Filters';
        CustFilterCheck: Boolean;
        Text032: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        AgedAccReceivableCptnLbl: Label 'Aged Accounts Receivable';
        CurrReportPageNoCptnLbl: Label 'Page';
        AllAmtinLCYCptnLbl: Label 'All Amounts in LCY';
        AgedOverdueAmtCptnLbl: Label 'Aged Overdue Amounts';
        CLEEndDateAmtLCYCptnLbl: Label 'Original Amount ';
        CLEEndDateDueDateCptnLbl: Label 'Due Date';
        CLEEndDateDocNoCptnLbl: Label 'Document No.';
        CLEEndDatePstngDateCptnLbl: Label 'Posting Date';
        CLEEndDateDocTypeCptnLbl: Label 'Document Type';
        OriginalAmtCptnLbl: Label 'Currency Code';
        TotalLCYCptnLbl: Label 'Total (LCY)';
        CurrSpecificationCptnLbl: Label 'Currency Specification';
        TotPayAmt: Decimal;
        TotPayAmtLCY: Decimal;
        CusPostGrpTotPayAmt: Decimal;
        CusPostGrpTotPayAmtLCY: Decimal;
        GrandTotPayAmt: Decimal;
        GrandTotPayAmtLCY: Decimal;
        TotPDAmt: Decimal;
        GrandTotPDAmt: Decimal;
        SalesAmt: Decimal;
        TotSalesAmt: Decimal;
        RemaningAmount2: Decimal;
        BalanceTotal: Decimal;
        DateWiseTotal: Decimal;
        VAR90Amt: Decimal;
        CurrYear: Integer;
        CurrMonth: Integer;
        VAR120Amt: Decimal;

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        EVALUATE(PeriodLength2, STRSUBSTNO(Text032, PeriodLength));
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := EndingDate + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        END;
        PeriodStartDate[i] := 0D;

        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            HeaderText[1] := Text000;
            i := 2;
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType = HeadingType::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        END;
        IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1 %2', Text001, PeriodStartDate[i - 1])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry")
    var
        Currency: Record Currency;
    begin
        WITH TempCustLedgEntry DO BEGIN
            IF GET(CustLedgEntry."Entry No.") THEN
                EXIT;
            TempCustLedgEntry := CustLedgEntry;
            INSERT;
            IF PrintAmountInLCY THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF TempCurrency.GET('') AND ("Currency Code" = GLSetup."LCY Code") THEN
                EXIT;
            IF TempCurrency.GET(GLSetup."LCY Code") AND ("Currency Code" = '') THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT;
        END;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF Date IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        IF b <> 0 THEN
            EXIT(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        IF TempCurrency2.INSERT THEN;
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalCustLedgEntry) DO BEGIN
                "Currency Code" := CurrencyCode;
                Date := PeriodStartDate[i];
                IF FIND THEN BEGIN
                    Amount := Amount + TotalCustLedgEntry[i]."Remaining Amount";
                    MODIFY;
                END ELSE BEGIN
                    "Currency Code" := CurrencyCode;
                    Date := PeriodStartDate[i];
                    Amount := TotalCustLedgEntry[i]."Remaining Amount";
                    INSERT;
                END;
            END;
            "Currency Code" := CurrencyCode;
            Date := 99991231D;
            IF FIND THEN BEGIN
                Amount := Amount + TotalCustLedgEntry[1].Amount;
                MODIFY;
            END ELSE BEGIN
                "Currency Code" := CurrencyCode;
                Date := 99991231D;
                Amount := TotalCustLedgEntry[1].Amount;
                INSERT;
            END;
        END;
    end;


    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewPagePercust: Boolean; NewPrintToExcel: Boolean)
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePercustomer := NewPagePercust;
        PrintToExcel := NewPrintToExcel;
    end;


    procedure CustPostGroup(CusGrpCode: Code[10])
    var
        CusRec: Record Customer;
    begin
        TotPDAmt := 0;
        SalesAmt := 0;
        CusRec.RESET;
        CusRec.SETRANGE("Customer Posting Group", CusGrpCode);
        IF CusRec.FINDSET THEN
            REPEAT
                CusRec.CALCFIELDS("Sales (LCY)", "PD Check Amount");
                TotPDAmt := TotPDAmt + CusRec."PD Check Amount";
                GrandTotPDAmt := GrandTotPDAmt + CusRec."PD Check Amount";
                SalesAmt := SalesAmt + CusRec."Sales (LCY)";
                TotSalesAmt := TotSalesAmt + CusRec."Sales (LCY)";
            UNTIL CusRec.NEXT = 0;
    end;

    local procedure CreateDebtorEntry(PassYear: Integer; PassMonth: Integer; PassCustLedEnty: Record "Cust. Ledger Entry")
    var
        vMonthSalesInc: Record "Monthly Sales Incentive";
        DrColumn: Text[8];
        IncColumn: Text[8];
    begin
        DrColumn := 'COLUMN4';
        IncColumn := 'COLUMN5';

        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', PassYear);
        vMonthSalesInc.SETFILTER(Month, '%1', PassMonth);
        vMonthSalesInc.SETFILTER("Global Dimension 1 Code", PassCustLedEnty."Global Dimension 1 Code");
        vMonthSalesInc.SETFILTER("Salesperson Code", PassCustLedEnty."Salesperson Code");
        vMonthSalesInc.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETFILTER("Field Name", DrColumn);
        IF vMonthSalesInc.FINDFIRST THEN BEGIN
            vMonthSalesInc."Field Value" += VAR90Amt;
            vMonthSalesInc.MODIFY;
        END ELSE BEGIN
            vMonthSalesInc.INIT;
            vMonthSalesInc.Year := PassYear;
            vMonthSalesInc.Month := PassMonth;
            vMonthSalesInc."Global Dimension 1 Code" := PassCustLedEnty."Global Dimension 1 Code";
            vMonthSalesInc."Salesperson Code" := PassCustLedEnty."Salesperson Code";
            vMonthSalesInc."Field Type" := vMonthSalesInc."Field Type"::Column;
            vMonthSalesInc."Field Name" := DrColumn;
            vMonthSalesInc."Field Value" := VAR90Amt;
            vMonthSalesInc.INSERT;
        END;

        DrColumn := 'COLUMN6';
        IncColumn := 'COLUMN7';

        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', PassYear);
        vMonthSalesInc.SETFILTER(Month, '%1', PassMonth);
        vMonthSalesInc.SETFILTER("Global Dimension 1 Code", PassCustLedEnty."Global Dimension 1 Code");
        vMonthSalesInc.SETFILTER("Salesperson Code", PassCustLedEnty."Salesperson Code");
        vMonthSalesInc.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETFILTER("Field Name", DrColumn);
        IF vMonthSalesInc.FINDFIRST THEN BEGIN
            vMonthSalesInc."Field Value" += VAR120Amt;
            vMonthSalesInc.MODIFY;
        END ELSE BEGIN
            vMonthSalesInc.INIT;
            vMonthSalesInc.Year := PassYear;
            vMonthSalesInc.Month := PassMonth;
            vMonthSalesInc."Global Dimension 1 Code" := PassCustLedEnty."Global Dimension 1 Code";
            vMonthSalesInc."Salesperson Code" := PassCustLedEnty."Salesperson Code";
            vMonthSalesInc."Field Type" := vMonthSalesInc."Field Type"::Column;
            vMonthSalesInc."Field Name" := DrColumn;
            vMonthSalesInc."Field Value" := VAR120Amt;
            vMonthSalesInc.INSERT;
        END;
    end;
}

