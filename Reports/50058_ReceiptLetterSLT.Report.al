report 50058 "Receipt Letter - SLT"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ReceiptLetterSLT.rdl';

    dataset
    {
        dataitem(DataItem1; "Import Jobs")
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

