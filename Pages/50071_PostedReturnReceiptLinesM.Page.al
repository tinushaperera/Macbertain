page 50071 "Posted Return Receipt Lines-M"
{

    Caption = 'Posted Return Receipt Lines';
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Return Receipt Line";
    SourceTableView = WHERE(Type = FILTER(Item));
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Return Reason Remarks"; rec."Return Reason Remarks")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;

            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Show Document")
                {
                    ApplicationArea = All;
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        ReturnRcptHeader: Record "Return Receipt Header";
                    begin
                        ReturnRcptHeader.GET(rec."Document No.");
                        PAGE.RUN(PAGE::"Posted Return Receipt", ReturnRcptHeader);
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDimensions;
                    end;
                }
            }
        }
    }
}

