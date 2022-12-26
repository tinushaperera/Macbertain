report 50060 "Receipt Letter-DA"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ReceiptLetterDA.rdl';

    dataset
    {
        dataitem("Import Jobs"; "Import Jobs")
        {
            RequestFilterFields = "No.";
            column(Amt; Amt)
            {
            }
            column(NoText; NoText[1])
            {
            }
            column(Bname; BankRec.Name)
            {
            }
            column(Currency; "Import Jobs".Currency)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NoText, Amt, 'Only');
                BankRec.GET(BankCode);
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
                    field(Amount; Amt)
                    {
                    }
                    field("Bank Code"; BankCode)
                    {
                        TableRelation = "Bank Account";
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
        Amt: Decimal;
        CheckReport: Report Check;
        NoText: array[2] of Text[200];
        BankCode: Code[20];
        BankRec: Record "Bank Account";
}

