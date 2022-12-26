tableextension 50047 DetailedCustLedEntry extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        // Add changes to table fields here
    }
    keys
    {
        key(FK; "Cust. Ledger Entry No.", "Entry Type", "Document Type", "Document No.")
        { }
    }
    var
        myInt: Integer;
}