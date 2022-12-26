pageextension 50238 PostedReturnReceipt extends "Posted Return Receipt"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Approvals)
        {
            action("Retutn Receipt")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    retunRecpHead: Record "Return Receipt Header";
                begin
                    retunRecpHead.Reset();
                    retunRecpHead.SetRange("No.", rec."No.");
                    Report.RunModal(50025, true, true, retunRecpHead);
                end;
            }
        }
    }

    var
        myInt: Integer;
}