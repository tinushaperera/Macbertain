codeunit 50001 "Get Apply Entries"
{

    trigger OnRun()
    begin
    end;


    procedure GetAppliedEntries(PassCusLedEntry: Record "Cust. Ledger Entry"; var AppCusLedEntry: Record "Cust. Ledger Entry")
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
    begin
        AppCusLedEntry.RESET;
        IF PassCusLedEntry."Entry No." <> 0 THEN BEGIN
            //FindApplnEntriesDtldtLedgEntry;
            DtldCustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
            DtldCustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", PassCusLedEntry."Entry No.");
            DtldCustLedgEntry1.SETRANGE(Unapplied, FALSE);
            IF DtldCustLedgEntry1.FIND('-') THEN
                REPEAT
                    IF DtldCustLedgEntry1."Cust. Ledger Entry No." =
                       DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                    THEN BEGIN
                        DtldCustLedgEntry2.INIT;
                        DtldCustLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                        DtldCustLedgEntry2.SETRANGE(
                          "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                        DtldCustLedgEntry2.SETRANGE("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                        DtldCustLedgEntry2.SETRANGE(Unapplied, FALSE);
                        IF DtldCustLedgEntry2.FIND('-') THEN
                            REPEAT
                                IF DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                                   DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                                THEN BEGIN
                                    AppCusLedEntry.SETCURRENTKEY("Entry No.");
                                    AppCusLedEntry.SETRANGE("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                    IF AppCusLedEntry.FIND('-') THEN
                                        AppCusLedEntry.MARK(TRUE);
                                END;
                            UNTIL DtldCustLedgEntry2.NEXT = 0;
                    END ELSE BEGIN
                        AppCusLedEntry.SETCURRENTKEY("Entry No.");
                        AppCusLedEntry.SETRANGE("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                        IF AppCusLedEntry.FIND('-') THEN
                            AppCusLedEntry.MARK(TRUE);
                    END;
                UNTIL DtldCustLedgEntry1.NEXT = 0;
            //
            AppCusLedEntry.SETCURRENTKEY("Entry No.");
            AppCusLedEntry.SETRANGE("Entry No.");

            IF AppCusLedEntry."Closed by Entry No." <> 0 THEN BEGIN
                AppCusLedEntry."Entry No." := PassCusLedEntry."Closed by Entry No.";
                AppCusLedEntry.MARK(TRUE);
            END;

            AppCusLedEntry.SETCURRENTKEY("Closed by Entry No.");
            AppCusLedEntry.SETRANGE("Closed by Entry No.", PassCusLedEntry."Entry No.");
            IF AppCusLedEntry.FIND('-') THEN
                REPEAT
                    AppCusLedEntry.MARK(TRUE);
                UNTIL AppCusLedEntry.NEXT = 0;

            AppCusLedEntry.SETCURRENTKEY("Entry No.");
            AppCusLedEntry.SETRANGE("Closed by Entry No.");
        END;
        AppCusLedEntry.MARKEDONLY(TRUE);
    end;
}

