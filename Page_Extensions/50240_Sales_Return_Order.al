pageextension 50240 SalesRtnOrd extends "Sales Return Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Release)
        {
            action(SRA)
            {
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeddRec: Record "Sales Header";
                begin
                    SalesHeddRec.RESET;
                    SalesHeddRec.SETRANGE("Document Type", rec."Document Type");
                    SalesHeddRec.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(50030, TRUE, TRUE, SalesHeddRec);
                end;
            }
            action("Credit Note")
            {
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeddRec: Record "Sales Header";
                begin
                    SalesHeddRec.RESET;
                    SalesHeddRec.SETRANGE("Document Type", rec."Document Type");
                    SalesHeddRec.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(50079, TRUE, TRUE, SalesHeddRec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}