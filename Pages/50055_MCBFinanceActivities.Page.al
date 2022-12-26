page 50055 "MCB Finance Activities"
{
    ApplicationArea = All;
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            grid(Grp1)
            {
                GridLayout = Columns;
            }
            cuegroup("Customer Approvals")
            {
                Caption = 'Customer Approvals';
                CueGroupLayout = Wide;
                field("Pending Customer Approvals"; rec."Pending Customer Approvals")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Approvals';
                    ColumnSpan = 2;
                    DrillDownPageID = "Pending Customer List";
                    RowSpan = 2;
                }
            }
            cuegroup("Sales Orders-Pending Approval")
            {
                Caption = 'Sales Orders-Pending Approval';
                CueGroupLayout = Wide;
                field("Pending Sales Order Approvals"; rec."Pending Sales Order Approvals")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    ColumnSpan = 2;
                    DrillDown = true;
                    DrillDownPageID = "Pending Sales Order List";
                    RowSpan = 1;
                }
                field("Pending Sample Order Approvals"; rec."Pending Sample Order Approvals")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Orders';
                    DrillDown = true;
                    DrillDownPageID = "Pending Sample Order List";
                }
                field("Pending Credit Limit Approvals"; rec."Pending Credit Limit Approvals")
                {
                    ApplicationArea = All;
                    Caption = 'Credit Limit';
                    DrillDown = true;
                    DrillDownPageID = "Credit Limit Approval Entries";
                }
                field("Pending Overdue Approvals"; rec."Pending Overdue Approvals")
                {
                    ApplicationArea = All;
                    Caption = 'Overdue';
                    DrillDown = true;
                    DrillDownPageID = "Over Due Approval Entries";
                }
                field("Pending Free Issue Approvals"; rec."Pending Free Issue Approvals")
                {
                    ApplicationArea = All;
                    Caption = 'Free Issue';
                    DrillDown = true;
                    DrillDownPageID = "Free Issue Approval Entries";
                }
                field("Pending Discounts Approvals"; rec."Pending Discounts Approvals")
                {
                    ApplicationArea = All;
                    Caption = 'Discounts';
                    DrillDown = true;
                    DrillDownPageID = "Discount Approval Entries";
                }
            }
            cuegroup("Sales Orders-Status")
            {
                Caption = 'Sales Orders-Status';
                field("Sales Orders - Open"; rec."Sales Orders - Open")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "Sales Order List";
                }
                field("Approved-Sales Orders Today"; rec."Approved-Sales Orders Today")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "Sales Order List";
                }
                field("Partially Shipped"; rec."Partially Shipped")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "Sales Order List";
                    Visible = false;
                }
                field("Not Fully Shipped"; rec."Not Fully Shipped")
                {
                    ApplicationArea = All;
                    Caption = 'Partially Delivered';
                    DrillDown = true;
                    DrillDownPageID = "Sales Order List";
                }
                field(DelayedOrders; rec.Delayed)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Deliveries >1day';
                    DrillDownPageID = "Sales Order List";

                    trigger OnDrillDown()
                    begin
                        rec.ShowOrders(rec.FIELDNO(Delayed));
                    end;
                }
                field("Average Days Delayed"; rec."Average Days Delayed")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 1;
                    Image = Calendar;
                }

                actions
                {
                    // action(Navigate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Navigate';
                    //     Image = Navigate;
                    //     RunObject = Page Navigate;
                    // }
                }
            }
            cuegroup("Posted Sales Invoices")
            {
                Caption = 'Posted Sales Invoices';
                CueGroupLayout = Wide;
                field("Posted Sales Invoices-Today"; rec."Posted Sales Invoices-Today")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Inv.-Today';
                    DrillDownPageID = "Posted Sales Invoices";
                }
                field("Posted Sales Invoices-All"; rec."Posted Sales Invoices-All")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Inv.-All';
                    DrillDownPageID = "Posted Sales Invoices";
                }
            }
            cuegroup(Returns)
            {
                Caption = 'Returns';
                field("Sales Return Orders - Open"; rec."Sales Return Orders - Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Return Order List";
                }

                actions
                {
                    action("New Sales Return Order")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Return Order';
                        RunObject = Page "Sales Return Order";
                        RunPageMode = Create;
                    }
                    action("New Sales Credit Memo")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Credit Memo';
                        RunObject = Page "Sales Credit Memo";
                        RunPageMode = Create;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = All;
                Caption = 'Set Up Cues';
                Image = Setup;

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        CalculateCueFieldValues;
        ShowDocumentsPendingDodExchService := FALSE;
        IF DocExchServiceSetup.GET THEN
            ShowDocumentsPendingDodExchService := DocExchServiceSetup.Enabled;
    end;

    trigger OnOpenPage()
    begin
        rec.RESET;
        IF NOT rec.GET THEN BEGIN
            rec.INIT;
            rec.INSERT;
        END;

        rec.SetRespCenterFilter;
        rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);
        rec.SETFILTER("Date Filter2", '>=%1', WORKDATE);
    end;

    var
        CueSetup: Codeunit "Cues And KPIs";
        ShowDocumentsPendingDodExchService: Boolean;

    local procedure CalculateCueFieldValues()
    begin
        IF rec.FIELDACTIVE("Average Days Delayed") THEN
            rec."Average Days Delayed" := rec.CalculateAverageDaysDelayed;

        IF rec.FIELDACTIVE("Ready to Ship") THEN
            rec."Ready to Ship" := rec.CountOrders(rec.FIELDNO("Ready to Ship"));

        IF rec.FIELDACTIVE("Partially Shipped") THEN
            rec."Partially Shipped" := rec.CountOrders(rec.FIELDNO("Partially Shipped"));

        IF rec.FIELDACTIVE(Delayed) THEN
            rec.Delayed := rec.CountOrders(rec.FIELDNO(Delayed));
    end;
}

