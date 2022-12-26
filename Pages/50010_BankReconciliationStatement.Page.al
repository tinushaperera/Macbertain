page 50010 "Bank Reconciliation Statement."
{
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Caption = 'No.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //NS(-)
                        BacAccc.RESET;
                        IF PAGE.RUNMODAL(371, BacAccc) = ACTION::LookupOK THEN
                            "No." := BacAccc."No.";
                        //NS(+)
                    end;
                }
                field(DVFromDate; DVFromDate)
                {
                    ApplicationArea = all;
                    Caption = 'From Date';
                }
                field(DVToDate; DVToDate)
                {
                    ApplicationArea = all;
                    Caption = 'To Date';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    BankAccStament: Record "Bank Account Statement";
                begin
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        "Init&PrintReport";
    end;

    var
        RVBankAccountLedger1: Record "Bank Account Ledger Entry";
        DVFromDate: Date;
        DVToDate: Date;
        RVTempReport: Record "Bank Reconciliation Statement";
        RVBankAccountLedger: Record "Bank Account Ledger Entry";
        DVBalanceAsAt: Decimal;
        DVRecipts: Decimal;
        DVPayment: Decimal;
        DVBalanceAsPerBank: Decimal;
        RVBankAccRecon: Record "Bank Acc. Reconciliation";
        DVAddDeposit: Decimal;
        DVUnPresented: Decimal;
        DVBLAnk: Decimal;
        DVBalnce: Decimal;
        RVBankReconSumm: Report "Bank Reconciliation Statement";
        CVBankLeg: Code[10];
        CVBankRec: Code[10];
        CVBankAccount: Code[10];
        RVBankAccount: Record "Bank Account";
        CVDocNo: Code[20];
        DVToT: Decimal;
        TTableRec: Record "Bank Reconciliation Statement";
        "No.": Code[20];
        BacAccc: Record "Bank Account";
        Month: Integer;
        DVAddDeposit1: Decimal;
        DVUnPresented1: Decimal;


    procedure "Init&PrintReport"()
    var
        BankAccStament: Record "Bank Account Statement";
    begin
        IF (DVFromDate <> 0D) AND (DVToDate <> 0D) THEN BEGIN

            RVTempReport.DELETEALL;

            DVBalanceAsAt := 0;
            DVRecipts := 0;
            DVPayment := 0;
            DVBalanceAsPerBank := 0;
            DVAddDeposit := 0;
            DVAddDeposit1 := 0;
            DVUnPresented := 0;
            DVUnPresented1 := 0;
            DVBalnce := 0;
            DVBLAnk := 0;

            RVTempReport.INIT;
            RVTempReport.Code := '1';
            RVTempReport.SerialNo := 1;
            RVTempReport.Des := 'CASH BOOK SUMMARY';
            RVTempReport.Bold := TRUE;
            RVTempReport.Underline := TRUE;
            RVTempReport.INSERT;
            COMMIT;

            RVBankAccountLedger.SETRANGE("Bank Account No.", "No.");
            IF RVBankAccountLedger.FIND('-') THEN BEGIN
                REPEAT
                    IF RVBankAccountLedger."Posting Date" < DVFromDate THEN
                        DVBalanceAsAt := DVBalanceAsAt + RVBankAccountLedger.Amount;

                    IF (DVFromDate <= RVBankAccountLedger."Posting Date") AND (RVBankAccountLedger."Posting Date" <= DVToDate) THEN BEGIN
                        DVRecipts := DVRecipts + RVBankAccountLedger."Debit Amount";
                        DVPayment := DVPayment + RVBankAccountLedger."Credit Amount";
                    END;
                UNTIL RVBankAccountLedger.NEXT = 0;

                RVTempReport.INIT;
                RVTempReport.Code := '2';
                RVTempReport.SerialNo := 2;
                RVTempReport.Des := 'Balance as at ' + FORMAT(DVFromDate);
                RVTempReport.Qty := DVBalanceAsAt;
                RVTempReport.INSERT;
                COMMIT;

                RVTempReport.INIT;
                RVTempReport.Code := '3';
                RVTempReport.SerialNo := 3;
                RVTempReport.Des := 'Receipts';
                RVTempReport.Qty := DVRecipts;
                RVTempReport.INSERT;
                COMMIT;

                RVTempReport.INIT;
                RVTempReport.Code := '4';
                RVTempReport.SerialNo := 4;
                RVTempReport.Des := '';
                DVBLAnk := DVBalanceAsAt + DVRecipts;
                RVTempReport.Qty := DVBLAnk;
                RVTempReport.TwoLine := TRUE;
                RVTempReport.INSERT;
                COMMIT;

                RVTempReport.INIT;
                RVTempReport.Code := '5';
                RVTempReport.SerialNo := 5;
                RVTempReport.Des := '';
                DVBLAnk := 0;
                RVTempReport.Qty := 0;
                RVTempReport.INSERT;
                COMMIT;


                RVTempReport.INIT;
                RVTempReport.Code := '6';
                RVTempReport.SerialNo := 6;
                RVTempReport.Des := 'Payments';
                RVTempReport.Qty := DVPayment;
                RVTempReport.INSERT;
                COMMIT;

                RVTempReport.INIT;
                RVTempReport.Code := '7';
                RVTempReport.SerialNo := 7;
                RVTempReport.Des := 'Total';
                RVTempReport.Qty := DVBalanceAsAt + DVRecipts - DVPayment;
                RVTempReport.Bold := TRUE;
                RVTempReport.TwoLine := TRUE;
                RVTempReport.INSERT;
                COMMIT;

                RVTempReport.INIT;
                RVTempReport.Code := '8';
                RVTempReport.SerialNo := 8;
                RVTempReport.Des := '';
                DVBLAnk := 0;
                RVTempReport.Qty := 0;
                RVTempReport.INSERT;
                COMMIT;

            END;

            RVTempReport.INIT;
            RVTempReport.Code := '9';
            RVTempReport.SerialNo := 9;
            RVTempReport.Des := 'BANK STATEMENT RECONCILIATION';
            RVTempReport.Bold := TRUE;
            RVTempReport.Underline := TRUE;
            RVTempReport.INSERT;
            COMMIT;

            //NS
            BankAccStament.RESET;
            BankAccStament.ASCENDING(TRUE);
            BankAccStament.SETRANGE("Bank Account No.", "No.");
            BankAccStament.SETRANGE("Statement Date", DVFromDate, DVToDate); //IK 16/01/2013
            IF BankAccStament.FINDLAST THEN
                DVBalanceAsPerBank := BankAccStament."Statement Ending Balance";

            RVTempReport.INIT;
            RVTempReport.Code := '10';
            RVTempReport.SerialNo := 10;
            RVTempReport.Des := 'Balance As per Bank Statement';
            RVTempReport.Qty := DVBalanceAsPerBank;
            RVTempReport.INSERT;
            COMMIT;

            DVToT := 0;

            //IK
            /*
            RVBankAccountLedger1.RESET;
            RVBankAccountLedger1.SETCURRENTKEY("Bank Account No.","Document Type","Document No.");
            RVBankAccountLedger1.SETRANGE("Bank Account No." , "No.");
            RVBankAccountLedger1.SETFILTER("Posting Date" ,'<=%1', DVToDate);
            RVBankAccountLedger1.SETRANGE(Reversed,FALSE);
            RVBankAccountLedger1.SETFILTER("Statement No.",'> %1',BankAccStament."Statement No.");
            IF RVBankAccountLedger1.FIND('-') THEN
             REPEAT
              IF BankAccStament."Statement No." <> '' THEN
              BEGIN
                IF RVBankAccountLedger1.Amount > 0 THEN
                  DVAddDeposit1 := DVAddDeposit1 + RVBankAccountLedger1.Amount
                ELSE IF RVBankAccountLedger1.Amount < 0 THEN
                  DVUnPresented1 := DVUnPresented1 + RVBankAccountLedger1.Amount ;
              END;
             UNTIL  RVBankAccountLedger1.NEXT = 0;
            */
            //..

            RVBankAccountLedger.RESET;
            RVBankAccountLedger.SETCURRENTKEY("Bank Account No.", "Document Type", "Document No.");
            RVBankAccountLedger.SETRANGE("Bank Account No.", "No.");
            RVBankAccountLedger.SETFILTER("Posting Date", '<=%1', DVToDate); //NS
            RVBankAccountLedger.SETRANGE(Open, TRUE); //NS
            RVBankAccountLedger.SETRANGE(Reversed, FALSE);//GJ02/10/2015
            IF RVBankAccountLedger.FIND('-') THEN
                REPEAT
                    IF RVBankAccountLedger.Amount > 0 THEN
                        DVAddDeposit := DVAddDeposit + RVBankAccountLedger.Amount
                    ELSE
                        IF RVBankAccountLedger.Amount < 0 THEN
                            DVUnPresented := DVUnPresented + RVBankAccountLedger.Amount;
                UNTIL RVBankAccountLedger.NEXT = 0;

            DVUnPresented := DVUnPresented * -1;
            //DVUnPresented1 := DVUnPresented1 * -1;

            RVTempReport.INIT;
            RVTempReport.Code := '11';
            RVTempReport.SerialNo := 11;
            RVTempReport.Des := 'Add deposits not yet credited';
            RVTempReport.Qty := DVAddDeposit + DVAddDeposit1;
            RVTempReport.INSERT;
            COMMIT;

            RVTempReport.INIT;
            RVTempReport.Code := '12';
            RVTempReport.SerialNo := 12;
            RVTempReport.Des := '';
            DVBalnce := DVBalanceAsPerBank + DVAddDeposit + DVAddDeposit1;
            RVTempReport.Qty := DVBalnce;
            RVTempReport.TwoLine := TRUE;
            RVTempReport.INSERT;
            COMMIT;

            RVTempReport.INIT;
            RVTempReport.Code := '13';
            RVTempReport.SerialNo := 13;
            RVTempReport.Des := '';
            DVBLAnk := 0;
            RVTempReport.Qty := 0;
            RVTempReport.INSERT;
            COMMIT;

            RVTempReport.INIT;
            RVTempReport.Code := '14';
            RVTempReport.SerialNo := 14;
            RVTempReport.Des := 'Subtract unpresented cheques';
            RVTempReport.Qty := DVUnPresented + DVUnPresented1;
            RVTempReport.INSERT;
            COMMIT;

            RVTempReport.INIT;
            RVTempReport.Code := '15';
            RVTempReport.SerialNo := 15;
            RVTempReport.Des := 'Adjusted Balance';
            RVTempReport.Qty := DVBalnce - DVUnPresented - DVUnPresented1;
            RVTempReport.Bold := TRUE;
            RVTempReport.TwoLine := TRUE;
            RVTempReport.INSERT;
            COMMIT;

            RVBankReconSumm.testfun("No.", DVFromDate, DVToDate);
            RVBankReconSumm.RUNMODAL();

            CurrPage.CLOSE;
        END
        ELSE
            ERROR('Please Enter Date');

    end;


    procedure SetDataFields(FromDate: Date; ToDate: Date; BankCode: Code[20])
    begin
        "No." := BankCode;
        DVFromDate := FromDate;
        DVToDate := ToDate;
    end;
}

