report 50084 "GL Receipt"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/GLReceipt.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = WHERE("Bal. Account Type" = FILTER("G/L Account"));
            RequestFilterFields = "Document No.";
            column(date; "Bank Account Ledger Entry"."Posting Date")
            {
            }
            column(voucher_no; "Bank Account Ledger Entry"."Document No.")
            {
            }
            column(cheque_no; "Bank Account Ledger Entry"."External Document No.")
            {
            }
            column(amount; "Bank Account Ledger Entry".Amount)
            {
            }
            column(com_name; ComRec.Name)
            {
            }
            column(adress; ComRec.Address)
            {
            }
            column(city; ComRec.City)
            {
            }
            column(vat; ComRec."VAT Registration No.")
            {
            }
            column(acc_des; "Bank Account Ledger Entry".Description)
            {
            }
            column(AccNo; "Bank Account Ledger Entry"."Bank Account No.")
            {
            }
            column(no; GLaccRec."No.")
            {
            }
            column(bank_name; BankRec.Name)
            {
            }
            column(amount_text; TextAmount[1])
            {
            }
            column(glname; GLaccRec.Name)
            {
            }

            trigger OnAfterGetRecord()
            var
                CheckRep: Report Check;
            begin
                IF BankRec.GET("Bank Account No.") THEN;
                GLaccRec.SETRANGE("No.", "Bal. Account No.");
                IF GLaccRec.FINDSET THEN;
                SubTotal := SubTotal + Amount;
                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(TextAmount, SubTotal * -1, '');
            end;

            trigger OnPreDataItem()
            begin
                ComRec.GET;
                GLaccRec.RESET;
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
        ComRec: Record "Company Information";
        BankRec: Record "Bank Account";
        GLaccRec: Record "G/L Account";
        TextAmount: array[2] of Text[300];
        SubTotal: Decimal;
}

