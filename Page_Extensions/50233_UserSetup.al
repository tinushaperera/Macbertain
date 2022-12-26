pageextension 50233 userSetup extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("Customer Approval"; Rec."Customer Approval")
            {
                ApplicationArea = All;
            }
            field("Transfer Order Approval"; Rec."Transfer Order Approval")
            {
                ApplicationArea = All;
            }
            field("Issue Note Approval"; Rec."Issue Note Approval")
            {
                ApplicationArea = All;
            }
            field("Check Print Approval"; Rec."Check Print Approval")
            {
                ApplicationArea = All;
            }
            field("Import Loan Notification"; Rec."Import Loan Notification")
            {
                ApplicationArea = All;
            }
            field("Short Term Laon Notification"; Rec."Short Term Laon Notification")
            {
                ApplicationArea = All;
            }
            field("Bank Guarantee Notification"; Rec."Bank Guarantee Notification")
            {
                ApplicationArea = All;
            }
            field("Promissory Note Notification"; Rec."Promissory Note Notification")
            {
                ApplicationArea = All;
            }
            field("Quantity Approved"; Rec."Quantity Approved")
            {
                ApplicationArea = All;
            }
            field("Hide Costing Data"; Rec."Hide Costing Data")
            {
                ApplicationArea = All;
            }
            field("Hide Master Data Fields"; Rec."Hide Master Data Fields")
            {
                ApplicationArea = All;
            }
            field("Sales Order Delete"; Rec."Sales Order Delete")
            {
                ApplicationArea = All;
            }
            field("Sales Ret. Order Line Editable"; Rec."Sales Ret. Order Line Editable")
            {
                ApplicationArea = All;
            }
            field("Excel Date Filter"; Rec."Excel Date Filter")
            {
                ApplicationArea = All;
            }
            field("Excel Date Filter 2"; Rec."Excel Date Filter 2")
            {
                ApplicationArea = All;
            }
            field("Default Excel Path"; Rec."Default Excel Path")
            {
                ApplicationArea = All;
            }
            field("Material Requestion Approval"; Rec."Material Requestion Approval")
            {
                ApplicationArea = All;
            }
            field("Activate Ship To Address"; Rec."Activate Ship To Address")
            {
                ApplicationArea = All;
            }
            field("Check Sales Header Approve"; Rec."Check Sales Header Approve")
            {
                ApplicationArea = All;
            }
            field("Fix Posting to Current Date"; Rec."Fix Posting to Current Date")
            {
                ApplicationArea = All;
            }
            field("Excel Global Dim 1 Filter"; Rec."Excel Global Dim 1 Filter")
            {
                ApplicationArea = All;
            }
            field("Excel Global Dim 2 Filter"; Rec."Excel Global Dim 2 Filter")
            {
                ApplicationArea = All;
            }
            field("Excel Territory Code Filter"; Rec."Excel Territory Code Filter")
            {
                ApplicationArea = All;
            }
            field("Excel Region Code Filter"; Rec."Excel Region Code Filter")
            {
                ApplicationArea = All;
            }
            field("Excel Salesperson Code Filter"; Rec."Excel Salesperson Code Filter")
            {
                ApplicationArea = All;
            }
            field("Sales Order Reopen Approvel"; Rec."Sales Order Reopen Approvel")
            {
                ApplicationArea = All;
            }
            field("Sales Order Delete Approvel"; Rec."Sales Order Delete Approvel")
            {
                ApplicationArea = All;
            }
            field("Reject Editable"; Rec."Reject Editable")
            {
                ApplicationArea = All;
            }
            field(Designation; Rec.Designation)
            {
                ApplicationArea = All;
            }
            field("Sales Order Editable"; Rec."Sales Order Editable")
            {
                ApplicationArea = All;
            }
            field("Inv. Reprint"; Rec."Inv. Reprint")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}