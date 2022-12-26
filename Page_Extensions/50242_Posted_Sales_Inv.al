pageextension 50242 PostedSalesInvExt extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Approvals)
        {
            action(InvoicePrint)
            {
                Caption = 'Invoice';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SalesInvHedd: Record "Sales Invoice Header";
                begin
                    SalesInvHedd.RESET;
                    SalesInvHedd.SETRANGE("No.", rec."No.");
                    SalesInvHedd.SETRANGE("Invoice Despatch No.", rec."Invoice Despatch No.");
                    IF NOT rec."Tube Sales Order" THEN BEGIN
                        REPORT.RUNMODAL(50005, TRUE, TRUE, SalesInvHedd);
                        REPORT.RUNMODAL(50085, TRUE, TRUE, SalesInvHedd);
                    END
                    ELSE BEGIN
                        REPORT.RUNMODAL(50045, TRUE, TRUE, SalesInvHedd);
                        REPORT.RUNMODAL(50087, TRUE, TRUE, SalesInvHedd);
                    END;
                end;
            }
        }
    }

}