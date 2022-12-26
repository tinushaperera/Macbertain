pageextension 50209 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter("Automatic Ext. Texts")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. in Transit")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
            }

        }
        addafter("Tax Group Code")
        {
            field("Tax Group Code 2"; Rec."Tax Group Code 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Application Wksh. User ID")
        {
            field("QC-Check-Need"; Rec."QC-Check-Need")
            {
                ApplicationArea = All;
            }
        }
        modify(AssemblyBOM)
        {
            Visible = false;
        }
        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Qty. on Prod. Order")
        {
            Visible = false;
        }
        modify("Qty. on Component Lines")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify("Costing Method")
        {
            Visible = HideMasterDataFields;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Unit Cost")
        {
            Visible = HideMasterDataFields;
        }
        modify("Last Direct Cost")
        {
            Visible = HideMasterDataFields;
        }
        modify("Profit %")
        {
            Visible = HideMasterDataFields;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify(LotForLotParameters)
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
    }

    actions
    {
        modify("Va&riants")
        {
            Promoted = true;
        }
        modify(ItemsByLocation)
        {
            Promoted = true;
        }
    }

    trigger OnOpenPage()

    begin
        HideMasterData;
    end;

    procedure HideMasterData()
    begin
        UserSetup.GET(USERID);
        HideMasterDataFields := UserSetup."Hide Master Data Fields";
    end;

    var
        UserSetup: Record "User Setup";
        HideMasterDataFields: Boolean;

}