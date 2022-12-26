pageextension 50219 ItemLedEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Variant Code")
        {
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Sales Order No."; Rec."Sales Order No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Sales Invoice No."; Rec."Sales Invoice No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field("Import Job No."; Rec."Import Job No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Completely Invoiced")
        {
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
            }
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }
        }
        addafter(Open)
        {
            field(Correction; Rec.Correction)
            {
                ApplicationArea = All;
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        modify("Return Reason Code")
        {
            Visible = true;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }
        modify("Shipped Qty. Not Returned")
        {
            Visible = true;
        }
        modify("Reserved Quantity")
        {
            Visible = true;
        }
        modify("Sales Amount (Expected)")
        {
            Visible = true;
        }
        modify("Cost Amount (Expected)")
        {
            Visible = true;
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            Visible = false;
        }
        modify("Completely Invoiced")
        {
            Visible = true;
        }
    }

    actions
    {
        modify("&Value Entries")
        {
            Promoted = true;
        }
        modify("Applied E&ntries")
        {
            Promoted = true;
        }
    }

    var
        myInt: Integer;
}