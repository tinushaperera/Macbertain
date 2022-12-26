tableextension 50056 TransferaLine extends "Transfer Line"
{
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                InventoryPostingGroup: Record "Inventory Posting Group";
                InventoryPostingSetup: Record "Inventory Posting Setup";
                CodeFind: Boolean;

            begin
                IF InventoryPostingGroup.GET("Inventory Posting Group") THEN
                    InventoryPostingSetup.RESET;
                InventoryPostingSetup.SETRANGE("Invt. Posting Group Code", InventoryPostingGroup.Code);
                IF InventoryPostingSetup.FINDFIRST THEN
                    REPEAT
                        IF "Transfer-to Code" = InventoryPostingSetup."Location Code" THEN
                            CodeFind := TRUE;
                    UNTIL InventoryPostingSetup.NEXT = 0;
                IF CodeFind = FALSE THEN
                    ERROR(Text014);
            end;
        }
    }

    var
        Text014: Label 'Please select correct Location Code.';
}