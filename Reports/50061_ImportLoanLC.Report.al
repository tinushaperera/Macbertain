report 50061 "Import Loan-LC"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ImportLoanLC.rdl';

    dataset
    {
        dataitem("Import Jobs"; "Import Jobs")
        {
            RequestFilterFields = "No.";
            column(VendName; BankRec.Name)
            {
            }
            column(VendAdd; BankRec.Address)
            {
            }
            column(VendAdd2; BankRec."Address 2")
            {
            }
            column(VendCity; BankRec.City)
            {
            }
            column(ComName; ComRec.Name)
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
            column(bnkNo; BankRec."Bank Account No.")
            {
            }
            column(ImpDate; FORMAT("Import Jobs".Date))
            {
            }
            column(lc; "Import Jobs"."LC No.")
            {
            }
            column(Currency; "Import Jobs".Currency)
            {
            }
            column(LCOpeningdate; FORMAT("Import Jobs"."LC Opening date"))
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

