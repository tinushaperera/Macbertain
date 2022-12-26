report 50048 "Settlement of Invoices"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SettlementofInvoices.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.")
                                WHERE("Document Type" = FILTER(Invoice));
            RequestFilterFields = "Customer No.", "Salesperson Code", "Customer Posting Group", "Document No.";
            column(Cust_No; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(Cus_Name; CusRec.Name)
            {
            }
            column(Sals_Rep; CusRec."Salesperson Code")
            {
            }
            column(Cust_Postin_Group; "Cust. Ledger Entry"."Customer Posting Group")
            {
            }
            column(Doc_Type; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(Doc_No; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(Posting_Date; FORMAT("Cust. Ledger Entry"."Posting Date"))
            {
            }
            column(Amt; "Cust. Ledger Entry"."Amount (LCY)")
            {
            }
            column(BuCode; "Cust. Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(Operation_Code; DimensionValue.Name)
            {
            }
            column(ComName; ComRec.Name)
            {
            }
            column(ComAdd; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(PhNo; ComRec."Phone No.")
            {
            }
            column(FxNo; ComRec."Fax No.")
            {
            }
            column(ComCty; ComRec.City)
            {
            }
            column(Filters; TxtFilters)
            {
            }
            dataitem(DataItem15; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(AppDocType; CusLedEntryApp."Document Type")
                {
                }
                column(AppExtNo; CusLedEntryApp."External Document No.")
                {
                }
                column(AppPostDate; FORMAT(CusLedEntryApp."Posting Date"))
                {
                }
                column(DocNo; CusLedEntryApp."Document No.")
                {
                }
                column(AppAmt; AppAmount)
                {
                }

                trigger OnAfterGetRecord()
                var
                    inx: Integer;
                begin
                    IF Number = 1 THEN BEGIN
                        IF NOT CusLedEntryApp.FINDSET(FALSE, FALSE) THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF CusLedEntryApp.NEXT = 0 THEN
                            CurrReport.BREAK;
                    AppAmount := 0;
                    DetCusLedEntry.SETRANGE("Document No.", CusLedEntryApp."Document No.");
                    IF DetCusLedEntry.FINDSET THEN BEGIN
                        REPEAT
                            AppAmount := AppAmount + DetCusLedEntry."Amount (LCY)";
                        UNTIL DetCusLedEntry.NEXT = 0;
                    END
                    ELSE BEGIN
                        CusLedEntryApp.CALCFIELDS("Amount (LCY)");
                        AppAmount := CusLedEntryApp."Amount (LCY)";
                    END
                end;
            }

            trigger OnAfterGetRecord()
            var
                CustMange: Codeunit "Get Apply Entries";
                inx: Integer;
            begin
                CusRec.GET("Customer No.");
                CLEAR(CusLedEntryApp);
                CALCFIELDS("Amount (LCY)");
                IF "Amount (LCY)" = 0 THEN
                    CurrReport.SKIP;

                GetApplyDetails.GetAppliedEntries("Cust. Ledger Entry", CusLedEntryApp);
                DetCusLedEntry.SETRANGE("Cust. Ledger Entry No.", "Entry No.");

                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, "Global Dimension 2 Code");
                IF DimensionValue.FINDFIRST THEN;
            end;

            trigger OnPostDataItem()
            var
                Inx: Integer;
            begin
            end;

            trigger OnPreDataItem()
            begin
                ComRec.GET;
                TxtFilters := GETFILTERS;
                DetCusLedEntry.RESET;
                DetCusLedEntry.SETRANGE("Entry Type", DetCusLedEntry."Entry Type"::Application);
                DetCusLedEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Document Type", "Document No.")
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CusRec: Record Customer;
        CusLedEntryApp: Record "Cust. Ledger Entry";
        ComRec: Record "Company Information";
        DetCusLedEntry: Record "Detailed Cust. Ledg. Entry";
        DimensionValue: Record "Dimension Value";
        GetApplyDetails: Codeunit "Get Apply Entries";
        TxtFilters: Text[100];
        AppAmount: Decimal;
}

