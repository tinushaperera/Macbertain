report 50020 "Debit Note-Purchase Return"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/DebitNotePurchaseReturn.rdl';

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "No.";
            column(DebtNo; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(Date; "Purch. Cr. Memo Hdr."."Posting Date")
            {
            }
            column(CusName; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
            {
            }
            column(CusAdd; "Purch. Cr. Memo Hdr."."Buy-from Address")
            {
            }
            column(CusAdd2; "Purch. Cr. Memo Hdr."."Buy-from Address 2")
            {
            }
            column(CusCity; "Purch. Cr. Memo Hdr."."Buy-from City")
            {
            }
            column(ComName; ComRec.Name)
            {
            }
            column(Amt; "Purch. Cr. Memo Hdr.".Amount)
            {
            }
            column(AmtIncVAT; "Purch. Cr. Memo Hdr."."Amount Including VAT")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(InvNo; "Purch. Cr. Memo Hdr."."Applies-to Doc. No.")
            {
            }
            column(DateINV; PurchInvHdd."Posting Date")
            {
            }
            column(Remarks; "Purch. Cr. Memo Hdr.".Remarks)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Currency Code" = '' THEN
                    CurrCode := 'LKR'
                ELSE
                    CurrCode := "Currency Code";
                IF PurchInvHdd.GET("Applies-to Doc. No.") THEN;
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
        PurchInvHdd: Record "Purch. Inv. Header";
        ComRec: Record "Company Information";
        CurrCode: Code[10];
}

