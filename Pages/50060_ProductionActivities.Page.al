page 50060 "Production Activities"
{
    ApplicationArea = All;
    UsageCategory = Lists;
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
                field("Purchase Documents Due Today"; rec."Purchase Documents Due Today")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Vendor Ledger Entries";
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

