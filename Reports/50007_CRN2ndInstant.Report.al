report 50007 "CRN 2nd Instant"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CRN2ndInstant.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Refund));
            RequestFilterFields = "Document No.";
            column(CusName; CusRec.Name)
            {
            }
            column(CusAdd; CusRec.Address)
            {
            }
            column(CusAdd2; CusRec."Address 2")
            {
            }
            column(CusCity; CusRec.City)
            {
            }
            column(Che; "Gen. Journal Line"."External Document No.")
            {
            }
            column(BankName; BankAcc.Name)
            {
            }
            column(BCity; BankAcc.City)
            {
            }
            column(Amt; "Gen. Journal Line".Amount)
            {
            }
            column(Doc; "Gen. Journal Line"."Document No.")
            {
            }
            column(Comadd; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(ComCity; ComRec.City)
            {
            }
            column(reson; ReturnReson.Description)
            {
            }
            column(ComN; ComRec.Name)
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(BankCode; RefData1.Description)
            {
            }
            column(Branch; RefData2.Description)
            {
            }
            column(BankBranch; "Gen. Journal Line"."Bank Branch Name")
            {
            }
            column(Date; "Gen. Journal Line"."Posting Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF CusRec.GET("Account No.") THEN;
                IF BankAcc.GET("Bal. Account No.") THEN;
                IF ReturnReson.GET("Gen. Journal Line"."Reason Code") THEN;
                IF RefData1.GET(RefData1.Type::"Bank Code", "Bank Code") THEN;
                IF RefData2.GET(RefData2.Type::"Branch Code", "Branch Code") THEN;
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
                    field("Entry No."; EntyNo)
                    {
                        TableRelation = "Cust. Ledger Entry"."Entry No." WHERE("Document Type" = CONST(Refund));

                        trigger OnValidate()
                        var
                            CustLedRec: Record "Cust. Ledger Entry";
                        begin
                            CustLedRec.GET(EntyNo);
                            DocNo := CustLedRec."Document No.";
                        end;
                    }
                    field("Document No."; DocNo)
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
        CusRec: Record Customer;
        BankAcc: Record "Bank Account";
        ComRec: Record "Company Information";
        ReturnReson: Record "Reason Code";
        RefData1: Record "Reference Data";
        RefData2: Record "Reference Data";
        DocNo: Code[20];
        EntyNo: Integer;
        Caldate: Text;
        ActDate: Date;
        Caldate1: Date;
}

