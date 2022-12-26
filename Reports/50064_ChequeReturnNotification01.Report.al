report 50064 "Cheque Return Notification 01"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/ChequeReturnNotification01.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Refund),
                                      "Reason Code" = FILTER(<> ''));
            RequestFilterFields = "External Document No.", "Document No.";
            column(com_name; ComRec.Name)
            {
            }
            column(com_address; ComRec.Address)
            {
            }
            column(com_address2; ComRec."Address 2")
            {
            }
            column(com_phone; ComRec."Phone No.")
            {
            }
            column(com_email; ComRec."E-Mail")
            {
            }
            column(com_www; ComRec."Home Page")
            {
            }
            column(com_fax; ComRec."Fax No.")
            {
            }
            column(date; "Cust. Ledger Entry"."Due Date")
            {
            }
            column(cus_name; CusRec.Name)
            {
            }
            column(cus_address; CusRec.Address)
            {
            }
            column(cus_address2; CusRec."Address 2")
            {
            }
            column(cus_city; CusRec.City)
            {
            }
            column(cheque_no; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(bank_code; "Cust. Ledger Entry"."Bank Code")
            {
            }
            column(amount; Amoun_Text)
            {
            }
            column(bank_name; BankRec.Name)
            {
            }
            column(bank_accountno; BankRec."Bank Account No.")
            {
            }
            column(settlement_date; SettDateText)
            {
            }
            column(posting_date; PostDateText)
            {
            }
            column(reson_des; Reson.Description)
            {
            }
            column(com_city; ComRec.City)
            {
            }
            column(com_pic; ComRec.Picture)
            {
            }
            column(invoice_no; AppInvText)
            {
            }
            column(bank_dec2; ItemRefRec.Description)
            {
            }
            column(Branch_Dec; ItemRefRec2.Description)
            {
            }
            column(BackDatePostingDate; BackDatePostingDate)
            {
            }

            trigger OnAfterGetRecord()
            var
                CusLedEntry: Record "Cust. Ledger Entry";
                CusLedEntryGet: Record "Cust. Ledger Entry";
                DelCusLedEntry: Record "Detailed Cust. Ledg. Entry";
                SourceCodeSetup: Record "Source Code Setup";
            begin
                IF ComRec.GET THEN;
                IF CusRec.GET("Customer No.") THEN;
                IF BankRec.GET("Bal. Account No.") THEN;
                Reson.GET("Reason Code");
                //IF NOT Reson."Cheque Return - 2nd Instant" THEN
                // ERROR('Report Preview Error');

                ComRec.CALCFIELDS(Picture);
                CALCFIELDS(Amount);

                ItemRefRec.RESET;
                ItemRefRec.SETRANGE(Type, ItemRefRec.Type::"Bank Code");
                ItemRefRec.SETRANGE(Code, "Bank Code");
                IF ItemRefRec.FINDFIRST THEN;

                ItemRefRec2.RESET;
                ItemRefRec2.SETRANGE(Type, ItemRefRec.Type::"Branch Code");
                ItemRefRec2.SETRANGE(Code, "Branch Code");
                IF ItemRefRec2.FINDFIRST THEN;
                //Get Invoce nos
                CusLedEntry.RESET;
                CusLedEntry.SETCURRENTKEY("Document No.");
                CusLedEntry.SETRANGE("Document Type", CusLedEntry."Document Type"::Payment);
                CusLedEntry.SETRANGE("External Document No.", "External Document No.");
                //IF CusLedEntry.COUNT <> 1 THEN
                //ERROR('Refund can have one payment.');
                CusLedEntry.FINDSET;
                SourceCodeSetup.GET;
                AppInvText := '';
                DelCusLedEntry.SETCURRENTKEY("Document No.", "Source Code");
                DelCusLedEntry.SETRANGE("Source Code", SourceCodeSetup."Unapplied Sales Entry Appln.");
                REPEAT
                    DelCusLedEntry.SETRANGE("Document No.", CusLedEntry."Document No.");
                    IF DelCusLedEntry.FINDSET THEN
                        REPEAT
                            IF DelCusLedEntry."Cust. Ledger Entry No." <> CusLedEntry."Entry No." THEN BEGIN
                                CusLedEntryGet.GET(DelCusLedEntry."Cust. Ledger Entry No.");
                                IF AppInvText = '' THEN
                                    AppInvText := CusLedEntryGet."Document No."
                                ELSE
                                    AppInvText := AppInvText + ' , ' + CusLedEntryGet."Document No.";
                            END;
                        UNTIL DelCusLedEntry.NEXT = 0;
                UNTIL CusLedEntry.NEXT = 0;
                //
                Amoun_Text := FORMAT(Amount, 0, '<Precision,2:3><Standard Format,0>');
                //Date Format
                IF StDate <> 0D THEN
                    SettDateText := FORMAT(StDate, 0, '<Day,2>-<Month Text,3>-<Year>');
                IF "Posting Date" <> 0D THEN BEGIN
                    PostDateText := FORMAT("Posting Date", 0, '<Day,2>-<Month Text,3>-<Year>');
                    FutureDate := "Posting Date" + 14;
                    BackDatePostingDate := FORMAT(FutureDate, 0, '<Day,2>-<Month Text,3>-<Year>');
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    field(StDate; StDate)
                    {
                        Caption = 'Settlement Date';
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
        CusRec: Record Customer;
        BankRec: Record "Bank Account";
        Reson: Record "Reason Code";
        ItemRefRec: Record "Reference Data";
        ItemRefRec2: Record "Reference Data";
        StDate: Date;
        FutureDate: Date;
        BackDatePostingDate: Text;
        AppInvText: Text;
        Amoun_Text: Text[20];
        SettDateText: Text[15];
        PostDateText: Text[15];
}

