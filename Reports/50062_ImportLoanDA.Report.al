report 50062 "Import Loan-DA"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ImportLoanDA.rdl';

    dataset
    {
        dataitem("Import Jobs"; "Import Jobs")
        {
            RequestFilterFields = "No.";
            column(VendName; BankRec.Name)
            {
            }
            column(BankAdd; BankRec.Address)
            {
            }
            column(BankAdd2; BankRec."Address 2")
            {
            }
            column(BankCity; BankRec.City)
            {
            }
            column(CompanyName; ComRec.Name)
            {
            }
            column(Amt; Amt)
            {
            }
            column(NoText; NoText[1])
            {
            }
            column(CalDate; FORMAT(CalDate))
            {
            }
            column(BankNo; BankRec."Bank Account No.")
            {
            }
            column(ImpDate; FORMAT("Import Jobs".Date))
            {
            }
            column(LCNo; "Import Jobs"."LC No.")
            {
            }
            column(ImportJobNo; "Import Jobs"."No.")
            {
            }
            column(Currency; "Import Jobs".Currency)
            {
            }
            column(BankBillNo; "Import Jobs"."Bank Bill No")
            {
            }

            trigger OnAfterGetRecord()
            var
                CheckReport: Report Check;
            begin
                VendRec.GET("Vendor No.");
                BankRec.GET(BankCode);
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoText, Amt, 'Only');
                CalDate := TODAY + 90;
            end;

            trigger OnPreDataItem()
            begin
                ComRec.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field("Bank Code"; BankCode)
                    {
                        TableRelation = "Bank Account";
                    }
                    field("Amount LKR"; Amt)
                    {
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ComRec: Record "Company Information";
        VendRec: Record Vendor;
        BankRec: Record "Bank Account";
        BankCode: Code[20];
        Amt: Decimal;
        NoText: array[2] of Text[200];
        CalDate: Date;
}

