pageextension 50241 PurchPaybleSetup extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {

            field("Import Job Nos."; Rec."Import Job Nos.")
            {
                ApplicationArea = All;

            }
            field("Shipping Guarentee Nos."; Rec."Shipping Guarentee Nos.")
            {
                ApplicationArea = All;

            }
            field("Container Deposit Nos."; Rec."Container Deposit Nos.")
            {
                ApplicationArea = All;

            }
            field("Import Loan Nos."; Rec."Import Loan Nos.")
            {
                ApplicationArea = All;

            }
            field("Import Order Nos."; Rec."Import Order Nos.")
            {
                ApplicationArea = All;

            }
            field("Loan Order Nos."; Rec."Loan Order Nos.")
            {
                ApplicationArea = All;

            }
            field("Loan Return Order Nos."; Rec."Loan Return Order Nos.")
            {
                ApplicationArea = All;

            }
            field("STL Nos."; Rec."STL Nos.")
            {
                ApplicationArea = All;

            }
        }
        addlast(General)
        {

            field("Import Jobs Entry Type"; Rec."Import Jobs Entry Type")
            {
                ApplicationArea = All;

            }
        }




    }

}