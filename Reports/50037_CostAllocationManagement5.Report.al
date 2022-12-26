report 50037 "Cost Allocation Management 5"
{
    ProcessingOnly = true;

    dataset
    {
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

    trigger OnPostReport()
    begin
        MESSAGE('Process Complete');
    end;

    trigger OnPreReport()
    var
        Dimenssion: Record "Dimension Value";
        ReCostAllactionJnl: Record "Gen. Journal Line";
        GenJnlLineRec: Record "Gen. Journal Line";
        GenJnlLine: Record "Gen. Journal Line";
        TempGenJnl1: Record "Gen. Journal Line" temporary;
        TempGenJnl: Record "Gen. Journal Line" temporary;
        TempGenJnl3: Record "Gen. Journal Line" temporary;
        TempGenJnl4: Record "Gen. Journal Line" temporary;
        JnlBatch: Record "Gen. Journal Batch";
        GLEntryRec: Record "G/L Entry";
        GLEntry: Record "G/L Entry";
        GLEntry1: Record "G/L Entry";
        GLAcount: Record "G/L Account";
        AccPeriod: Record "Accounting Period";
        NoSerMag: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        BUICode: Code[8];
        BUICode2: Code[4];
        BUICode3: Code[4];
        BUICode4: Code[4];
        BUICode5: Code[4];
        LineNo: Decimal;
        SalesAmountTotal: Decimal;
        ReversEntry: Decimal;
        ReAllocation: Decimal;
        ReAllocationAdjustment: Decimal;
        ReverseAmount: Decimal;
    begin
        // Caculate Senrio 3 Amount And Insert Gen Journal Line
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJnlLine.SETRANGE("Journal Batch Name", 'COST-MGT-D');
        GenJnlLine.DELETEALL;


        AccPeriod.RESET;
        AccPeriod.SETRANGE("Cost Senario 5 Period", TRUE);
        AccPeriod.FINDLAST;
        StratingDate := CALCDATE('<-1M>', AccPeriod."Starting Date");
        EndingDate := CALCDATE('<-1D>', AccPeriod."Starting Date");

        DocNo := NoSerMag.GetNextNo('ALLOCATION', TODAY, FALSE);

        TempGenJnl3.DELETEALL;
        TempGenJnl4.DELETEALL;
        GLAcount.LOCKTABLE;
        GLAcount.RESET;
        GLAcount.SETRANGE("Cost Scenario 5", TRUE);
        GLAcount.FINDFIRST;
        REPEAT

            GLEntry.LOCKTABLE;
            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("Global Dimension 1 Code");
            GLEntry.SETRANGE("G/L Account No.", GLAcount."No.");
            GLEntry.SETRANGE("Posting Date", StratingDate, EndingDate);
            GLEntry.SETRANGE("Global Dimension 1 Code", 'DP23');
            GLEntry.SETRANGE("Global Dimension 2 Code", '');
            IF GLEntry.FINDFIRST THEN
                REPEAT

                    IF (BUICode <> GLEntry."G/L Account No.") THEN BEGIN
                        BUICode := GLEntry."G/L Account No.";
                        GLEntryRec.RESET;
                        GLEntryRec.SETCURRENTKEY("Global Dimension 1 Code");
                        GLEntryRec.SETRANGE("Posting Date", StratingDate, EndingDate);
                        GLEntryRec.SETRANGE("G/L Account No.", BUICode);
                        GLEntryRec.SETRANGE("Global Dimension 1 Code", 'DP23');
                        GLEntryRec.SETRANGE("Global Dimension 2 Code", '');
                        GLEntryRec.CALCSUMS(Amount);

                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJnlLine.SETRANGE("Journal Batch Name", 'COST-MGT-D');
                        IF GenJnlLine.FINDLAST THEN
                            LineNo := GenJnlLine."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        GenJnlLine.INIT;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name", 'COST-MGT-D');
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine.VALIDATE("Posting Date", EndingDate);
                        GenJnlLine.VALIDATE("Document No.", DocNo);
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", BUICode);

                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", GLEntry."Global Dimension 1 Code");
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", GLEntry."Global Dimension 2 Code");

                        SalesAmountTotal := ROUND((GLEntryRec.Amount / 3), 0.01, '=');


                        IF GenJnlLineRec.Amount < 0 THEN
                            ReversEntry := GLEntryRec.Amount
                        ELSE
                            ReversEntry := GLEntryRec.Amount * -1;

                        GenJnlLine.VALIDATE(Amount, ReversEntry);
                        GenJnlLine.VALIDATE("Reason Code", 'ALC-REV');
                        GenJnlLine.INSERT(TRUE);

                        TempGenJnl3.INIT;
                        TempGenJnl3."Journal Template Name" := 'GENERAL';
                        TempGenJnl3."Journal Batch Name" := 'COST-MGT-D';
                        TempGenJnl3."Line No." := LineNo;
                        TempGenJnl3."Posting Date" := EndingDate;
                        TempGenJnl3."Document No." := DocNo;
                        TempGenJnl3.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        TempGenJnl3."Account No." := BUICode;
                        TempGenJnl3.VALIDATE("Shortcut Dimension 1 Code", GLEntry."Global Dimension 1 Code");
                        TempGenJnl3.VALIDATE("Shortcut Dimension 2 Code", GLEntry."Global Dimension 2 Code");
                        TempGenJnl3.VALIDATE(Amount, GLEntryRec.Amount);
                        TempGenJnl3.INSERT;

                        // Dimenssion.RESET;
                        Dimenssion.SETFILTER(Dimenssion.Code, 'BU1..BU3');
                        IF Dimenssion.FINDFIRST THEN
                            REPEAT
                                TempGenJnl4.INIT;

                                TempGenJnl4."Line No." := TempGenJnl4."Line No." + 10000;
                                TempGenJnl4."Account No." := GLAcount."No.";
                                TempGenJnl4."Shortcut Dimension 1 Code" := Dimenssion.Code;
                                TempGenJnl4.Amount := SalesAmountTotal;
                                TempGenJnl4.INSERT;
                            UNTIL Dimenssion.NEXT = 0;
                    END;
                UNTIL GLEntry.NEXT = 0;

        UNTIL GLAcount.NEXT = 0;



        // Insert Allocation Entry To Gen Journal Line
        TempGenJnl3.RESET;
        TempGenJnl3.SETRANGE("Journal Template Name", 'GENERAL');
        TempGenJnl3.SETRANGE("Journal Batch Name", 'COST-MGT-D');
        IF TempGenJnl3.FINDFIRST THEN BEGIN
            REPEAT
                TempGenJnl4.RESET;
                TempGenJnl4.SETRANGE("Account No.", TempGenJnl3."Account No.");
                IF TempGenJnl4.FINDFIRST THEN BEGIN
                    REPEAT
                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJnlLine.SETRANGE("Journal Batch Name", 'COST-MGT-D');
                        IF GenJnlLine.FINDLAST THEN
                            LineNo := GenJnlLine."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        GenJnlLine.INIT;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name", 'COST-MGT-D');
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine.VALIDATE("Posting Date", EndingDate);
                        GenJnlLine.VALIDATE("Document No.", DocNo);
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", TempGenJnl3."Account No.");
                        IF (TempGenJnl4.Amount <> 0) THEN
                            /////////////////////////


                            GenJnlLine.Amount := TempGenJnl4.Amount;
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code", TempGenJnl4."Shortcut Dimension 1 Code");
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code", TempGenJnl4."Shortcut Dimension 2 Code");
                        GenJnlLine.VALIDATE("Reason Code", 'ORG-ALC');
                        GenJnlLine."Cost Mgt. Calculation" := TRUE;
                        GenJnlLine."Cost Mgt. Ration" := TempGenJnl4."Cost Mgt. Ration";
                        GenJnlLine.INSERT(TRUE);
                    UNTIL TempGenJnl4.NEXT = 0;
                END;
                //Re Adjust Decimal Places .
                GenJnlLineRec.RESET;
                GenJnlLineRec.SETRANGE("Journal Template Name", 'GENERAL');
                GenJnlLineRec.SETRANGE("Journal Batch Name", 'COST-MGT-D');
                GenJnlLineRec.SETRANGE("Account No.", TempGenJnl3."Account No.");
                GenJnlLineRec.SETRANGE("Cost Mgt. Calculation", FALSE);
                GenJnlLineRec.CALCSUMS(Amount);
                ReverseAmount := GenJnlLineRec.Amount * -1;


                ReCostAllactionJnl.RESET;
                ReCostAllactionJnl.SETRANGE("Journal Template Name", 'GENERAL');
                ReCostAllactionJnl.SETRANGE("Journal Batch Name", 'COST-MGT-D');
                ReCostAllactionJnl.SETRANGE("Account No.", TempGenJnl3."Account No.");
                ReCostAllactionJnl.SETRANGE("Cost Mgt. Calculation", TRUE);
                IF ReCostAllactionJnl.CALCSUMS(Amount) THEN;
                ReAllocation := ReverseAmount - ReCostAllactionJnl.Amount;

                ReCostAllactionJnl.RESET;
                ReCostAllactionJnl.SETRANGE("Journal Template Name", 'GENERAL');
                ReCostAllactionJnl.SETRANGE("Journal Batch Name", 'COST-MGT-D');
                ReCostAllactionJnl.SETRANGE("Account No.", TempGenJnl3."Account No.");
                ReCostAllactionJnl.SETRANGE("Cost Mgt. Calculation", TRUE);
                IF ReCostAllactionJnl.FINDLAST THEN;
                ///  ReCostAllactionJnl.CALCSUMS(Amount);



                IF ReAllocation <> 0 THEN BEGIN
                    IF ReAllocation > 0 THEN BEGIN
                        ReAllocationAdjustment := ReCostAllactionJnl.Amount + ReAllocation;

                        ReCostAllactionJnl.VALIDATE(Amount, ReAllocationAdjustment);
                        IF ReCostAllactionJnl.MODIFY(TRUE) THEN;
                    END
                    ELSE BEGIN
                        ReAllocationAdjustment := ReCostAllactionJnl.Amount + ReAllocation;

                        ReCostAllactionJnl.VALIDATE(Amount, ReAllocationAdjustment);
                        IF ReCostAllactionJnl.MODIFY(TRUE) THEN;
                    END;
                END;

                GenJnlLineRec.RESET;
                GenJnlLineRec.SETRANGE("Journal Template Name", 'GENERAL');
                GenJnlLineRec.SETRANGE("Journal Batch Name", 'COST-MGT-D');
                GenJnlLineRec.SETRANGE("Cost Mgt. Calculation", TRUE);
                IF GenJnlLineRec.FINDSET THEN;
                REPEAT
                    GenJnlLineRec."Cost Mgt. Calculation" := FALSE;
                    IF GenJnlLineRec.MODIFY THEN;
                UNTIL GenJnlLineRec.NEXT = 0;
            UNTIL TempGenJnl3.NEXT = 0;


        END;
        NoSerMag.GetNextNo('ALLOCATION', TODAY, TRUE);
    end;

    var
        StratingDate: Date;
        EndingDate: Date;
}

