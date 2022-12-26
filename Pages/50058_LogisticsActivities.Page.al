page 50058 "Logistics Activities"
{
    ApplicationArea = All;
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup(Payments)
            {
                Caption = 'Payments';
                field("Purchase Documents Due Today"; Rec."Purchase Documents Due Today")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Vendor Ledger Entries";
                }
                field("Vendors - Payment on Hold"; rec."Vendors - Payment on Hold")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Vendor List";
                }
                field("Purchase Return Orders"; rec."Purchase Return Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Return Order List";
                }

                actions
                {
                    action("Edit Payment Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Edit Payment Journal';
                        RunObject = Page "Payment Journal";
                    }
                    action("New Purchase Credit Memo")
                    {
                        ApplicationArea = All;
                        Caption = 'New Purchase Credit Memo';
                        RunObject = Page "Purchase Credit Memo";
                        RunPageMode = Create;
                    }
                    action("Edit Purchase Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Edit Purchase Journal';
                        RunObject = Page "Purchase Journal";
                    }
                }
            }
            cuegroup("Document Approvals")
            {
                Caption = 'Document Approvals';
                field("POs Pending Approval"; rec."POs Pending Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Order List";
                }
                field("Approved Purchase Orders"; rec."Approved Purchase Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Order List";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.RESET;
        IF NOT rec.GET THEN BEGIN
            rec.INIT;
            rec.INSERT;
        END;

        rec.SETFILTER("Due Date Filter", '<=%1', WORKDATE);
    end;
}

