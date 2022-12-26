report 50078 "Collection Age"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // //A Running Sum of remaining amount is based on Grouping of Customer, If Grouping is changed , change the running Sum and sorting accordingly.
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CollectionAge.rdl';


    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Payment | ' '),
                                      Reversed = filter(false),
                                      "Bal. Account Type" = FILTER("Bank Account" | "G/L Account"),
                                      "Source Code" = FILTER('CASHRECJNL' | 'PD-Cheque'));
            RequestFilterFields = "Posting Date";
            column(Date; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(receipt_no; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(cheque_no; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(customer_no; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(customer_name; CusRec.Name)
            {
            }
            column(posting_group; CusRec."Customer Posting Group")
            {
            }
            column(amountLCY; "Amount (LCY)")
            {
            }
            column(Payment_code; ValFormat)
            {
            }
            column(DocDate; CusLegEntRec."Document Date")
            {
            }
            column(com_name; UPPERCASE(ComRec.Name))
            {
            }
            column(com_address; ComRec.Address)
            {
            }
            column(com_city; ComRec.City)
            {
            }
            column(com_phone; ComRec."Phone No.")
            {
            }
            column(com_fax; ComRec."Fax No.")
            {
            }
            column(TotalAmt; Subtotal)
            {
            }
            column(RemainingAmt; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(RunRemainingAmt; RunRemainingAmt)
            {
            }
            column(OriginalAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Original Amt. (LCY)")
            {
            }
            column(ChequeNo; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(TempReceiptNo; "Cust. Ledger Entry"."Temp. Receipt No.")
            {
            }
            column(POM; "Cust. Ledger Entry"."Payment Method Code")
            {
            }
            dataitem(DataItem20; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(TempDocType; CusLedEntryApp."Document Type")
                {
                }
                column(TempDocNo; CusLedEntryApp."Document No.")
                {
                }
                column(TempDocDate; CusLedEntryApp."Document Date")
                {
                }
                column(GDim1Code; CusLedEntryApp."Global Dimension 1 Code")
                {
                }
                column(GDIm2Code; CusLedEntryApp."Global Dimension 2 Code")
                {
                }
                column(SP_code; CusLedEntryApp."Salesperson Code")
                {
                }
                column(DateRage; Range)
                {
                }
                column(Variance; Variance)
                {
                }
                column(PayAppAmt; PayAmount)
                {
                }
                column(DisAmt; DisAmount)
                {
                }
                column(AdvAmt; AdvAmt)
                {
                }
                column(RangeAmt1; RangeAmt[1])
                {
                }
                column(RangeAmt2; RangeAmt[2])
                {
                }
                column(RangeAmt3; RangeAmt[3])
                {
                }
                column(RangeAmt4; RangeAmt[4])
                {
                }
                column(NoofDays; FORMAT(NoofDays))
                {
                }

                trigger OnAfterGetRecord()
                var
                    PayTermCode: Record "Payment Terms";
                    StDate: Date;
                    EdDate: Date;
                    DelCusLedEntry: Record "Detailed Cust. Ledg. Entry";
                    SalesInvLine: Record "Sales Invoice Line";
                begin
                    IF NOT DirectPay THEN BEGIN
                        IF CusLedEntryApp.FINDFIRST THEN
                            CusLedEntryApp.NEXT(Inx);
                        Inx := Inx + 1;
                        IF CusLedEntryApp."Document Date" <> 0D THEN //RJ
                            Range := "Cust. Ledger Entry"."Posting Date" - CusLedEntryApp."Document Date";
                        //
                        Variance := 0;
                        IF PayTermCode.GET(CusRec."Payment Terms Code") THEN BEGIN
                            StDate := CALCDATE('<' + FORMAT(PayTermCode."Due Date Calculation") + '>', TODAY);
                            EdDate := CALCDATE('<' + FORMAT(Range) + 'D>', TODAY);
                            //Variance := EdDate - StDate;
                            Variance := StDate - EdDate;
                        END;
                        PayAmount := 0;
                        DelCusLedEntry.RESET;
                        DelCusLedEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type",
                            "Document Type", "Document No.");
                        DelCusLedEntry.SETRANGE("Cust. Ledger Entry No.", CusLedEntryApp."Entry No.");
                        DelCusLedEntry.SETRANGE("Entry Type", DelCusLedEntry."Entry Type"::Application);
                        DelCusLedEntry.SETRANGE("Document Type", DelCusLedEntry."Document Type"::Payment);
                        DelCusLedEntry.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                        DelCusLedEntry.CALCSUMS("Amount (LCY)");
                        PayAmount := DelCusLedEntry."Amount (LCY)";

                        //
                        DisAmount := 0;
                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", CusLedEntryApp."Document No.");
                        SalesInvLine.CALCSUMS("Line Discount Amount");
                        DisAmount := SalesInvLine."Line Discount Amount";
                    END
                    ELSE BEGIN
                        Range := 0;
                        Variance := 0;
                        DisAmount := 0;
                        PayAmount := "Cust. Ledger Entry"."Amount (LCY)";
                        ;
                    END;

                    AdvAmt := 0;

                    FOR i := 1 TO 4 DO RangeAmt[i] := 0;

                    CASE Range OF
                        0:
                            BEGIN
                                AdvAmt := PayAmount;
                            END;
                        1 .. 30:
                            BEGIN
                                RangeAmt[1] := PayAmount;
                            END;
                        31 .. 60:
                            BEGIN
                                RangeAmt[2] := PayAmount;
                            END;
                        61 .. 90:
                            BEGIN
                                RangeAmt[3] := PayAmount;
                            END;
                        ELSE BEGIN
                            RangeAmt[4] := PayAmount;
                        END;
                    END;
                    IF CusLedEntryApp."Document Date" <> 0D THEN
                        NoofDays := "Cust. Ledger Entry"."Posting Date" - CusLedEntryApp."Document Date";
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT DirectPay THEN BEGIN
                        SETRANGE(Number, 1, CusLedEntryApp.COUNT);
                        Inx := 0;
                    END
                    ELSE
                        SETRANGE(Number, 1, 1);
                end;
            }

            trigger OnAfterGetRecord()
            var
                PayTermCode: Record "Payment Terms";
                NewString: Code[20];
                CustMange: Codeunit "My Notification 1";
                GetApplyEntries: Codeunit "Get Apply Entries";
            begin
                /*
                TemCusLedEntry.DELETEALL;
                CLEAR(TemCusLedEntry);
                CusLegEntRec.RESET;
                CusLegEntRec.SETRANGE("Closed by Entry No.","Entry No.");
                IF CusLegEntRec.FINDSET THEN
                REPEAT
                  TemCusLedEntry.TRANSFERFIELDS(CusLegEntRec);
                  TemCusLedEntry.INSERT;
                UNTIL CusLegEntRec.NEXT =0;
                */
                IF CusRec.GET("Customer No.") THEN;

                IF CusRec."No." = RunCustNo THEN
                    RunRemainingAmt += "Cust. Ledger Entry"."Remaining Amount"
                ELSE BEGIN
                    RunCustNo := CusRec."No.";
                    RunRemainingAmt := "Cust. Ledger Entry"."Remaining Amount";
                END;


                GetApplyEntries.GetAppliedEntries("Cust. Ledger Entry", CusLedEntryApp);
                ValFormat := '';
                IF PayTermCode.GET(CusRec."Payment Terms Code") THEN
                    ValFormat := DELCHR(FORMAT(PayTermCode."Due Date Calculation"), '=', 'D');
                Subtotal := Subtotal + "Amount (LCY)";
                IF CusLedEntryApp.COUNT = 0 THEN
                    DirectPay := TRUE
                ELSE
                    DirectPay := FALSE;

            end;

            trigger OnPreDataItem()
            begin
                IF ComRec.GET THEN;
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
        CusLegEntRec: Record "Cust. Ledger Entry";
        PaymentRec: Record "Payment Terms";
        ValFormat: Text[10];
        Range: Integer;
        Variance: Integer;
        ComRec: Record "Company Information";
        Subtotal: Decimal;
        Postingdate: Date;
        NoofDays: Integer;
        TemCusLedEntry: Record "Cust. Ledger Entry" temporary;
        Inx: Integer;
        CusLedEntryApp: Record "Cust. Ledger Entry";
        PayAmount: Decimal;
        DisAmount: Decimal;
        DirectPay: Boolean;
        AdvAmt: Decimal;
        RangeAmt: array[4] of Decimal;
        i: Integer;
        RunCustNo: Code[20];
        RunRemainingAmt: Decimal;
}

