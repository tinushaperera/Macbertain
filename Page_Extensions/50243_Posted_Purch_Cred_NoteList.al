pageextension 50243 PostedSalesCredList extends "Posted Sales Credit Memos"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Navigate")
        {
            action("Credit Note")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PurchCredHed: Record "Purch. Cr. Memo Hdr.";
                begin
                    PurchCredHed.Reset();
                    PurchCredHed.SetRange("No.", Rec."No.");
                    Report.RunModal(50020, true, true, PurchCredHed);
                end;
            }
        }
    }

    var
        myInt: Integer;
}