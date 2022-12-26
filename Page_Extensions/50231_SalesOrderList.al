pageextension 50231 SalesOrderList extends "Sales Orders"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CheckUser; //RJ
    end;

    local procedure CheckUser()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."Sales Order Delete" THEN
            ERROR('You do not have permission to delete Sales Orders');

    end;

    var
        myInt: Integer;
}