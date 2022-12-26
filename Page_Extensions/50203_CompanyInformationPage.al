pageextension 50203 CompanyInforPage extends "Company Information"
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field("SVAT Pecerntage(%)"; Rec."SVAT Pecerntage(%)")
            {
                ApplicationArea = All;
                Caption = 'SVAT %';
            }
            field("SVAT No."; Rec."SVAT No.")
            {
                ApplicationArea = All;
            }
        }
        modify(GLN)
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}