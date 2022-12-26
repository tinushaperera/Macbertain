tableextension 50054 StockKeepingUnit extends "Stockkeeping Unit"
{
    fields
    {
        field(50000; "SKU Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }


    [Scope('Cloud')]
    procedure SetItemSKUCost(ItemCode: Code[20])
    var
        SKURec: Record "Stockkeeping Unit";
    begin
        SKURec.RESET;
        SKURec.SETFILTER("Item No.", ItemCode);
        IF SKURec.FINDSET THEN
            REPEAT
                IF (SKURec."Last Direct Cost" <> SKURec."SKU Unit Cost") THEN BEGIN
                    SKURec."Last Direct Cost" := SKURec."SKU Unit Cost";
                    SKURec.MODIFY;
                END;
            UNTIL SKURec.NEXT = 0;
    end;

    [Scope('Cloud')]
    procedure GetItemSKUCost(ItemCode: Code[20]; VariantCode: Code[10]; Loaction: Code[10]): Decimal
    var
        SKU: Record "Stockkeeping Unit";
    begin
        IF SKU.GET(Loaction, ItemCode, VariantCode) THEN
            EXIT(SKU."SKU Unit Cost")
        ELSE
            EXIT(0);
    end;

    var
        myInt: Integer;
}