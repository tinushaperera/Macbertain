page 50034 "Import Purchase List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Import Purchase List';
    CardPageID = "Import Purchase Order";
    DataCaptionFields = "Document Type";
    DeleteAllowed = true;
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Order Type" = CONST(Import),
                            "Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                }
                field("Vendor Order No."; rec."Vendor Order No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
            }
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
            // systempart(; Notes)
            // {
            //     Visible = false;
            // }
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PageManagement: Codeunit "Page Management";
                    begin
                        PageManagement.PageRun(Rec);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Purchase Reservation Avail.")
            {
                Caption = 'Purchase Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Purchase Reservation Avail.";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        DimMgt: Codeunit "DimensionManagement";
}

