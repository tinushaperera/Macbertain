report 50055 "Debit Note-Cheque Return/Charg"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/DebitNoteChequeReturnCharg.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Document No.";
            column(DebtNo; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(Date; "Cust. Ledger Entry"."Posting Date")
            {
            }
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
            column(ComName; ComRec.Name)
            {
            }
            column(RepName; SalesRep.Name)
            {
            }
            column(Amt; "Cust. Ledger Entry".Amount)
            {
            }
            column(Narr; "Cust. Ledger Entry".Narration)
            {
            }
            column(Dim_Code; DimensionValue.Code)
            {
            }
            column(Dim_Name; DimensionValue.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF SalesRep.GET("Salesperson Code") THEN;
                CusRec.GET("Cust. Ledger Entry"."Customer No.");
                CALCFIELDS(Amount);


                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, "Global Dimension 1 Code");
                IF DimensionValue.FINDFIRST THEN;
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
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesRep: Record "Salesperson/Purchaser";
        ComRec: Record "Company Information";
        CusRec: Record Customer;
        DimensionValue: Record "Dimension Value";
}

