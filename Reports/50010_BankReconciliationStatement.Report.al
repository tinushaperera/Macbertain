report 50010 "Bank Reconciliation Statement"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/BankReconciliationStatement.rdl';

    dataset
    {
        dataitem("Bank Reconciliation Statement"; "Bank Reconciliation Statement")
        {
            DataItemTableView = SORTING(SerialNo)
                                ORDER(Ascending);
            column(Testbank; Testbank)
            {
            }
            column(TVName; TVName)
            {
            }
            column(TVAcc; TVAcc)
            {
            }
            column(fdate; FORMAT(fdate))
            {
            }
            column(tdate; FORMAT(tdate))
            {
            }
            column(Qty; Qty)
            {
            }
            column(Des; Des)
            {
            }
            column(Date; FORMAT(TODAY, 0, 4))
            {
            }
            column(User; USERID)
            {
            }
            column(PageNo; CurrReport.PAGENO)
            {
            }
            column(CompanyName; CompRec.Name)
            {
            }
            column(ReBold; Bold)
            {
            }
            column(ReUnderline; Underline)
            {
            }
            column(SatementNo; SatementNo)
            {
            }
            column(TwoLine; TwoLine)
            {
            }

            trigger OnPreDataItem()
            begin
                IF CompRec.GET THEN;
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
        BankAccStament: Record "Bank Account Statement";
        DVFromDate: Date;
        DVToDate: Date;
        Testbank: Code[20];
        fdate: Date;
        tdate: Date;
        RVBank: Record "Bank Account";
        TVName: Text[40];
        TVAcc: Text[30];
        CompRec: Record "Company Information";
        SatementNo: Code[20];


    procedure testfun(bank: Code[20]; Fromdate: Date; Todate: Date)
    begin
        Testbank := bank;
        fdate := Fromdate;
        tdate := Todate;

        RVBank.SETRANGE(RVBank."No.", bank);
        IF RVBank.FIND('-') THEN BEGIN
            TVName := RVBank.Name;
            TVAcc := RVBank."Bank Account No.";
        END;

        BankAccStament.RESET;
        BankAccStament.ASCENDING(TRUE);
        BankAccStament.SETRANGE("Bank Account No.", Testbank);
        BankAccStament.SETRANGE("Statement Date", fdate, tdate);
        IF BankAccStament.FINDLAST THEN BEGIN
            SatementNo := BankAccStament."Statement No.";
        END;
    end;
}

