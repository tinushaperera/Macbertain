page 50067 "Inv. Val.-Variants Report Filt"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Sales Targets";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(InvPostGrpFilter; InvPostGrpFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Posting Group';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        InvPostGrp: Record "Inventory Posting Group";
                    begin
                        InvPostGrp.RESET;
                        IF PAGE.RUNMODAL(112, InvPostGrp) = ACTION::LookupOK THEN
                            InvPostGrpFilter := InvPostGrp.Code;
                    end;

                    trigger OnValidate()
                    var
                        InvPostGrp: Record "Inventory Posting Group";
                    begin
                        IF InvPostGrpFilter <> '' THEN
                            InvPostGrp.GET(InvPostGrpFilter);
                    end;
                }
                field(NoFilter; NoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                    begin
                        Item.RESET;
                        Item.SETFILTER("Inventory Posting Group", InvPostGrpFilter);
                        IF PAGE.RUNMODAL(31, Item) = ACTION::LookupOK THEN
                            NoFilter := Item."No.";
                    end;

                    trigger OnValidate()
                    var
                        Item: Record Item;
                    begin
                        IF NoFilter <> '' THEN
                            Item.GET(NoFilter);
                    end;
                }
                field(VarCodeFilter; VarCodeFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Variant Code';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemVari: Record "Item Variant";
                    begin
                        ItemVari.RESET;
                        ItemVari.SETFILTER("Item No.", NoFilter);
                        IF PAGE.RUNMODAL(5401, ItemVari) = ACTION::LookupOK THEN
                            VarCodeFilter := ItemVari.Code;
                    end;

                    trigger OnValidate()
                    var
                        ItemVari: Record "Item Variant";
                    begin
                        IF (NoFilter <> '') AND (VarCodeFilter <> '') THEN
                            ItemVari.GET(NoFilter, VarCodeFilter);
                    end;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Inv Valuation Variant Report")
            {
                ApplicationArea = All;
                Caption = 'Inventory Valuation-Variant';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InvVal: Record "Inventory Valuation";
                    ItemRec: Record Item;
                    ItemVariant: Record "Item Variant";
                    ItemCat: Record "Item Category";
                    ProdGroup: Record "MCB Product Group";
                    DialogBox: Dialog;
                begin
                    //Delete Data
                    InvVal.RESET;
                    InvVal.SETRANGE("User ID", USERID);
                    IF InvVal.FINDSET THEN
                        InvVal.DELETEALL;
                    //Insert Data
                    DialogBox.OPEN('Item No #1#######\Variant Code #2#######');
                    ItemRec.RESET;
                    ItemRec.SETFILTER("No.", NoFilter);
                    ItemRec.SETFILTER("Inventory Posting Group", InvPostGrpFilter);
                    IF ItemRec.FINDSET THEN
                        REPEAT
                            ItemVariant.RESET;
                            ItemVariant.SETRANGE("Item No.", ItemRec."No.");
                            ItemVariant.SETFILTER(Code, VarCodeFilter);
                            IF ItemVariant.FINDSET THEN BEGIN
                                REPEAT
                                    DialogBox.UPDATE(1, ItemRec."No.");
                                    DialogBox.UPDATE(2, ItemVariant.Code);
                                    InvVal.INIT;
                                    InvVal."No." := ItemRec."No.";
                                    InvVal."Variant Code" := ItemVariant.Code;
                                    InvVal."Inventory Posting Group" := ItemRec."Inventory Posting Group";
                                    InvVal."Statistics Group" := ItemRec."Statistics Group";
                                    InvVal."Assembly BOM" := ItemRec."Assembly BOM";
                                    InvVal.Description := ItemRec.Description;
                                    InvVal."Base Unit of Measure" := ItemRec."Base Unit of Measure";
                                    //InvVal."Size Description" := ItemVariant."Size Description";
                                    //InvVal."Color Description" := ItemVariant."Color Description";
                                    IF ItemCat.GET(ItemRec."Item Category Code") THEN
                                        InvVal."Item Cat. Description" := ItemCat.Description;
                                    IF ProdGroup.GET(ItemRec."Item Category Code",
                                        ItemRec."MCB Product Group Code") THEN
                                        InvVal."Product Group Description" := ProdGroup.Description;
                                    InvVal."User ID" := USERID;
                                    InvVal.INSERT;
                                UNTIL ItemVariant.NEXT = 0;
                            END
                            ELSE BEGIN
                                DialogBox.UPDATE(1, ItemRec."No.");
                                DialogBox.UPDATE(2, '');
                                InvVal.INIT;
                                InvVal."No." := ItemRec."No.";
                                InvVal."Inventory Posting Group" := ItemRec."Inventory Posting Group";
                                InvVal."Statistics Group" := ItemRec."Statistics Group";
                                InvVal."Assembly BOM" := ItemRec."Assembly BOM";
                                InvVal.Description := ItemRec.Description;
                                InvVal."Base Unit of Measure" := ItemRec."Base Unit of Measure";
                                IF ItemCat.GET(ItemRec."Item Category Code") THEN
                                    InvVal."Item Cat. Description" := ItemCat.Description;
                                IF ProdGroup.GET(ItemRec."Item Category Code",
                                    ItemRec."MCB Product Group Code") THEN
                                    InvVal."Product Group Description" := ProdGroup.Description;
                                InvVal."User ID" := USERID;
                                InvVal.INSERT;
                            END;
                        UNTIL ItemRec.NEXT = 0;
                    DialogBox.CLOSE;
                    COMMIT;
                    REPORT.RUNMODAL(50092, TRUE, TRUE);
                end;
            }
            action("Item Age Variant Report")
            {
                ApplicationArea = All;
                Caption = 'Item Age Composition Value Variant Report';
                Image = ValueLedger;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    InvVal: Record "Inventory Valuation";
                    ItemRec: Record Item;
                    ItemVariant: Record "Item Variant";
                    ItemCat: Record "Item Category";
                    ProdGroup: Record "MCB Product Group";
                    DialogBox: Dialog;
                begin
                    /*//Delete Data
                    InvVal.RESET;
                    InvVal.SETRANGE("User ID",USERID);
                    IF InvVal.FINDSET THEN
                      InvVal.DELETEALL;
                    
                    //Insert Data
                    DialogBox.OPEN('Item No #1#######\Variant Code #2#######');
                    
                    ItemRec.RESET;
                    ItemRec.SETFILTER("No.",NoFilter);
                    ItemRec.SETFILTER("Inventory Posting Group",InvPostGrpFilter);
                    IF ItemRec.FINDSET THEN
                    REPEAT
                      ItemVariant.RESET;
                      ItemVariant.SETRANGE("Item No.",ItemRec."No.");
                      ItemVariant.SETFILTER(Code,VarCodeFilter);
                      IF ItemVariant.FINDSET THEN BEGIN
                        REPEAT
                          DialogBox.UPDATE(1,ItemRec."No.");
                          DialogBox.UPDATE(2,ItemVariant.Code);
                          InvVal.INIT;
                          InvVal."Target Year" := ItemRec."No.";
                          InvVal."Target Month" := ItemVariant.Code;
                          InvVal.Designation := ItemRec."Inventory Posting Group";
                          InvVal."Territory Code" := ItemRec."Statistics Group";
                          InvVal."Product Category Code" := ItemRec."Assembly BOM";
                          InvVal."Target Value" := ItemRec.Description;
                          InvVal.Indentation := ItemRec."Base Unit of Measure";
                      //    InvVal."Size Description" := ItemVariant."Size Description";
                     //     InvVal."Color Description" := ItemVariant."Color Description";
                          IF ItemCat.GET(ItemRec."Item Category Code") THEN
                            InvVal."Item Cat. Description" := ItemCat.Description;
                          IF ProdGroup.GET(ItemRec."Item Category Code",
                              ItemRec."Product Group Code") THEN
                            InvVal."Product Group Description" := ProdGroup.Description;
                          InvVal."User ID" := USERID;
                          InvVal.INSERT;
                        UNTIL ItemVariant.NEXT = 0;
                      END
                      ELSE BEGIN
                        DialogBox.UPDATE(1,ItemRec."No.");
                        DialogBox.UPDATE(2,'');
                        InvVal.INIT;
                        InvVal."Target Year" := ItemRec."No.";
                        InvVal.Designation := ItemRec."Inventory Posting Group";
                        InvVal."Territory Code" := ItemRec."Statistics Group";
                        InvVal."Product Category Code" := ItemRec."Assembly BOM";
                        InvVal."Target Value" := ItemRec.Description;
                        InvVal.Indentation := ItemRec."Base Unit of Measure";
                        IF ItemCat.GET(ItemRec."Item Category Code") THEN
                          InvVal."Item Cat. Description" := ItemCat.Description;
                        IF ProdGroup.GET(ItemRec."Item Category Code",
                            ItemRec."Product Group Code") THEN
                          InvVal."Product Group Description" := ProdGroup.Description;
                        InvVal."User ID" := USERID;
                        InvVal.INSERT;
                    
                      END;
                    UNTIL ItemRec.NEXT = 0;
                    DialogBox.CLOSE;
                    COMMIT;
                    REPORT.RUNMODAL(50023,TRUE,TRUE);*/

                end;
            }
            action("Item Age Composition Qty- Variant")
            {
                ApplicationArea = All;
                Caption = 'Item Age Composition Qty- Variant';
                Image = ValueLedger;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                var
                    InvVal: Record "Inventory Valuation";
                    ItemRec: Record Item;
                    ItemVariant: Record "Item Variant";
                    ItemCat: Record "Item Category";
                    ProdGroup: Record "MCB Product Group";
                    DialogBox: Dialog;
                begin
                    //Delete Data
                    InvVal.RESET;
                    InvVal.SETRANGE("User ID", USERID);
                    IF InvVal.FINDSET THEN
                        InvVal.DELETEALL;

                    //Insert Data
                    DialogBox.OPEN('Item No #1#######\Variant Code #2#######');
                    ItemRec.RESET;
                    ItemRec.SETFILTER("No.", NoFilter);
                    ItemRec.SETFILTER("Inventory Posting Group", InvPostGrpFilter);
                    IF ItemRec.FINDSET THEN
                        REPEAT
                            ItemVariant.RESET;
                            ItemVariant.SETRANGE("Item No.", ItemRec."No.");
                            ItemVariant.SETFILTER(Code, VarCodeFilter);
                            IF ItemVariant.FINDSET THEN BEGIN
                                REPEAT
                                    DialogBox.UPDATE(1, ItemRec."No.");
                                    DialogBox.UPDATE(2, ItemVariant.Code);
                                    InvVal.INIT;
                                    InvVal."No." := ItemRec."No.";
                                    InvVal."Variant Code" := ItemVariant.Code;
                                    InvVal."Inventory Posting Group" := ItemRec."Inventory Posting Group";
                                    InvVal."Statistics Group" := ItemRec."Statistics Group";
                                    InvVal."Assembly BOM" := ItemRec."Assembly BOM";
                                    InvVal.Description := ItemRec.Description;
                                    InvVal."Base Unit of Measure" := ItemRec."Base Unit of Measure";
                                    //   InvVal."Size Description" := ItemVariant."Size Description";
                                    //   InvVal."Color Description" := ItemVariant."Color Description";
                                    IF ItemCat.GET(ItemRec."Item Category Code") THEN
                                        InvVal."Item Cat. Description" := ItemCat.Description;
                                    IF ProdGroup.GET(ItemRec."Item Category Code",
                                        ItemRec."MCB Product Group Code") THEN
                                        InvVal."Product Group Description" := ProdGroup.Description;
                                    InvVal."User ID" := USERID;
                                    InvVal.INSERT;
                                UNTIL ItemVariant.NEXT = 0;
                            END
                            ELSE BEGIN
                                DialogBox.UPDATE(1, ItemRec."No.");
                                DialogBox.UPDATE(2, '');
                                InvVal.INIT;
                                InvVal."No." := ItemRec."No.";
                                InvVal."Variant Code" := ItemVariant.Code;
                                InvVal."Inventory Posting Group" := ItemRec."Inventory Posting Group";
                                InvVal."Statistics Group" := ItemRec."Statistics Group";
                                InvVal."Assembly BOM" := ItemRec."Assembly BOM";
                                InvVal.Description := ItemRec.Description;
                                InvVal."Base Unit of Measure" := ItemRec."Base Unit of Measure";
                                IF ItemCat.GET(ItemRec."Item Category Code") THEN
                                    InvVal."Item Cat. Description" := ItemCat.Description;
                                IF ProdGroup.GET(ItemRec."Item Category Code",
                                    ItemRec."MCB Product Group Code") THEN
                                    InvVal."Product Group Description" := ProdGroup.Description;
                                InvVal."User ID" := USERID;
                                InvVal.INSERT;

                            END;
                        UNTIL ItemRec.NEXT = 0;
                    DialogBox.CLOSE;
                    COMMIT;
                    REPORT.RUNMODAL(50011, TRUE, TRUE);
                end;
            }
            action("Item Age Composition Value- Variant")
            {
                ApplicationArea = All;
                Caption = 'Item Age Composition Value- Variant';
                Image = ValueLedger;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                var
                    InvVal: Record "Inventory Valuation";
                    ItemRec: Record Item;
                    ItemVariant: Record "Item Variant";
                    ItemCat: Record "Item Category";
                    ProdGroup: Record "MCB Product Group";
                    DialogBox: Dialog;
                begin
                    //Delete Data
                    InvVal.RESET;
                    InvVal.SETRANGE("User ID", USERID);
                    IF InvVal.FINDSET THEN
                        InvVal.DELETEALL;

                    //Insert Data
                    DialogBox.OPEN('Item No #1#######\Variant Code #2#######');
                    ItemRec.RESET;
                    ItemRec.SETFILTER("No.", NoFilter);
                    ItemRec.SETFILTER("Inventory Posting Group", InvPostGrpFilter);
                    IF ItemRec.FINDSET THEN
                        REPEAT
                            ItemVariant.RESET;
                            ItemVariant.SETRANGE("Item No.", ItemRec."No.");
                            ItemVariant.SETFILTER(Code, VarCodeFilter);
                            IF ItemVariant.FINDSET THEN BEGIN
                                REPEAT
                                    DialogBox.UPDATE(1, ItemRec."No.");
                                    DialogBox.UPDATE(2, ItemVariant.Code);
                                    InvVal.INIT;
                                    InvVal."No." := ItemRec."No.";
                                    InvVal."Variant Code" := ItemVariant.Code;
                                    InvVal."Inventory Posting Group" := ItemRec."Inventory Posting Group";
                                    InvVal."Statistics Group" := ItemRec."Statistics Group";
                                    InvVal."Assembly BOM" := ItemRec."Assembly BOM";
                                    InvVal.Description := ItemRec.Description;
                                    InvVal."Base Unit of Measure" := ItemRec."Base Unit of Measure";
                                    //    InvVal."Size Description" := ItemVariant."Size Description";
                                    //      InvVal."Color Description" := ItemVariant."Color Description";
                                    IF ItemCat.GET(ItemRec."Item Category Code") THEN
                                        InvVal."Item Cat. Description" := ItemCat.Description;
                                    IF ProdGroup.GET(ItemRec."Item Category Code",
                                        ItemRec."MCB Product Group Code") THEN
                                        InvVal."Product Group Description" := ProdGroup.Description;
                                    InvVal."User ID" := USERID;
                                    InvVal.INSERT;
                                UNTIL ItemVariant.NEXT = 0;
                            END
                            ELSE BEGIN
                                DialogBox.UPDATE(1, ItemRec."No.");
                                DialogBox.UPDATE(2, '');
                                InvVal.INIT;
                                InvVal."No." := ItemRec."No.";
                                InvVal."Variant Code" := ItemVariant.Code;
                                InvVal."Inventory Posting Group" := ItemRec."Inventory Posting Group";
                                InvVal."Statistics Group" := ItemRec."Statistics Group";
                                InvVal."Assembly BOM" := ItemRec."Assembly BOM";
                                InvVal.Description := ItemRec.Description;
                                InvVal."Base Unit of Measure" := ItemRec."Base Unit of Measure";
                                IF ItemCat.GET(ItemRec."Item Category Code") THEN
                                    InvVal."Item Cat. Description" := ItemCat.Description;
                                IF ProdGroup.GET(ItemRec."Item Category Code",
                                    ItemRec."MCB Product Group Code") THEN
                                    InvVal."Product Group Description" := ProdGroup.Description;
                                InvVal."User ID" := USERID;
                                InvVal.INSERT;

                            END;
                        UNTIL ItemRec.NEXT = 0;
                    DialogBox.CLOSE;
                    COMMIT;
                    REPORT.RUNMODAL(50028, TRUE, TRUE);
                end;
            }
        }
    }

    var
        InvPostGrpFilter: Code[250];
        NoFilter: Code[250];
        VarCodeFilter: Code[250];
}

