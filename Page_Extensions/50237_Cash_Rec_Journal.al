pageextension 50237 CashRecJnalExt extends "Cash Receipt Journal"
{
    layout
    {
        addafter(Description)
        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}