page 50048 "Unidentified Ledger Entries"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Unidentified Ledger Entries';
    DataCaptionExpression = GetCaption;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "G/L Entry" = rm;
    SourceTable = "G/L Entry";
    SourceTableView = WHERE("Document Type" = FILTER(Payment | Refund),
                            "G/L Account No." = filter(30140));

    layout
    {
        area(content)
        {
            repeater(grp)
            {
                field(Applied; rec.Applied)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unidentified Deposit No."; rec."Unidentified Deposit No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("G/L Account Name"; rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    DrillDown = false;
                    Editable = false;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Narration; rec.Narration)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; rec.Reversed)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Reversed by Entry No."; rec."Reversed by Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Reversed Entry No."; rec."Reversed Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("FA Entry Type"; rec."FA Entry Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("FA Entry No."; rec."FA Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            // part(IncomingDocAttachFactBox; rec.193)
            // {
            //     ShowFilter = false;
            // }
            systempart(links; Links)
            {
                Visible = false;
            }
            systempart(notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        rec.ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(GLDimensionOverview)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'G/L Dimension Overview';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"G/L Entries Dimension Overview", Rec);
                    end;
                }
                action("Value Entries")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData Item = R;
                    Caption = 'Value Entries';
                    Image = ValueLedger;
                    Scope = Repeater;

                    trigger OnAction()
                    begin
                        rec.ShowValueEntries;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(ReverseTransaction)
                {
                    ApplicationArea = All;
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;
                    Image = ReverseRegister;
                    Scope = Repeater;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        CLEAR(ReversalEntry);
                        IF rec.Reversed THEN
                            ReversalEntry.AlreadyReversedEntry(rec.TABLECAPTION, rec."Entry No.");
                        IF rec."Journal Batch Name" = '' THEN
                            ReversalEntry.TestFieldError;
                        rec.TESTFIELD("Transaction No.");
                        ReversalEntry.ReverseTransaction(rec."Transaction No.")
                    end;
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = All;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCard(rec."Document No.", rec."Posting Date");
                        end;
                    }
                    // action(SelectIncomingDoc)
                    // {
                    //     AccessByPermission = TableData "Incoming Document" = R;
                    //     Caption = 'Select Incoming Document';
                    //     Enabled = NOT HasIncomingDocument;
                    //     Image = SelectLineToApply;
                    //     //The property 'ToolTip' cannot be empty.
                    //     //ToolTip = '';

                    //     trigger OnAction()
                    //     var
                    //         IncomingDocument: Record "Incoming Document";
                    //     begin
                    //         IncomingDocument.SelectIncomingDocumentForPostedDocument(rec."Document No.", rec."Posting Date");
                    //     end;
                    // }
                    // action(IncomingDocAttachFile)
                    // {
                    //     Caption = 'Create Incoming Document from File';
                    //     Ellipsis = true;
                    //     Enabled = NOT HasIncomingDocument;
                    //     Image = Attach;
                    //     //The property 'ToolTip' cannot be empty.
                    //     //ToolTip = '';

                    //     trigger OnAction()
                    //     var
                    //         IncomingDocumentAttachment: Record "133";
                    //     begin
                    //         IncomingDocumentAttachment.NewAttachmentFromPostedDocument("Document No.", "Posting Date");
                    //     end;
                    // }
                }
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(rec."Posting Date", rec."Document No.");
                    Navigate.RUN;
                end;
            }
            // action(DocsWithoutIC)
            // {
            //     Caption = 'Posted Documents without Incoming Document';
            //     Image = Documents;

            //     trigger OnAction()
            //     var
            //         PostedDocsWithNoIncBuf: Record "134";
            //     begin
            //         COPYFILTER("G/L Account No.", PostedDocsWithNoIncBuf."G/L Account No. Filter");
            //         PAGE.RUN(PAGE::"Posted Docs. With No Inc. Doc.", PostedDocsWithNoIncBuf);
            //     end;
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record "Incoming Document";
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists(rec."Document No.", rec."Posting Date");
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        GLAcc: Record "G/L Account";
        HasIncomingDocument: Boolean;

    local procedure GetCaption(): Text[250]
    begin
        IF GLAcc."No." <> rec."G/L Account No." THEN
            IF NOT GLAcc.GET(rec."G/L Account No.") THEN
                IF rec.GETFILTER("G/L Account No.") <> '' THEN
                    IF GLAcc.GET(rec.GETRANGEMIN("G/L Account No.")) THEN;
        EXIT(STRSUBSTNO('%1 %2', GLAcc."No.", GLAcc.Name))
    end;
}

