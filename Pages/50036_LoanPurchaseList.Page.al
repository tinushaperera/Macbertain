page 50036 "Loan Purchase List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Loan Out List';
    CardPageID = "Loan Purchase Order";
    DataCaptionFields = "Document Type";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Order Type" = CONST(Loan),
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
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
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
                RunObject = Report 409;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
}

