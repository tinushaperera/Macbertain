page 50028 "Product Categories"
{
    UsageCategory = Lists;
    PageType = Worksheet;
    SourceTable = "Product Category";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            field(ProdCatCode; ProdCatCode)
            {
                ApplicationArea = all;
                TableRelation = "Reference Data".Code WHERE(Type = CONST("Product Category"));

                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD;
                    FilterRecords(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            repeater(Group)
            {
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PrdCat: Record "Reference Data";
    begin
        rec."Product Category Code" := ProdCatCode;
        IF PrdCat.GET(PrdCat.Type::"Product Category", ProdCatCode) THEN
            rec."Global Dimension 1 Code" := PrdCat."Global Dimension 1 Code";
    end;

    trigger OnOpenPage()
    begin
        FilterRecords(Rec);
        CurrPage.UPDATE(FALSE);
    end;

    var
        ProdCatCode: Code[30];

    local procedure FilterRecords(var ProdCatRec: Record "Product Category")
    begin
        ProdCatRec.FILTERGROUP := 2;
        ProdCatRec.SETRANGE("Product Category Code", ProdCatCode);
        ProdCatRec.FILTERGROUP := 0;
        IF ProdCatRec.FIND('-') THEN;
    end;
}

