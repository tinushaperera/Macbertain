page 50098 "Excel Parameters"
{
    DeleteAllowed = false;
    Description = '''''';
    InsertAllowed = false;
    ShowFilter = false;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            field("Excel Date Filter"; rec."Excel Date Filter")
            {
                CaptionClass = _DateCaption;
                Visible = _DateVisible;
            }
            field("Excel Date Filter 2"; rec."Excel Date Filter 2")
            {
                CaptionClass = _Date2Caption;
                Visible = _Date2Visible;
            }
            field("Excel Global Dim 1 Filter"; rec."Excel Global Dim 1 Filter")
            {
                Visible = _GDim1Visible;
            }
            field("Excel Global Dim 2 Filter"; rec."Excel Global Dim 2 Filter")
            {
                Visible = _GDim2Visible;
            }
            field("Excel Territory Code Filter"; rec."Excel Territory Code Filter")
            {
                CaptionClass = _TerritoryCaption;
                Visible = _TerritoryVisible;
            }
            field("Excel Region Code Filter"; rec."Excel Region Code Filter")
            {
                CaptionClass = _RegionCaption;
                Visible = _RegionVisible;
            }
            field("Excel Salesperson Code Filter"; rec."Excel Salesperson Code Filter")
            {
                CaptionClass = _SalesPersonCaption;
                Visible = _SalesPersonVisible;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        _DateVisible := FALSE;
        _Date2Visible := FALSE;
        _GDim1Visible := FALSE;
        _GDim2Visible := FALSE;
        _RegionVisible := FALSE;
        _TerritoryVisible := FALSE;
        _SalesPersonVisible := FALSE;
    end;

    trigger OnOpenPage()
    begin
        rec.FILTERGROUP(2);
        rec.SETFILTER("User ID", USERID);
        rec.FILTERGROUP(0);
    end;

    var
        _DateCaption: Text[60];
        _DateVisible: Boolean;
        _Date2Caption: Text[60];
        _Date2Visible: Boolean;
        _GDim1Caption: Text[60];
        _GDim1Visible: Boolean;
        _GDim2Caption: Text[60];
        _GDim2Visible: Boolean;
        _TerritoryCaption: Text[60];
        _TerritoryVisible: Boolean;
        _RegionCaption: Text[60];
        _RegionVisible: Boolean;
        _SalesPersonCaption: Text[60];
        _SalesPersonVisible: Boolean;

    procedure DateCaption(varDateCaption: Text[60])
    begin
        _DateCaption := varDateCaption;
        _DateVisible := TRUE;
    end;

    procedure Date2Caption(varDateCaption: Text[60])
    begin
        _Date2Caption := varDateCaption;
        _Date2Visible := TRUE;
    end;

    procedure GDim1Caption(varCaption: Text[60])
    begin
        _GDim1Caption := varCaption;
        _GDim1Visible := TRUE;
    end;

    procedure GDim2Caption(varCaption: Text[60])
    begin
        _GDim2Caption := varCaption;
        _GDim2Visible := TRUE;
    end;

    procedure TerritoryCaption(varCaption: Text[60])
    begin
        _TerritoryCaption := varCaption;
        _TerritoryVisible := TRUE;
    end;

    procedure RegionCaption(varCaption: Text[60])
    begin
        _RegionCaption := varCaption;
        _RegionVisible := TRUE;
    end;

    procedure SalesPersonCaption(varCaption: Text[60])
    begin
        _SalesPersonCaption := varCaption;
        _SalesPersonVisible := TRUE;
    end;
}

