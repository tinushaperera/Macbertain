report 50036 "Cost Allocation Management 4"
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
        AdjustDecimalPlaces;
        CheckSalesEntries;
        MESSAGE('Process Completed Succesfully !');
    end;

    trigger OnPreReport()
    var
        AccPeriod: Record "Accounting Period";
        ReCostAllactionJnl: Record "Gen. Journal Line";
        GenJnlLineRec: Record "Gen. Journal Line";
        GenJnlLine: Record "Gen. Journal Line";
        TempGenJnl1: Record "Gen. Journal Line" temporary;
        TempGenJnl: Record "Gen. Journal Line" temporary;
        JnlBatch: Record "Gen. Journal Batch";
        GLEntryRec: Record "G/L Entry";
        GLEntry: Record "G/L Entry";
        GLEntry1: Record "G/L Entry";
        GLAcount: Record "G/L Account";
        NoSerMag: Codeunit NoSeriesManagement;
        PreviosStratingDate: Date;
        BUICode: Code[15];
        BUICode2: Code[4];
        BUICode3: Code[4];
        BUICode4: Code[4];
        BUICode5: Code[4];
        DocNo: Code[15];
        SalesAmountTotal: Decimal;
        ReversEntry: Decimal;
        ReAllocation: Decimal;
        ReAllocationAdjustment: Decimal;
    begin
        //Before Process Delete Gen Journal Batch Data
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJnlLine.SETRANGE("Journal Batch Name", 'COST-MGT-C');
        GenJnlLine.DELETEALL;

        // Caculate Senrio 2 Amount And Insert Allocation Revesal Gen Journal Line
        AccPeriod.RESET;
        AccPeriod.SETRANGE("Cost Senario 4 Period", TRUE);
        AccPeriod.FINDLAST;
        StratingDate := CALCDATE('<-1M>', AccPeriod."Starting Date");
        EndingDate := CALCDATE('<-1D>', AccPeriod."Starting Date");


        DocNo := NoSerMag.GetNextNo('ALLOCATION', TODAY, FALSE);

        GLAcount.LOCKTABLE;
        GLAcount.RESET;
        GLAcount.SETRANGE("Cost Scenario 4", TRUE);
        GLAcount.FINDFIRST;
        REPEAT
            GLEntry.LOCKTABLE;
            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("Global Dimension 1 Code");
            GLEntry.SETRANGE("G/L Account No.", GLAcount."No.");
            GLEntry.SETRANGE("Posting Date", StratingDate, EndingDate);
            GLEntry.SETFILTER("Global Dimension 1 Code", 'DP22');
            GLEntry.SETRANGE("Global Dimension 2 Code", '');
            IF GLEntry.FINDFIRST THEN
                REPEAT
                    IF (BUICode <> GLEntry."G/L Account No.") THEN BEGIN
                        BUICode := GLEntry."G/L Account No.";
                        GLEntryRec.RESET;
                        GLEntryRec.SETCURRENTKEY("Global Dimension 1 Code");
                        GLEntryRec.SETRANGE("Posting Date", StratingDate, EndingDate);
                        GLEntryRec.SETRANGE("G/L Account No.", BUICode);
                        GLEntryRec.SETRANGE("Global Dimension 1 Code", 'DP22');
                        GLEntryRec.SETRANGE("Global Dimension 2 Code", '');
                        GLEntryRec.CALCSUMS(Amount);

                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJnlLine.SETRANGE("Journal Batch Name", 'COST-MGT-C');
                        IF GenJnlLine.FINDLAST THEN
                            LineNo := GenJnlLine."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        GenJnlLine.INIT;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name", 'COST-MGT-C');
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := EndingDate;
                        GenJnlLine."Document No." := DocNo;
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", BUICode);

                        IF GLEntryRec.Amount < 0 THEN
                            ReversEntry := GLEntryRec.Amount
                        ELSE
                            ReversEntry := GLEntryRec.Amount * -1;
                        GenJnlLine.VALIDATE(Amount, ReversEntry);
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", GLEntry."Global Dimension 1 Code");
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", GLEntry."Global Dimension 2 Code");
                        GenJnlLine.VALIDATE("Reason Code", 'ALC-REV');
                        GenJnlLine."Cost Mgt. Calculation" := TRUE;
                        GenJnlLine.INSERT(TRUE);
                        SalesAccountAllocation(GLEntryRec.Amount, EndingDate, DocNo, GLAcount."No."); // call to function

                    END;
                UNTIL GLEntry.NEXT = 0;
        UNTIL GLAcount.NEXT = 0;
        NoSerMag.GetNextNo('ALLOCATION', TODAY, TRUE);
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        StratingDate: Date;
        EndingDate: Date;
        LineNo: Decimal;

    local procedure SalesAccountAllocation(CostSenario2Amount: Decimal; EndingDate: Date; DocNo: Code[15]; AccNo: Code[10])
    var
        TempSalesGLEntry3: Record "G/L Entry" temporary;
        TempSalesGLEntry2: Record "G/L Entry" temporary;
        TempSalesGLEntry: Record "G/L Entry" temporary;
        GLAccount: Record "G/L Account";
        GLEntryRec: Record "G/L Entry";
        GLEntry: Record "G/L Entry";
        CalGLEntry: Record "G/L Entry";
        SalesBUCode: Code[5];
        SalesOprationCode: Code[5];
        CalGLEntryValue: Decimal;
        BUCodeValue: Decimal;
        BUWiseTotal: Decimal;
        Inx: Integer;
        Inxx: Integer;
    begin
        TempSalesGLEntry.DELETEALL;
        TempSalesGLEntry2.DELETEALL;
        TempSalesGLEntry3.DELETEALL;

        Inx := 1;
        Inxx := 1;
        GLAccount.RESET;
        GLAccount.SETRANGE("Debtors Acc", TRUE);
        GLAccount.FINDFIRST;
        REPEAT

            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
            GLEntry.SETRANGE("Posting Date", 0D, EndingDate);
            GLEntry.SETRANGE("G/L Account No.", GLAccount."No.");
            GLEntry.SETFILTER("Global Dimension 1 Code", 'BU1..BU8');
            GLEntry.SETFILTER("Global Dimension 2 Code", '<>%1', '');
            IF GLEntry.FINDFIRST THEN
                REPEAT
                    IF (SalesBUCode <> GLEntry."Global Dimension 1 Code") OR (SalesOprationCode <> GLEntry."Global Dimension 2 Code") THEN BEGIN
                        SalesBUCode := GLEntry."Global Dimension 1 Code";
                        SalesOprationCode := GLEntry."Global Dimension 2 Code";
                        TempSalesGLEntry.INIT;
                        TempSalesGLEntry."Entry No." := Inx;
                        TempSalesGLEntry."G/L Account No." := GLEntry."G/L Account No.";
                        TempSalesGLEntry."Global Dimension 1 Code" := SalesBUCode;
                        TempSalesGLEntry."Global Dimension 2 Code" := SalesOprationCode;
                        TempSalesGLEntry.INSERT(TRUE);
                        Inx := Inx + 1;
                    END;
                UNTIL GLEntry.NEXT = 0;
        UNTIL GLAccount.NEXT = 0;


        TempSalesGLEntry.RESET;
        TempSalesGLEntry.SETCURRENTKEY("Global Dimension 1 Code", "Global Dimension 2 Code");
        TempSalesGLEntry.FINDFIRST;
        REPEAT
            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
            GLEntry.SETRANGE("Posting Date", 0D, EndingDate);
            GLEntry.SETRANGE("G/L Account No.", TempSalesGLEntry."G/L Account No.");
            GLEntry.SETRANGE("Global Dimension 1 Code", TempSalesGLEntry."Global Dimension 1 Code");
            GLEntry.SETRANGE("Global Dimension 2 Code", TempSalesGLEntry."Global Dimension 2 Code");
            GLEntry.CALCSUMS(Amount);
            IF GLEntry.Amount > 0 THEN
                BUWiseTotal := GLEntry.Amount
            ELSE
                BUWiseTotal := 0;

            TempSalesGLEntry2.INIT;
            TempSalesGLEntry2."Entry No." := Inxx;
            TempSalesGLEntry2."Global Dimension 1 Code" := TempSalesGLEntry."Global Dimension 1 Code";
            TempSalesGLEntry2."Global Dimension 2 Code" := TempSalesGLEntry."Global Dimension 2 Code";
            TempSalesGLEntry2.Amount := BUWiseTotal;
            TempSalesGLEntry2.INSERT(TRUE);
            Inxx := Inxx + 1;

            IF BUWiseTotal > 0 THEN BEGIN
                TempSalesGLEntry3.INIT;
                TempSalesGLEntry3."Entry No." := Inx;
                TempSalesGLEntry3."Global Dimension 1 Code" := TempSalesGLEntry."Global Dimension 1 Code";
                TempSalesGLEntry3."Global Dimension 2 Code" := TempSalesGLEntry."Global Dimension 2 Code";
                TempSalesGLEntry3.Amount := BUWiseTotal;
                TempSalesGLEntry3.INSERT(TRUE);

            END;
            Inx := Inx + 1;
        UNTIL TempSalesGLEntry.NEXT = 0;

        TempSalesGLEntry.RESET;
        TempSalesGLEntry.FINDFIRST;
        REPEAT
            TempSalesGLEntry2.RESET;
            TempSalesGLEntry2.SETRANGE("Global Dimension 1 Code", TempSalesGLEntry."Global Dimension 1 Code");
            TempSalesGLEntry2.SETRANGE("Global Dimension 2 Code", TempSalesGLEntry."Global Dimension 2 Code");
            TempSalesGLEntry2.CALCSUMS(Amount);
            BUCodeValue := TempSalesGLEntry2.Amount;

            IF BUCodeValue > 0 THEN BEGIN
                GenJnlLine.SETRANGE("Journal Template Name", 'GENERAL');
                GenJnlLine.SETRANGE("Journal Batch Name", 'COST-MGT-C');
                IF GenJnlLine.FINDLAST THEN
                    LineNo := GenJnlLine."Line No." + 10000
                ELSE
                    LineNo := 10000;

                TempSalesGLEntry3.RESET;
                TempSalesGLEntry3.CALCSUMS(Amount);

                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name", 'GENERAL');
                GenJnlLine.VALIDATE("Journal Batch Name", 'COST-MGT-C');
                GenJnlLine."Line No." := LineNo;
                GenJnlLine.VALIDATE("Posting Date", EndingDate);
                GenJnlLine.VALIDATE("Document No.", DocNo);
                GenJnlLine.VALIDATE("Account No.", AccNo);
                GenJnlLine.VALIDATE(Amount, ((CostSenario2Amount / TempSalesGLEntry3.Amount) * TempSalesGLEntry2.Amount));
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", TempSalesGLEntry."Global Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", TempSalesGLEntry."Global Dimension 2 Code");
                GenJnlLine.VALIDATE("Reason Code", 'ORG-ALC');
                GenJnlLine.INSERT(TRUE);
            END;
        UNTIL TempSalesGLEntry.NEXT = 0;



    end;

    local procedure CheckSalesEntries()
    var
        AllocateGenJlLine: Record "Gen. Journal Line";
    begin
        /*GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name",'GENERAL');
        GenJnlLine.SETRANGE("Journal Batch Name",'COST-MGT-4');
        GenJnlLine.SETCURRENTKEY("Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        GenJnlLine.SETRANGE("Reason Code",'ALC-REV');
        IF GenJnlLine.FINDFIRST THEN
         REPEAT
           AllocateGenJlLine.RESET;
           AllocateGenJlLine.SETRANGE("Journal Template Name",'GENERAL');
           AllocateGenJlLine.SETRANGE("Journal Batch Name",'COST-MGT-4');
           AllocateGenJlLine.SETRANGE("Shortcut Dimension 1 Code",GenJnlLine."Shortcut Dimension 1 Code");
           AllocateGenJlLine.SETRANGE("Account No.",GenJnlLine."Account No.");
           AllocateGenJlLine.SETRANGE("Reason Code",'ORG-ALC');
           IF NOT AllocateGenJlLine.FINDFIRST THEN
             REPEAT
               GenJnlLine.DELETE;
             UNTIL AllocateGenJlLine.NEXT=0;
         UNTIL GenJnlLine.NEXT=0;*/

    end;

    local procedure AdjustDecimalPlaces()
    var
        TempSalesGLEntry: Record "G/L Entry" temporary;
        GenjnlLineRec: Record "Gen. Journal Line";
        GLAccount: Record "G/L Account";
        GLEntryRec: Record "G/L Entry";
        GLEntry: Record "G/L Entry";
        CalGLEntry: Record "G/L Entry";
        SalesBUCode: Code[5];
        SalesOprationCode: Code[5];
        CalGLEntryValue: Decimal;
        BUCodeValue: Decimal;
        BUWiseTotal: Decimal;
        AjustDecimal: Decimal;
        AjustDecimal2: Decimal;
        Inx: Integer;
    begin
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Batch Name", 'COST-MGT-C');
        GenJnlLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJnlLine.SETRANGE("Cost Mgt. Calculation", TRUE);
        GenJnlLine.FINDFIRST;
        REPEAT
            GenjnlLineRec.RESET;
            GenjnlLineRec.SETRANGE("Journal Batch Name", 'COST-MGT-C');
            GenjnlLineRec.SETRANGE("Journal Template Name", 'GENERAL');
            GenjnlLineRec.SETRANGE("Account No.", GenJnlLine."Account No.");
            GenjnlLineRec.SETRANGE("Cost Mgt. Calculation", FALSE);
            GenjnlLineRec.CALCSUMS(Amount);
            AjustDecimal := GenJnlLine.Amount + GenjnlLineRec.Amount;

            IF AjustDecimal <> 0 THEN BEGIN
                AjustDecimal2 := GenJnlLine.Amount - AjustDecimal;
                GenJnlLine.VALIDATE(GenJnlLine.Amount, AjustDecimal2);
                GenJnlLine.MODIFY;
            END;
        UNTIL GenJnlLine.NEXT = 0;
    end;
}

