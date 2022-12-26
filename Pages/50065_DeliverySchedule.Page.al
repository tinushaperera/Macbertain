page 50065 "Delivery Schedule"
{
    ApplicationArea = All;
    Caption = 'Delivery Schedule';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            Type = FILTER(Item),
                            "Order Type" = FILTER(Order),
                            "Outstanding Quantity" = FILTER(> 0),
                            Status = FILTER(Released));

    layout
    {
        area(content)
        {
            repeater(Grp)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Ship To City"; rec."Ship To City")
                {
                    ApplicationArea = All;
                }
                field("Blocked Reason"; rec."Blocked Reason")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount (LCY)"; rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Available Inventory"; rec."Available Inventory")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date-Time Released"; rec."Date-Time Released")
                {
                    ApplicationArea = All;
                }
                field("Paym. Term Code"; rec."Paym. Term Code")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Term Code';
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship To Code"; rec."Ship To Code")
                {
                    ApplicationArea = All;
                }
                field("Route Code 1"; rec."Route Code 1")
                {
                    ApplicationArea = All;
                }
                field("Route Code2"; rec."Route Code2")
                {
                    ApplicationArea = All;
                }
                field("Route Code3"; rec."Route Code3")
                {
                    ApplicationArea = All;
                }
                field("Route Code4"; rec."Route Code4")
                {
                    ApplicationArea = All;
                }
                field("Territory Code"; rec."Territory Code")
                {
                    ApplicationArea = All;
                }
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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        ShortcutDimCode: array[8] of Code[20];
}

