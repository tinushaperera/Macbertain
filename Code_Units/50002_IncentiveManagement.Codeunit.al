codeunit 50002 "Incentive Management"
{
    TableNo = 50008;

    trigger OnRun()
    var
        NoofDays: Integer;
        SourceSetupRec: Record "Source Code Setup";
        SalesperH: Record "Salesperson Hierarchy";
        CollectionDetAudit: Record "Collection Details Entry";
    begin
        InitVariables(Rec.Year, Rec.Month);

        //<20180418 debugging
        CLEAR(CollectionDetAudit);
        CollectionDetAudit.DELETEALL;
        //>

        TmpSalesIncRec.UpdateMonthlyIncentive(Curryear, CurrMonth);

        TmpSalesIncRec.DELETEALL;
        MonthSaleIncRec.SETFILTER(Year, '%1', Curryear);
        MonthSaleIncRec.SETFILTER(Month, '%1', CurrMonth);
        MonthSaleIncRec.SETFILTER("Field Name", '<>%1&<>%2', 'COLUMN6', 'COLUMN4');
        IF MonthSaleIncRec.FINDSET THEN
            MonthSaleIncRec.DELETEALL;

        SalesperH.RESET;
        SalesperH.SETFILTER("Cal. Year", '%1', Curryear);
        SalesperH.SETFILTER("Cal. Month", '%1', CurrMonth);
        SalesperH.SETFILTER("Reporting To Code", '');
        IF SalesperH.FINDSET THEN
            REPEAT
                IF SalesperH."Reporting To Code" = '' THEN
                    GetTree(SalesperH);
            UNTIL SalesperH.NEXT = 0;

        CreateExcelSheet;
    end;

    var
        Salesperson: Record "Salesperson/Purchaser";
        TmpSalesIncRec: Record "Sales Incentives" temporary;
        BUProdCat: Record "Reference Data";
        [InDataSet]
        Curryear: Integer;
        [InDataSet]
        CurrMonth: Integer;
        SalesTargetRec: Record "Sales Targets";
        MonthSaleIncRec: Record "Monthly Sales Incentive";
        SalesInvLineRec: Record "Sales Invoice Line";
        SalesCrMemoLineRec: Record "Sales Cr.Memo Line";
        StartDate: Date;
        EndDate: Date;
        DetCustLedRec: Record "Detailed Cust. Ledg. Entry";
        CustLedRec: Record "Cust. Ledger Entry";
        DetCustLedRec2: Record "Detailed Cust. Ledg. Entry";
        CustLedRec2: Record "Cust. Ledger Entry";
        GenLdgrRec: Record "G/L Entry";
        SalesPerRec: Record "Salesperson/Purchaser";
        SalesPerTmp: Record "Salesperson/Purchaser" temporary;
        EmpRec: Record Employee;
        SalesPerTmp2: Record "Salesperson/Purchaser" temporary;
        amt90: Decimal;
        amt120: Decimal;

    local procedure InitVariables(Year: Integer; Month: Integer)
    begin
        Curryear := Year;
        CurrMonth := Month;
        StartDate := DMY2DATE(1, CurrMonth, Curryear);
        IF CurrMonth = 12 THEN BEGIN
            EndDate := DMY2DATE(1, 1, Curryear + 1) - 1;
        END
        ELSE BEGIN
            EndDate := DMY2DATE(1, CurrMonth + 1, Curryear) - 1;
        END;
    end;

    local procedure GetSalesIncentive(Year: Integer; GlobalDim1: Code[20]; ProdCatCode: Code[30]; Desig: Code[30]; AchievePer: Decimal; Month: Integer): Decimal
    var
        SalesIncRec: Record "Sales Incentives";
    begin
        SalesIncRec.RESET;
        SalesIncRec.SETFILTER(Year, '%1', Year);
        SalesIncRec.SETFILTER(Month, '%1', Month);
        SalesIncRec.SETFILTER("Global Dimension 1 Code", GlobalDim1);
        SalesIncRec.SETFILTER("Icentive Type", '%1', SalesIncRec."Icentive Type"::Sales);
        SalesIncRec.SETFILTER(Designation, Desig);
        SalesIncRec.SETFILTER("BU Product Category", ProdCatCode);
        IF SalesIncRec.FINDFIRST THEN BEGIN
            IF AchievePer < 75 THEN
                EXIT(0)
            ELSE
                IF AchievePer < 85 THEN
                    EXIT(SalesIncRec."Rate 1")
                ELSE
                    IF AchievePer < 100 THEN
                        EXIT(SalesIncRec."Rate 2")
                    ELSE
                        IF AchievePer < 115 THEN
                            EXIT(SalesIncRec."Rate 3")
                        ELSE
                            EXIT(SalesIncRec."Rate 4");
        END
        ELSE
            EXIT(0);
    end;

    local procedure WriteCollectionEntry(Days: Integer; InitCustLedRec: Record "Cust. Ledger Entry"; pDetCustLedRec: Record "Detailed Cust. Ledg. Entry")
    var
        vMonthSalesInc: Record "Monthly Sales Incentive";
        vAmt1: Decimal;
        vAmt2: Decimal;
        vAmt3: Decimal;
        vAmt4: Decimal;
    begin
        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', Curryear);
        vMonthSalesInc.SETFILTER(Month, '%1', CurrMonth);
        vMonthSalesInc.SETFILTER("Global Dimension 1 Code", InitCustLedRec."Global Dimension 1 Code");
        vMonthSalesInc.SETFILTER("Salesperson Code", InitCustLedRec."Salesperson Code");
        vMonthSalesInc.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETFILTER("Field Name", 'COLUMN1');
        IF vMonthSalesInc.FINDFIRST THEN BEGIN
            vMonthSalesInc."Field Value" += GetCollectionIncentive(Days, InitCustLedRec, pDetCustLedRec, vAmt1, vAmt2, vAmt3, vAmt4);
            vMonthSalesInc."Amount 1" += vAmt1;
            vMonthSalesInc."Amount 2" += vAmt2;
            vMonthSalesInc."Amount 3" += vAmt3;
            vMonthSalesInc."Amount 4" += vAmt4;
            vMonthSalesInc.MODIFY;
        END ELSE BEGIN
            vMonthSalesInc.INIT;
            vMonthSalesInc.Year := Curryear;
            vMonthSalesInc.Month := CurrMonth;
            vMonthSalesInc."Global Dimension 1 Code" := InitCustLedRec."Global Dimension 1 Code";
            vMonthSalesInc."Salesperson Code" := InitCustLedRec."Salesperson Code";
            vMonthSalesInc."Field Type" := vMonthSalesInc."Field Type"::Column;
            vMonthSalesInc."Field Name" := 'COLUMN1';
            vMonthSalesInc."Field Value" := GetCollectionIncentive(Days, InitCustLedRec, pDetCustLedRec, vAmt1, vAmt2, vAmt3, vAmt4);
            vMonthSalesInc."Amount 1" := vAmt1;
            vMonthSalesInc."Amount 2" := vAmt2;
            vMonthSalesInc."Amount 3" := vAmt3;
            vMonthSalesInc."Amount 4" := vAmt4;
            vMonthSalesInc.INSERT;
        END;
    end;

    local procedure GetCollectionIncentive(Days: Integer; InitCustLedRec: Record "Cust. Ledger Entry"; pDetCustLedRec: Record "Detailed Cust. Ledg. Entry"; var Amt1: Decimal; var Amt2: Decimal; var Amt3: Decimal; var Amt4: Decimal): Decimal
    var
        SalespersonRec: Record "Salesperson/Purchaser";
        SalesIncRec: Record "Sales Incentives";
        CollectAmt: Decimal;
        CollectionDetAudit: Record "Collection Details Entry";
    begin
        CollectAmt := ABS(ROUND(InitCustLedRec."Sales (LCY)" * pDetCustLedRec.Amount / InitCustLedRec."Amount (LCY)", 0.001));
        Amt1 := 0;
        Amt2 := 0;
        Amt3 := 0;
        Amt4 := 0;
        //<20180418 Debugging
        CollectionDetAudit.RESET;
        CollectionDetAudit.INIT;
        CollectionDetAudit."Entry No." := InitCustLedRec."Entry No.";
        CollectionDetAudit."Payment Det. Led. Enrty No." := pDetCustLedRec."Entry No.";
        CollectionDetAudit."Customer No." := InitCustLedRec."Customer No.";
        CollectionDetAudit."Posting Date" := InitCustLedRec."Posting Date";
        CollectionDetAudit."Document Type" := InitCustLedRec."Document Type";
        CollectionDetAudit."Document No." := InitCustLedRec."Document No.";
        CollectionDetAudit.Description := InitCustLedRec.Description;
        CollectionDetAudit.Amount := InitCustLedRec.Amount;
        CollectionDetAudit."Amount (LCY)" := InitCustLedRec."Amount (LCY)";
        CollectionDetAudit."Original Amt. (LCY)" := InitCustLedRec."Amount (LCY)";
        CollectionDetAudit."Sales (LCY)" := InitCustLedRec."Sales (LCY)";
        //CollectionDetAudit."Entry Type" := InitCustLedRec.
        CollectionDetAudit."Payment Cust. Led. Entry No." := pDetCustLedRec."Cust. Ledger Entry No.";
        CollectionDetAudit."Payment Amount" := pDetCustLedRec.Amount;
        CollectionDetAudit."Salesperson Code" := InitCustLedRec."Salesperson Code";
        CollectionDetAudit.Year := Curryear;
        CollectionDetAudit.Month := CurrMonth;
        CollectionDetAudit."Global Dimension 1 Code" := InitCustLedRec."Global Dimension 1 Code";
        CollectionDetAudit.CollectAmt := CollectAmt;
        CollectionDetAudit.INSERT;

        SalespersonRec.GET(InitCustLedRec."Salesperson Code");
        SalesIncRec.RESET;
        SalesIncRec.SETFILTER(Year, '%1', Curryear);
        SalesIncRec.SETFILTER(Month, '%1', CurrMonth);
        SalesIncRec.SETFILTER("Global Dimension 1 Code", InitCustLedRec."Global Dimension 1 Code");
        SalesIncRec.SETFILTER("Icentive Type", '%1', SalesIncRec."Icentive Type"::Collection);
        SalesIncRec.SETFILTER(Designation, SalespersonRec.Designation);
        IF SalesIncRec.FINDFIRST THEN BEGIN
            IF Days <= 0 THEN BEGIN
                Amt1 := 0;
                EXIT(0);
            END
            ELSE
                IF Days <= 30 THEN BEGIN
                    Amt2 := CollectAmt;
                    CollectionDetAudit.Amt2 := CollectAmt * SalesIncRec."Rate 2" / 100;
                    CollectionDetAudit.MODIFY;
                    EXIT(CollectAmt * SalesIncRec."Rate 2" / 100)
                END
                ELSE
                    IF Days <= 60 THEN BEGIN
                        Amt3 := CollectAmt;
                        CollectionDetAudit.Amt3 := CollectAmt * SalesIncRec."Rate 3" / 100;
                        CollectionDetAudit.MODIFY;
                        EXIT(CollectAmt * SalesIncRec."Rate 3" / 100)
                    END
                    ELSE
                        IF Days <= 90 THEN BEGIN
                            Amt4 := CollectAmt;
                            CollectionDetAudit.Amt4 := CollectAmt * SalesIncRec."Rate 4" / 100;
                            CollectionDetAudit.MODIFY;
                            EXIT(CollectAmt * SalesIncRec."Rate 4" / 100)
                        END
                        ELSE
                            EXIT(0);
        END
        ELSE
            EXIT(0);
    end;

    local procedure WriteDebtorEntry(Days: Integer; InitCustLedRec: Record "Cust. Ledger Entry")
    var
        vMonthSalesInc: Record "Monthly Sales Incentive";
        DrColumn: Text[8];
        IncColumn: Text[8];
    begin
        IF Days <= 90 THEN
            EXIT
        ELSE
            IF Days <= 120 THEN BEGIN
                DrColumn := 'COLUMN4';
                IncColumn := 'COLUMN5';
            END
            ELSE
                IF Days >= 121 THEN BEGIN
                    DrColumn := 'COLUMN6';
                    IncColumn := 'COLUMN7';
                END
                ELSE
                    EXIT;
        /*
        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year,'%1',Curryear);
        vMonthSalesInc.SETFILTER(Month,'%1',CurrMonth);
        vMonthSalesInc.SETFILTER("Global Dimension 1 Code",InitCustLedRec."Global Dimension 1 Code");
        vMonthSalesInc.SETFILTER("Salesperson Code",InitCustLedRec."Salesperson Code");
        vMonthSalesInc.SETFILTER("Field Type",'%1',vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETFILTER("Field Name",DrColumn);
        InitCustLedRec.CALCFIELDS("Remaining Amt. (LCY)");
        IF vMonthSalesInc.FINDFIRST THEN BEGIN
          vMonthSalesInc."Field Value" += InitCustLedRec."Remaining Amt. (LCY)";
          vMonthSalesInc.MODIFY;
        END ELSE BEGIN
          vMonthSalesInc.INIT;
          vMonthSalesInc.Year := Curryear;
          vMonthSalesInc.Month := CurrMonth;
          vMonthSalesInc."Global Dimension 1 Code" := InitCustLedRec."Global Dimension 1 Code";
          vMonthSalesInc."Salesperson Code" := InitCustLedRec."Salesperson Code";
          vMonthSalesInc."Field Type" := vMonthSalesInc."Field Type"::Column;
          vMonthSalesInc."Field Name" := DrColumn;
          vMonthSalesInc."Field Value" := InitCustLedRec."Remaining Amt. (LCY)";
          vMonthSalesInc.INSERT;
        END;
        */

        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', Curryear);
        vMonthSalesInc.SETFILTER(Month, '%1', CurrMonth);
        vMonthSalesInc.SETFILTER("Global Dimension 1 Code", InitCustLedRec."Global Dimension 1 Code");
        vMonthSalesInc.SETFILTER("Salesperson Code", InitCustLedRec."Salesperson Code");
        vMonthSalesInc.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETFILTER("Field Name", IncColumn);
        IF vMonthSalesInc.FINDFIRST THEN BEGIN
            vMonthSalesInc."Field Value" += GetDebtorIncentive(Days, InitCustLedRec);
            vMonthSalesInc.MODIFY;
        END ELSE BEGIN
            vMonthSalesInc.INIT;
            vMonthSalesInc.Year := Curryear;
            vMonthSalesInc.Month := CurrMonth;
            vMonthSalesInc."Global Dimension 1 Code" := InitCustLedRec."Global Dimension 1 Code";
            vMonthSalesInc."Salesperson Code" := InitCustLedRec."Salesperson Code";
            vMonthSalesInc."Field Type" := vMonthSalesInc."Field Type"::Column;
            vMonthSalesInc."Field Name" := IncColumn;
            vMonthSalesInc."Field Value" := GetDebtorIncentive(Days, InitCustLedRec);
            vMonthSalesInc.INSERT;
        END;

    end;

    local procedure GetDebtorIncentive(Days: Integer; InitCustLedRec: Record "Cust. Ledger Entry"): Decimal
    var
        SalespersonRec: Record "Salesperson/Purchaser";
        SalesIncRec: Record "Sales Incentives";
    begin
        SalespersonRec.GET(InitCustLedRec."Salesperson Code");
        SalesIncRec.RESET;
        SalesIncRec.SETFILTER(Year, '%1', Curryear);
        SalesIncRec.SETFILTER(Month, '%1', 0);
        SalesIncRec.SETFILTER("Global Dimension 1 Code", InitCustLedRec."Global Dimension 1 Code");
        SalesIncRec.SETFILTER("Icentive Type", '%1', SalesIncRec."Icentive Type"::Debtors);
        SalesIncRec.SETFILTER(Designation, SalespersonRec.Designation);
        IF SalesIncRec.FINDFIRST THEN BEGIN
            IF Days <= 90 THEN
                EXIT(0)
            ELSE
                IF Days <= 120 THEN
                    EXIT(InitCustLedRec."Remaining Amt. (LCY)" * SalesIncRec."Rate 1" / 100)
                ELSE
                    IF Days >= 121 THEN
                        EXIT(InitCustLedRec."Remaining Amt. (LCY)" * SalesIncRec."Rate 2" / 100)
                    ELSE
                        EXIT(0);
        END
        ELSE
            EXIT(0);
    end;

    local procedure WriteSalesPerEntry(Days: Integer; SlsPerTmp: Record "Salesperson/Purchaser" temporary; Column: Text[8])
    var
        vMonthSalesInc: Record "Monthly Sales Incentive";
    begin



        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', Curryear);
        vMonthSalesInc.SETFILTER(Month, '%1', CurrMonth);
        vMonthSalesInc.SETFILTER("Global Dimension 1 Code", SlsPerTmp."Global Dimension 1 Code");
        vMonthSalesInc.SETFILTER("Salesperson Code", SlsPerTmp.Code);
        vMonthSalesInc.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETFILTER("Field Name", Column);
        IF vMonthSalesInc.FINDFIRST THEN BEGIN
            vMonthSalesInc."Field Value" += SlsPerTmp.Expense;
            vMonthSalesInc.MODIFY;
        END ELSE BEGIN
            vMonthSalesInc.INIT;
            vMonthSalesInc.Year := Curryear;
            vMonthSalesInc.Month := CurrMonth;
            vMonthSalesInc."Global Dimension 1 Code" := SlsPerTmp."Global Dimension 1 Code";
            vMonthSalesInc."Salesperson Code" := SlsPerTmp.Code;
            vMonthSalesInc."Field Type" := vMonthSalesInc."Field Type"::Column;
            vMonthSalesInc."Field Name" := Column;
            vMonthSalesInc."Field Value" := SlsPerTmp.Expense;
            vMonthSalesInc.INSERT;
        END;
    end;


    procedure CreateExcelSheet()
    var
        XlBuff: Record "Excel Buffer";
        i: Integer;
        vMonthSalesInc: Record "Monthly Sales Incentive";
        CurrDIm1Row: Integer;
        CurrRepRow: Integer;
        CurDim1Code: Code[20];
        CurrRepCode: Code[20];
        j: Integer;
        SalesRepRec: Record "Salesperson/Purchaser";
    begin
        XlBuff.DELETEALL;
        AddExcelTitle(XlBuff);
        AddExcelHeader(XlBuff);
        j := 3;  //Row
        i := 1; //Column
        vMonthSalesInc.SETFILTER(Year, '%1', Curryear);
        vMonthSalesInc.SETFILTER(Month, '%1', CurrMonth);
        IF vMonthSalesInc.FINDFIRST THEN
            REPEAT
                IF CurrRepCode <> vMonthSalesInc."Salesperson Code" THEN BEGIN
                    CurrRepCode := vMonthSalesInc."Salesperson Code";
                    IF CurDim1Code <> vMonthSalesInc."Global Dimension 1 Code" THEN BEGIN
                        CurDim1Code := vMonthSalesInc."Global Dimension 1 Code";
                        WriteExcelColText(XlBuff, 1, j, CurDim1Code);
                        j += 1;
                    END;
                    SalesRepRec.GET(CurrRepCode);
                    WriteExcelColText(XlBuff, 1, j, SalesRepRec.Name);
                    CurrRepRow := j;
                    j += 1;
                    //CurrRepRow :=  j;
                END;
                CASE vMonthSalesInc."Field Type" OF
                    vMonthSalesInc."Field Type"::Row:
                        BEGIN
                            WriteExcelColText(XlBuff, 1, j, vMonthSalesInc."Field Name");
                            WriteExcelColText(XlBuff, 2, j, vMonthSalesInc."Field Caption");
                            WriteExcelColText(XlBuff, 3, j, vMonthSalesInc.Designation);
                            WriteExcelCol(XlBuff, 4, j, vMonthSalesInc.Target);
                            WriteExcelCol(XlBuff, 5, j, vMonthSalesInc."Gross Sales");
                            WriteExcelCol(XlBuff, 6, j, vMonthSalesInc.Returns);
                            WriteExcelCol(XlBuff, 7, j, vMonthSalesInc."Net Sales");
                            WriteExcelCol(XlBuff, 8, j, vMonthSalesInc."Incentive %");
                            WriteExcelCol(XlBuff, 9, j, vMonthSalesInc."Sales Incentive");
                            j += 1;
                        END;
                    vMonthSalesInc."Field Type"::Column:
                        BEGIN
                            CASE vMonthSalesInc."Field Name" OF
                                'COLUMN1':
                                    WriteExcelCol(XlBuff, 10, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN19':
                                    WriteExcelCol(XlBuff, 11, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN2':
                                    WriteExcelCol(XlBuff, 12, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN3':
                                    WriteExcelCol(XlBuff, 13, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN4':
                                    WriteExcelCol(XlBuff, 14, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN5':
                                    WriteExcelCol(XlBuff, 15, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN6':
                                    WriteExcelCol(XlBuff, 16, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN7':
                                    WriteExcelCol(XlBuff, 17, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN8':
                                    WriteExcelCol(XlBuff, 18, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN9':
                                    WriteExcelCol(XlBuff, 19, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN10':
                                    WriteExcelCol(XlBuff, 20, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN11':
                                    WriteExcelCol(XlBuff, 21, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN12':
                                    WriteExcelCol(XlBuff, 22, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN13':
                                    WriteExcelCol(XlBuff, 23, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN14':
                                    WriteExcelCol(XlBuff, 24, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN15':
                                    WriteExcelCol(XlBuff, 25, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN16':
                                    WriteExcelCol(XlBuff, 26, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN17':
                                    WriteExcelCol(XlBuff, 27, CurrRepRow, vMonthSalesInc."Field Value");
                                'COLUMN18':
                                    WriteExcelCol(XlBuff, 28, CurrRepRow, vMonthSalesInc."Field Value");
                            END;
                        END;
                END;
            UNTIL vMonthSalesInc.NEXT = 0;


        /*i := 3;
        REPEAT
          //XlBuff.NewRow;
          XlBuff.SetCurrent(i,i-2);
          XlBuff.EditColumn(i,FALSE,'cc',FALSE,FALSE,FALSE,'',XlBuff."Cell Type"::Number);
          i += 1;
        UNTIL i =10 ;
        */
        //Recheck with rj again
        //XlBuff.CreateBookAndOpenExcel('', 'Sheet1', 'Report', COMPANYNAME, USERID); //TL

    end;

    local procedure AddExcelTitle(XlBf: Record "Excel Buffer")
    begin
        XlBf.SetCurrent(1, 0);
        XlBf.AddColumn('Year/Month', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.SetCurrent(1, 1);
        XlBf.AddColumn(FORMAT(Curryear) + '/' + FORMAT(CurrMonth), FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.SetCurrent(2, 0);
        XlBf.AddColumn('Sales Incentive & Collection Incentive', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
    end;

    local procedure AddExcelHeader(XlBf: Record "Excel Buffer")
    begin
        XlBf.SetCurrent(3, 0);
        XlBf.AddColumn('Sales Person', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('BU-Product Category', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Designation', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Target', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Gross Sales', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Returns', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Net Sales', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('%1', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Sales Incentive', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Collection Incentive', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('PD Cheque Collection Incentive', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Adj', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Total Incentive', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('>90 Debtors', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Rate', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('> 120 Debtors', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Rate', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Deductions', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Upper Limit Deductions', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Gross Incentive', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Transport Cost', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Arrers Ded. Mobile and Fuel', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Mobile', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Fuel', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Trade Debtor Recoveries', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
        XlBf.AddColumn('Total Incentive after Deduction', FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
    end;

    local procedure WriteExcelCol(XlBf: Record "Excel Buffer"; Col: Integer; Row: Integer; CurValue: Decimal)
    begin
        XlBf.SetCurrent(Row, Col);
        IF CurValue <> 0 THEN
            XlBf.EditColumn(CurValue, FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
    end;

    local procedure WriteExcelColText(XlBf: Record "Excel Buffer"; Col: Integer; Row: Integer; CurValue: Text[256])
    begin
        XlBf.SetCurrent(Row, Col);
        XlBf.EditColumn(CurValue, FALSE, '', TRUE, FALSE, FALSE, '', XlBf."Cell Type"::Text);
    end;

    local procedure WritePDChequeCollectionEntry(Days: Integer; InitCustLedRec: Record "Cust. Ledger Entry"; pDetCustLedRec: Record "Detailed Cust. Ledg. Entry")
    var
        vMonthSalesInc: Record "Monthly Sales Incentive";
        CollectAmt: Decimal;
        vAmt1: Decimal;
        vAmt2: Decimal;
        vAmt3: Decimal;
        vAmt4: Decimal;
    begin
        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', Curryear);
        vMonthSalesInc.SETFILTER(Month, '%1', CurrMonth);
        vMonthSalesInc.SETFILTER("Global Dimension 1 Code", InitCustLedRec."Global Dimension 1 Code");
        vMonthSalesInc.SETFILTER("Salesperson Code", InitCustLedRec."Salesperson Code");
        vMonthSalesInc.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETFILTER("Field Name", 'COLUMN19');
        IF vMonthSalesInc.FINDFIRST THEN BEGIN
            vMonthSalesInc."Field Value" += GetPDChequeCollectionIncentive(Days, InitCustLedRec, pDetCustLedRec, vAmt1, vAmt2, vAmt3, vAmt4);
            vMonthSalesInc."Amount 1" += vAmt1;
            vMonthSalesInc."Amount 2" += vAmt2;
            vMonthSalesInc."Amount 3" += vAmt3;
            vMonthSalesInc."Amount 4" += vAmt4;
            vMonthSalesInc.MODIFY;
        END ELSE BEGIN
            vMonthSalesInc.INIT;
            vMonthSalesInc.Year := Curryear;
            vMonthSalesInc.Month := CurrMonth;
            vMonthSalesInc."Global Dimension 1 Code" := InitCustLedRec."Global Dimension 1 Code";
            vMonthSalesInc."Salesperson Code" := InitCustLedRec."Salesperson Code";
            vMonthSalesInc."Field Type" := vMonthSalesInc."Field Type"::Column;
            vMonthSalesInc."Field Name" := 'COLUMN19';
            vMonthSalesInc."Field Value" := GetPDChequeCollectionIncentive(Days, InitCustLedRec, pDetCustLedRec, vAmt1, vAmt2, vAmt3, vAmt4);
            vMonthSalesInc."Amount 1" := vAmt1;
            vMonthSalesInc."Amount 2" := vAmt2;
            vMonthSalesInc."Amount 3" := vAmt3;
            vMonthSalesInc."Amount 4" := vAmt4;
            vMonthSalesInc.INSERT;
        END;
    end;

    local procedure GetPDChequeCollectionIncentive(Days: Integer; InitCustLedRec: Record "Cust. Ledger Entry"; pDetCustLedRec: Record "Detailed Cust. Ledg. Entry"; var Amt1: Decimal; var Amt2: Decimal; var Amt3: Decimal; var Amt4: Decimal): Decimal
    var
        SalespersonRec: Record "Salesperson/Purchaser";
        SalesIncRec: Record "Sales Incentives";
        CollectAmt: Decimal;
        CreditPeriod: Decimal;
    begin
        CollectAmt := ABS(ROUND(InitCustLedRec."Sales (LCY)" * pDetCustLedRec.Amount / InitCustLedRec."Amount (LCY)", 0.001));
        Amt1 := 0;
        Amt2 := 0;
        Amt3 := 0;
        Amt4 := 0;
        SalespersonRec.GET(InitCustLedRec."Salesperson Code");
        SalesIncRec.RESET;
        SalesIncRec.SETFILTER(Year, '%1', Curryear);
        SalesIncRec.SETFILTER(Month, '%1', CurrMonth);
        SalesIncRec.SETFILTER("Global Dimension 1 Code", InitCustLedRec."Global Dimension 1 Code");
        SalesIncRec.SETFILTER("Icentive Type", '%1', SalesIncRec."Icentive Type"::"PD Cheque");
        SalesIncRec.SETFILTER(Designation, SalespersonRec.Designation);
        CreditPeriod := pDetCustLedRec."Posting Date" - InitCustLedRec."Posting Date";    //InitCustLedRec."Due Date" - InitCustLedRec."Document Date";
        IF SalesIncRec.FINDFIRST THEN BEGIN
            IF CreditPeriod <= 0 THEN
                EXIT(0)
            ELSE
                IF CreditPeriod <= 45 THEN BEGIN
                    Amt1 := CollectAmt;
                    EXIT(CollectAmt * SalesIncRec."Rate 1" / 100)
                END
                ELSE
                    IF CreditPeriod <= 60 THEN BEGIN
                        Amt2 := CollectAmt;
                        EXIT(CollectAmt * SalesIncRec."Rate 2" / 100)
                    END
                    ELSE
                        IF CreditPeriod <= 65 THEN BEGIN
                            Amt3 := CollectAmt;
                            EXIT(CollectAmt * SalesIncRec."Rate 3" / 100)
                        END
                        ELSE
                            IF CreditPeriod <= 70 THEN BEGIN
                                Amt4 := CollectAmt;
                                EXIT(CollectAmt * SalesIncRec."Rate 4" / 100)
                            END
                            ELSE
                                EXIT(0);
        END
        ELSE
            EXIT(0);
    end;


    procedure SalesTagertsEditable(Year: Integer; Month: Integer): Boolean
    var
        SalesSetupRec: Record "Sales & Receivables Setup";
    begin
        SalesSetupRec.GET;
        IF SalesSetupRec."Last Incetive Paid Year" * 12 + SalesSetupRec."Last Incentive Paid Month" >= Year * 12 + Month THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;


    procedure IncentiveSchemeEditable(Year: Integer; Month: Integer): Boolean
    var
        SalesSetupRec: Record "Sales & Receivables Setup";
    begin
        SalesSetupRec.GET;
        IF SalesSetupRec."Last Incetive Paid Year" * 12 + SalesSetupRec."Last Incentive Paid Month" >= Year * 12 + Month THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    local procedure GetTree(pSalesPerH: Record "Salesperson Hierarchy")
    var
        lSalesperHRec: Record "Salesperson Hierarchy";
        ltotAmt: Decimal;
        lSalesPerRec: Record "Salesperson/Purchaser";
    begin
        //IF pSalesPerH.Code = 'CM' THEN
        //  MESSAGE(pSalesPerH.Code);

        ltotAmt := 0;
        lSalesperHRec.RESET;
        lSalesperHRec.SETFILTER("Cal. Year", '%1', pSalesPerH."Cal. Year");
        lSalesperHRec.SETFILTER("Cal. Month", '%1', pSalesPerH."Cal. Month");
        lSalesperHRec.SETFILTER("Reporting To Code", pSalesPerH.Code);
        IF lSalesperHRec.FINDSET THEN
            REPEAT
                GetTree(lSalesperHRec);
            UNTIL lSalesperHRec.NEXT = 0;
        lSalesPerRec.GET(pSalesPerH.Code);
        InsertSalesPersonH(pSalesPerH."Cal. Year", pSalesPerH."Cal. Month", lSalesPerRec); //Insert To Temp List to validate
        IncludeSalesChildren(pSalesPerH."Cal. Year", pSalesPerH."Cal. Month", pSalesPerH);
        CalculateIncentive(pSalesPerH."Cal. Year", pSalesPerH."Cal. Month", pSalesPerH);
    end;

    local procedure InsertSalesPersonH(runYear: Integer; runMonth: Integer; SalesperRec: Record "Salesperson/Purchaser")
    var
        SalesperRec2: Record "Salesperson/Purchaser";
        NoofDays: Integer;
        SourceSetupRec: Record "Source Code Setup";
        DebtAginReport: Report "Customized Debtor Age Anly";
        DatePiroed: DateFormula;
    begin
        SalesperRec.TESTFIELD("Global Dimension 1 Code");
        BUProdCat.RESET;
        BUProdCat.SETFILTER(BUProdCat.Type, '%1', BUProdCat.Type::"Product Category");
        BUProdCat.SETFILTER("Global Dimension 1 Code", SalesperRec."Global Dimension 1 Code");
        IF BUProdCat.FINDSET THEN
            REPEAT
                SalesTargetRec.RESET;
                SalesTargetRec.SETFILTER("Target Year", '%1', Curryear);
                SalesTargetRec.SETFILTER("Target Month", '%1', CurrMonth);
                SalesTargetRec.SETFILTER("Salesperson Code", SalesperRec.Code);
                SalesTargetRec.SETFILTER("Product Category Code", BUProdCat.Code);
                SalesTargetRec.CALCSUMS("Target Value");


                SalesInvLineRec.RESET;
                SalesInvLineRec.SETFILTER(Type, '%1', SalesInvLineRec.Type::Item);
                SalesInvLineRec.SETFILTER("Product Category Code", BUProdCat.Code);
                SalesInvLineRec.SETFILTER("Salesperson Code", SalesperRec.Code);
                SalesInvLineRec.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                SalesInvLineRec.SETFILTER("Line Unit GP", '>%1', 0);
                SalesInvLineRec.CALCSUMS("Amount Including VAT");



                SalesCrMemoLineRec.RESET;
                SalesCrMemoLineRec.SETFILTER(Type, '%1', SalesInvLineRec.Type::Item);
                SalesCrMemoLineRec.SETFILTER("Product Category Code", BUProdCat.Code);
                SalesCrMemoLineRec.SETFILTER("Salesperson Code", SalesperRec.Code);
                SalesCrMemoLineRec.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                SalesCrMemoLineRec.CALCSUMS("Amount Including VAT");


                MonthSaleIncRec.SETFILTER(Year, '%1', Curryear);
                MonthSaleIncRec.SETFILTER(Month, '%1', CurrMonth);
                MonthSaleIncRec.SETFILTER("Global Dimension 1 Code", BUProdCat."Global Dimension 1 Code");
                MonthSaleIncRec.SETFILTER("Salesperson Code", SalesperRec.Code);
                MonthSaleIncRec.SETFILTER("Field Type", '%1', MonthSaleIncRec."Field Type"::Row);
                MonthSaleIncRec.SETFILTER("Field Name", BUProdCat.Code);
                IF MonthSaleIncRec.FINDFIRST THEN BEGIN
                    MonthSaleIncRec.Target += SalesTargetRec."Target Value";
                    MonthSaleIncRec."Gross Sales" += SalesInvLineRec."Amount Including VAT";
                    MonthSaleIncRec.Returns += SalesCrMemoLineRec."Amount Including VAT";
                    MonthSaleIncRec."Net Sales" += SalesInvLineRec."Amount Including VAT" - SalesCrMemoLineRec."Amount Including VAT";
                    IF MonthSaleIncRec.Target > 0 THEN
                        MonthSaleIncRec."Incentive %" := ROUND((MonthSaleIncRec."Net Sales" / MonthSaleIncRec.Target) * 100, 0.001)
                    ELSE
                        MonthSaleIncRec."Incentive %" := 0;
                    MonthSaleIncRec."Sales Incentive" := GetSalesIncentive(Curryear, BUProdCat."Global Dimension 1 Code", BUProdCat.Code, SalesperRec.Designation, MonthSaleIncRec."Incentive %", CurrMonth);
                    MonthSaleIncRec.MODIFY;
                END ELSE BEGIN
                    MonthSaleIncRec.INIT;
                    MonthSaleIncRec.Year := Curryear;
                    MonthSaleIncRec.Month := CurrMonth;
                    MonthSaleIncRec."Global Dimension 1 Code" := BUProdCat."Global Dimension 1 Code";
                    MonthSaleIncRec."Salesperson Code" := SalesperRec.Code;
                    MonthSaleIncRec."Field Type" := MonthSaleIncRec."Field Type"::Row;
                    MonthSaleIncRec."Field Name" := BUProdCat.Code;
                    MonthSaleIncRec.Sequence := 0;
                    MonthSaleIncRec."Field Caption" := BUProdCat.Description;
                    MonthSaleIncRec.Designation := SalesperRec.Designation;
                    MonthSaleIncRec.Target := SalesTargetRec."Target Value";
                    MonthSaleIncRec."Gross Sales" := SalesInvLineRec."Amount Including VAT";
                    MonthSaleIncRec.Returns := SalesCrMemoLineRec."Amount Including VAT";
                    MonthSaleIncRec."Net Sales" := SalesInvLineRec."Amount Including VAT" - SalesCrMemoLineRec."Amount Including VAT";
                    IF MonthSaleIncRec.Target > 0 THEN
                        MonthSaleIncRec."Incentive %" := ROUND(MonthSaleIncRec."Net Sales" / MonthSaleIncRec.Target, 0.001)
                    ELSE
                        MonthSaleIncRec."Incentive %" := 0;
                    MonthSaleIncRec."Sales Incentive" := GetSalesIncentive(Curryear, BUProdCat."Global Dimension 1 Code", BUProdCat.Code, SalesperRec.Designation, MonthSaleIncRec."Incentive %", CurrMonth);
                    MonthSaleIncRec.INSERT;
                END;
            UNTIL BUProdCat.NEXT = 0;


        //Collection

        DetCustLedRec.RESET;
        DetCustLedRec.SETFILTER("Entry Type", '%1', DetCustLedRec."Entry Type"::Application);
        DetCustLedRec.SETFILTER("Document Type", '%1', DetCustLedRec."Document Type"::Payment);
        DetCustLedRec.SETFILTER(Amount, '<0');
        DetCustLedRec.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
        IF DetCustLedRec.FINDSET THEN
            REPEAT
                //CustLedRec.GET(DetCustLedRec."Cust. Ledger Entry No.");
                CustLedRec.RESET;
                CustLedRec.SETFILTER("Document Type", '%1', DetCustLedRec."Document Type");
                CustLedRec.SETFILTER(CustLedRec."Document No.", DetCustLedRec."Document No.");
                IF CustLedRec.FINDFIRST THEN
                    IF CustLedRec."Reason Code" <> 'CUST-ADV' THEN BEGIN
                        DetCustLedRec2.RESET;
                        DetCustLedRec2.SETFILTER("Entry Type", '%1', DetCustLedRec."Entry Type"::"Initial Entry");
                        DetCustLedRec2.SETFILTER("Cust. Ledger Entry No.", '%1', DetCustLedRec."Cust. Ledger Entry No.");
                        IF DetCustLedRec2.FINDSET THEN BEGIN
                            CustLedRec2.RESET;
                            CustLedRec2.SETFILTER("Entry No.", '%1', DetCustLedRec."Cust. Ledger Entry No.");
                            CustLedRec2.SETFILTER(CustLedRec2."Salesperson Code", SalesperRec.Code);
                            IF CustLedRec2.FINDFIRST THEN BEGIN
                                CustLedRec2.CALCFIELDS("Amount (LCY)");
                                NoofDays := CustLedRec."Posting Date" - CustLedRec2."Document Date";
                                WriteCollectionEntry(NoofDays, CustLedRec2, DetCustLedRec);
                            END;
                        END;
                    END;
            UNTIL DetCustLedRec.NEXT = 0;

        //Cheque Collection
        SourceSetupRec.GET;
        SourceSetupRec.TESTFIELD("PD-Cheque Receipt Journal");
        DetCustLedRec.RESET;
        DetCustLedRec.SETFILTER("Entry Type", '%1', DetCustLedRec."Entry Type"::Application);
        DetCustLedRec.SETFILTER("Document Type", '%1', DetCustLedRec."Document Type"::Payment);
        DetCustLedRec.SETFILTER(Amount, '<0');
        DetCustLedRec.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
        DetCustLedRec.SETFILTER("Source Code", SourceSetupRec."PD-Cheque Receipt Journal");

        IF DetCustLedRec.FINDSET THEN
            REPEAT
                //CustLedRec.GET(DetCustLedRec."Cust. Ledger Entry No.");
                CustLedRec.RESET;
                CustLedRec.SETFILTER("Document Type", '%1', DetCustLedRec."Document Type");
                CustLedRec.SETFILTER(CustLedRec."Document No.", DetCustLedRec."Document No.");
                IF CustLedRec.FINDFIRST THEN
                    IF CustLedRec."Reason Code" <> 'CUST-ADV' THEN BEGIN
                        DetCustLedRec2.RESET;
                        DetCustLedRec2.SETFILTER("Entry Type", '%1', DetCustLedRec."Entry Type"::"Initial Entry");
                        DetCustLedRec2.SETFILTER("Cust. Ledger Entry No.", '%1', DetCustLedRec."Cust. Ledger Entry No.");
                        IF DetCustLedRec2.FINDSET THEN BEGIN
                            CustLedRec2.RESET;
                            CustLedRec2.SETFILTER("Entry No.", '%1', DetCustLedRec."Cust. Ledger Entry No.");
                            CustLedRec2.SETFILTER(CustLedRec2."Salesperson Code", SalesperRec.Code);
                            IF CustLedRec2.FINDFIRST THEN BEGIN
                                CustLedRec2.CALCFIELDS("Amount (LCY)");
                                NoofDays := CustLedRec."Cheque Received Date" - CustLedRec2."Posting Date";
                                IF NoofDays <= 7 THEN
                                    WritePDChequeCollectionEntry(NoofDays, CustLedRec2, DetCustLedRec);
                            END;
                        END;
                    END;
            UNTIL DetCustLedRec.NEXT = 0;


        //Debtors

        CustLedRec.RESET;
        //CustLedRec.SETFILTER("Document Type",'%1',CustLedRec."Document Type"::Invoice);
        CustLedRec.SETFILTER("Document Date", '<%1', EndDate - 90); //RJ
        //CustLedRec.SETFILTER("Document Date",'<%1' , EndDate);
        CustLedRec.SETFILTER(Open, '%1', TRUE);
        CustLedRec.SETFILTER(CustLedRec."Salesperson Code", SalesperRec.Code);
        IF CustLedRec.FINDSET THEN
            REPEAT
                NoofDays := EndDate - CustLedRec."Document Date";
                WriteDebtorEntry(NoofDays, CustLedRec);
            UNTIL CustLedRec.NEXT = 0;

        //EVALUATE(DatePiroed,'<30D>');
        //DebtAginReport.USEREQUESTPAGE := FALSE;
        //DebtAginReport.SetVariables(SalesperRec.Code,Curryear,CurrMonth,EndDate);
        //DebtAginReport.RUN;

        //WriteDebtorEntry(amt90,amt120);

        //Mobile

        GenLdgrRec.RESET;
        GenLdgrRec.SETFILTER("Document Type", '%1', GenLdgrRec."Document Type"::Payment);
        GenLdgrRec.SETFILTER("Expense Type", '%1', GenLdgrRec."Expense Type"::Mobile);
        GenLdgrRec.SETFILTER("Debit Amount", '>0');
        GenLdgrRec.SETRANGE("Posting Date", StartDate, EndDate);
        GenLdgrRec.SETFILTER("Salespers./Purch. Code", SalesperRec.Code);
        IF GenLdgrRec.FINDSET THEN
            REPEAT
                IF SalesPerTmp.GET(GenLdgrRec."Salespers./Purch. Code") THEN BEGIN
                    SalesPerTmp.Expense += GenLdgrRec."Debit Amount";
                    SalesPerTmp.MODIFY;
                END ELSE BEGIN
                    SalesPerTmp.INIT;
                    SalesPerTmp.TRANSFERFIELDS(SalesperRec);
                    SalesPerTmp.Expense := GenLdgrRec."Debit Amount";
                    SalesPerTmp.INSERT;
                END;
            UNTIL GenLdgrRec.NEXT = 0;

        IF SalesPerTmp.FINDFIRST THEN
            REPEAT
                EmpRec.RESET;
                EmpRec.SETFILTER("Salespers./Purch. Code", SalesPerTmp.Code);
                IF EmpRec.FINDFIRST THEN BEGIN
                    IF SalesPerTmp.Expense > (EmpRec."Mobile Limit") THEN
                        SalesPerTmp.Expense := SalesPerTmp.Expense - (EmpRec."Mobile Limit")
                    ELSE
                        SalesPerTmp.Expense := 0;
                    SalesPerTmp.MODIFY;
                END;
                WriteSalesPerEntry(0, SalesPerTmp, 'COLUMN14');
            UNTIL SalesPerTmp.NEXT = 0;

        //Fuel



        GenLdgrRec.RESET;
        GenLdgrRec.SETFILTER("Document Type", '%1', GenLdgrRec."Document Type"::Payment);
        GenLdgrRec.SETFILTER("Expense Type", '%1', GenLdgrRec."Expense Type"::Fuel);
        GenLdgrRec.SETFILTER("Debit Amount", '>0');
        GenLdgrRec.SETRANGE("Posting Date", StartDate, EndDate);
        GenLdgrRec.SETFILTER(GenLdgrRec."Salespers./Purch. Code", SalesperRec.Code);
        IF GenLdgrRec.FINDSET THEN
            REPEAT
                IF SalesPerTmp2.GET(GenLdgrRec."Salespers./Purch. Code") THEN BEGIN
                END ELSE BEGIN
                    SalesPerTmp2.INIT;
                    SalesPerTmp2.TRANSFERFIELDS(SalesperRec);
                    SalesPerTmp2.Expense := GenLdgrRec."Debit Amount";
                    SalesPerTmp2.INSERT;
                END;
            UNTIL GenLdgrRec.NEXT = 0;

        IF SalesPerTmp2.FINDFIRST THEN
            REPEAT
                EmpRec.RESET;
                EmpRec.SETFILTER("Salespers./Purch. Code", SalesPerTmp2.Code);
                IF EmpRec.FINDFIRST THEN BEGIN
                    IF SalesPerTmp2.Expense > (EmpRec."Petrol Limit" + EmpRec."Diesel Limit") THEN
                        SalesPerTmp2.Expense := SalesPerTmp2.Expense - (EmpRec."Petrol Limit" + EmpRec."Diesel Limit")
                    ELSE
                        SalesPerTmp2.Expense := 0;
                    SalesPerTmp2.MODIFY;
                END;
                WriteSalesPerEntry(0, SalesPerTmp2, 'COLUMN15');
            UNTIL SalesPerTmp2.NEXT = 0;
    end;

    local procedure IncludeSalesChildren(runYear: Integer; runMonth: Integer; SalesperHRec: Record "Salesperson Hierarchy")
    var
        SalesperH: Record "Salesperson Hierarchy";
        vMonthSalesInc: Record "Monthly Sales Incentive";
        vMonthSalesInc2: Record "Monthly Sales Incentive";
    begin
        SalesperH.RESET;
        SalesperH.SETFILTER("Cal. Year", '%1', runYear);
        SalesperH.SETFILTER("Cal. Month", '%1', runMonth);
        SalesperH.SETFILTER("Reporting To Code", SalesperHRec.Code);
        IF SalesperH.FINDSET THEN
            REPEAT
                //Sales
                vMonthSalesInc.RESET;
                vMonthSalesInc.SETFILTER(Year, '%1', runYear);
                vMonthSalesInc.SETFILTER(Month, '%1', runMonth);
                vMonthSalesInc.SETFILTER("Salesperson Code", SalesperH.Code);
                vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Type", vMonthSalesInc."Field Type"::Row);
                IF vMonthSalesInc.FINDSET THEN
                    REPEAT
                        //Year,Month,Global Dimension 1 Code,Salesperson Code,Field Type,Field Name
                        vMonthSalesInc2.RESET;
                        vMonthSalesInc2.SETFILTER(Year, '%1', vMonthSalesInc.Year);
                        vMonthSalesInc2.SETFILTER(Month, '%1', vMonthSalesInc.Month);
                        vMonthSalesInc2.SETFILTER("Global Dimension 1 Code", vMonthSalesInc."Global Dimension 1 Code");
                        vMonthSalesInc2.SETFILTER("Salesperson Code", SalesperHRec.Code);
                        vMonthSalesInc2.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type");
                        vMonthSalesInc2.SETFILTER("Field Name", vMonthSalesInc."Field Name");
                        IF vMonthSalesInc2.FINDSET THEN BEGIN
                            vMonthSalesInc2."Gross Sales" += vMonthSalesInc."Gross Sales";
                            vMonthSalesInc2.Returns += vMonthSalesInc.Returns;
                            vMonthSalesInc2."Net Sales" += vMonthSalesInc."Net Sales";
                            vMonthSalesInc2.MODIFY;
                        END;
                    UNTIL vMonthSalesInc.NEXT = 0;
                //Collection
                vMonthSalesInc.RESET;
                vMonthSalesInc.SETFILTER(Year, '%1', runYear);
                vMonthSalesInc.SETFILTER(Month, '%1', runMonth);
                vMonthSalesInc.SETFILTER("Salesperson Code", SalesperH.Code);
                vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Type", vMonthSalesInc."Field Type"::Column);
                vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Name", 'COLUMN1');
                IF vMonthSalesInc.FINDSET THEN
                    REPEAT
                        //Year,Month,Global Dimension 1 Code,Salesperson Code,Field Type,Field Name
                        vMonthSalesInc2.RESET;
                        vMonthSalesInc2.SETFILTER(Year, '%1', vMonthSalesInc.Year);
                        vMonthSalesInc2.SETFILTER(Month, '%1', vMonthSalesInc.Month);
                        vMonthSalesInc2.SETFILTER("Global Dimension 1 Code", vMonthSalesInc."Global Dimension 1 Code");
                        vMonthSalesInc2.SETFILTER("Salesperson Code", SalesperHRec.Code);
                        vMonthSalesInc2.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type");
                        vMonthSalesInc2.SETFILTER("Field Name", vMonthSalesInc."Field Name");
                        IF vMonthSalesInc2.FINDSET THEN BEGIN
                            vMonthSalesInc2."Field Value" += vMonthSalesInc."Field Value";
                            vMonthSalesInc2."Amount 1" += vMonthSalesInc."Amount 1";
                            vMonthSalesInc2."Amount 2" += vMonthSalesInc."Amount 2";
                            vMonthSalesInc2."Amount 3" += vMonthSalesInc."Amount 3";
                            vMonthSalesInc2."Amount 4" += vMonthSalesInc."Amount 4";
                            vMonthSalesInc2.MODIFY;
                        END
                        ELSE BEGIN
                            vMonthSalesInc2.INIT;
                            vMonthSalesInc2.Year := vMonthSalesInc.Year;
                            vMonthSalesInc2.Month := vMonthSalesInc.Month;
                            vMonthSalesInc2."Global Dimension 1 Code" := vMonthSalesInc."Global Dimension 1 Code";
                            vMonthSalesInc2."Salesperson Code" := SalesperHRec.Code;
                            vMonthSalesInc2."Field Type" := vMonthSalesInc."Field Type";
                            vMonthSalesInc2."Field Name" := vMonthSalesInc."Field Name";
                            vMonthSalesInc2."Field Value" := vMonthSalesInc."Field Value";
                            vMonthSalesInc2."Amount 1" := vMonthSalesInc."Amount 1";
                            vMonthSalesInc2."Amount 2" := vMonthSalesInc."Amount 2";
                            vMonthSalesInc2."Amount 3" := vMonthSalesInc."Amount 3";
                            vMonthSalesInc2."Amount 4" := vMonthSalesInc."Amount 4";
                            vMonthSalesInc2.INSERT;
                        END;
                    UNTIL vMonthSalesInc.NEXT = 0;
                //PD Cheque Collection
                vMonthSalesInc.RESET;
                vMonthSalesInc.SETFILTER(Year, '%1', runYear);
                vMonthSalesInc.SETFILTER(Month, '%1', runMonth);
                vMonthSalesInc.SETFILTER("Salesperson Code", SalesperH.Code);
                vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Type", vMonthSalesInc."Field Type"::Column);
                vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Name", 'COLUMN20');
                IF vMonthSalesInc.FINDSET THEN
                    REPEAT
                        //Year,Month,Global Dimension 1 Code,Salesperson Code,Field Type,Field Name
                        vMonthSalesInc2.RESET;
                        vMonthSalesInc2.SETFILTER(Year, '%1', vMonthSalesInc.Year);
                        vMonthSalesInc2.SETFILTER(Month, '%1', vMonthSalesInc.Month);
                        vMonthSalesInc2.SETFILTER("Global Dimension 1 Code", vMonthSalesInc."Global Dimension 1 Code");
                        vMonthSalesInc2.SETFILTER("Salesperson Code", SalesperHRec.Code);
                        vMonthSalesInc2.SETFILTER("Field Type", '%1', vMonthSalesInc."Field Type");
                        vMonthSalesInc2.SETFILTER("Field Name", vMonthSalesInc."Field Name");
                        IF vMonthSalesInc2.FINDSET THEN BEGIN
                            vMonthSalesInc2."Field Value" += vMonthSalesInc."Field Value";
                            vMonthSalesInc2.MODIFY;
                        END
                        ELSE BEGIN
                            vMonthSalesInc2.INIT;
                            vMonthSalesInc2.Year := vMonthSalesInc.Year;
                            vMonthSalesInc2.Month := vMonthSalesInc.Month;
                            vMonthSalesInc2."Global Dimension 1 Code" := vMonthSalesInc."Global Dimension 1 Code";
                            vMonthSalesInc2."Salesperson Code" := SalesperHRec.Code;
                            vMonthSalesInc2."Field Type" := vMonthSalesInc."Field Type";
                            vMonthSalesInc2."Field Name" := vMonthSalesInc."Field Name";
                            vMonthSalesInc2."Field Value" := vMonthSalesInc."Field Value";
                            vMonthSalesInc2.INSERT;
                        END;
                    UNTIL vMonthSalesInc.NEXT = 0

             UNTIL SalesperH.NEXT = 0;
    end;

    local procedure CalculateIncentive(runYear: Integer; runMonth: Integer; SalesperHRec: Record "Salesperson Hierarchy")
    var
        vMonthSalesInc: Record "Monthly Sales Incentive";
        vMonthSalesInc2: Record "Monthly Sales Incentive";
        SalesIncRec: Record "Sales Incentives";
    begin

        //Sales Incentive
        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', runYear);
        vMonthSalesInc.SETFILTER(Month, '%1', runMonth);
        vMonthSalesInc.SETFILTER("Salesperson Code", SalesperHRec.Code);
        vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Type", vMonthSalesInc."Field Type"::Row);
        IF vMonthSalesInc.FINDSET THEN
            REPEAT
                vMonthSalesInc."Net Sales" := vMonthSalesInc."Gross Sales" - vMonthSalesInc.Returns;
                IF vMonthSalesInc.Target > 0 THEN
                    vMonthSalesInc."Incentive %" := ROUND((vMonthSalesInc."Net Sales" / vMonthSalesInc.Target) * 100, 0.001)
                ELSE
                    vMonthSalesInc."Incentive %" := 0;
                vMonthSalesInc."Sales Incentive" := GetSalesIncentive(runYear, vMonthSalesInc."Global Dimension 1 Code", vMonthSalesInc."Field Name", vMonthSalesInc.Designation, vMonthSalesInc."Incentive %", runMonth);
                vMonthSalesInc.MODIFY;
            UNTIL vMonthSalesInc.NEXT = 0;

        //Collection Incentive
        //Year,Month,Global Dimension 1 Code,Salesperson Code,Field Type,Field Name
        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', runYear);
        vMonthSalesInc.SETFILTER(Month, '%1', runMonth);
        vMonthSalesInc.SETFILTER("Salesperson Code", SalesperHRec.Code);
        vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Type", vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Name", 'COLUMN1');
        IF vMonthSalesInc.FINDSET THEN
            REPEAT
                SalesIncRec.RESET;
                SalesIncRec.SETFILTER(Year, '%1', runYear);
                SalesIncRec.SETFILTER(Month, '%1', runMonth);
                SalesIncRec.SETFILTER("Global Dimension 1 Code", vMonthSalesInc."Global Dimension 1 Code");
                SalesIncRec.SETFILTER("Icentive Type", '%1', SalesIncRec."Icentive Type"::Collection);
                SalesIncRec.SETFILTER(Designation, vMonthSalesInc.Designation);
                IF SalesIncRec.FINDFIRST THEN BEGIN
                    vMonthSalesInc."Field Value" := vMonthSalesInc."Amount 1" * SalesIncRec."Rate 1" / 100;
                    vMonthSalesInc."Field Value" += vMonthSalesInc."Amount 2" * SalesIncRec."Rate 2" / 100;
                    vMonthSalesInc."Field Value" += vMonthSalesInc."Amount 3" * SalesIncRec."Rate 3" / 100;
                    vMonthSalesInc."Field Value" += vMonthSalesInc."Amount 4" * SalesIncRec."Rate 4" / 100;
                END;

            UNTIL vMonthSalesInc.NEXT = 0;


        //PD Cheque Collection Incentive
        //Year,Month,Global Dimension 1 Code,Salesperson Code,Field Type,Field Name
        vMonthSalesInc.RESET;
        vMonthSalesInc.SETFILTER(Year, '%1', runYear);
        vMonthSalesInc.SETFILTER(Month, '%1', runMonth);
        vMonthSalesInc.SETFILTER("Salesperson Code", SalesperHRec.Code);
        vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Type", vMonthSalesInc."Field Type"::Column);
        vMonthSalesInc.SETRANGE(vMonthSalesInc."Field Name", 'COLUMN19');
        IF vMonthSalesInc.FINDSET THEN
            REPEAT
                SalesIncRec.RESET;
                SalesIncRec.SETFILTER(Year, '%1', runYear);
                SalesIncRec.SETFILTER(Month, '%1', runMonth);
                SalesIncRec.SETFILTER("Global Dimension 1 Code", vMonthSalesInc."Global Dimension 1 Code");
                SalesIncRec.SETFILTER("Icentive Type", '%1', SalesIncRec."Icentive Type"::"PD Cheque");
                SalesIncRec.SETFILTER(Designation, vMonthSalesInc.Designation);
                IF SalesIncRec.FINDFIRST THEN BEGIN
                    vMonthSalesInc."Field Value" := vMonthSalesInc."Amount 1" * SalesIncRec."Rate 1" / 100;
                    vMonthSalesInc."Field Value" += vMonthSalesInc."Amount 2" * SalesIncRec."Rate 2" / 100;
                    vMonthSalesInc."Field Value" += vMonthSalesInc."Amount 3" * SalesIncRec."Rate 3" / 100;
                    vMonthSalesInc."Field Value" += vMonthSalesInc."Amount 4" * SalesIncRec."Rate 4" / 100;
                END;

            UNTIL vMonthSalesInc.NEXT = 0;
    end;
}

