pageextension 50239 PostedPurchaseReceipt extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Approvals)
        {
            action(GRN)
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    purchReceptHeader: Record "Purch. Rcpt. Header";
                begin
                    purchReceptHeader.Reset();
                    purchReceptHeader.SetRange("No.", rec."No.");
                    Report.RunModal(50003, true, true, purchReceptHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}