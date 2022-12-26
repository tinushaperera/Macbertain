pageextension 50224 PurchaseOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        modify("Variant Code")
        {
            Visible = true;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        // modify("Direct Unit Cost")
        // {
        //     Visible = HideValues;
        // }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Editable = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        HideCostingValues;
    end;

    var
        UserSetup: Record "User Setup";
        HideValues: Boolean;

    local procedure HideCostingValues()
    begin
        UserSetup.GET(USERID);
        HideValues := UserSetup."Hide Costing Data";
    end;
}