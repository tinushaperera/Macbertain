pageextension 50220 ItemList extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Sales (Qty.)"; Rec."Sales (Qty.)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item Disc. Group")
        {
            field("Qty. in Transit"; Rec."Qty. in Transit")
            {
                ApplicationArea = All;
            }
        }
        addafter("Costing Method")
        {
            field("Old Item Code"; Rec."Old Item Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Default Deferral Template Code")
        {
            field("Tax Group Code"; Rec."Tax Group Code")
            {
                ApplicationArea = All;
            }
            field("Tax Group Code 2"; Rec."Tax Group Code 2")
            {
                ApplicationArea = All;
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Unit Cost")
        {
            Visible = HideMasterDataFields;
        }

        modify("Costing Method")
        {
            Visible = HideMasterDataFields;
        }
        modify("Inventory Posting Group")
        {
            Visible = true;
        }
        modify("Tariff No.")
        {
            Visible = true;
        }
        modify(Blocked)
        {
            Visible = true;
        }
        modify("Last Date Modified")
        {
            Visible = true;
        }
        modify("Default Deferral Template Code")
        {
            Caption = 'Default Deferral Template';
        }
    }

    actions
    {
        addafter("Returns Orders")
        {
            action("Invenoty Valuation-Variants")
            {
                ApplicationArea = all;
                Caption = 'Invenoty Valuation-Variants';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Inv. Val.-Variants Report Filt";
            }
        }
    }

    trigger OnOpenPage()
    begin
        HideMasterData;
    end;

    var
        HideMasterDataFields: Boolean;

    local procedure HideMasterData()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        HideMasterDataFields := UserSetup."Hide Master Data Fields";
    end;
}