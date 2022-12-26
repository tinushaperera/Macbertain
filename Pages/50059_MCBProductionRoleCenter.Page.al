page 50059 "MCB Production Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    layout
    {
        area(rolecenter)
        {
            group(Grp)
            {
                part("Production Activities"; "Production Activities")
                {
                    ApplicationArea = all;
                }
            }
            group(grp2)
            {
                systempart(Notes; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Status)
            {
                ApplicationArea = All;
                Caption = 'Status';
                Image = "Report";
                RunObject = Report Status;
            }
            action("Inventory - Transaction Detail")
            {
                ApplicationArea = All;
                Caption = 'Inventory - Transaction Detail';
                Image = "Report";
                RunObject = Report "Inventory - Transaction Detail";
            }
            action("Stock Ledger")
            {
                ApplicationArea = All;
                Caption = 'Stock Ledger';
                Image = "Report";
                RunObject = Report "Stock Ledger";
            }
            action("Inventory Aging Report-W/O/C")
            {
                ApplicationArea = All;
                Caption = 'Inventory Aging Report- W/O/C';
                Image = "Report";
                RunObject = Report "Stock Age Analysis-W/O Cost-N";
            }
        }
        area(embedding)
        {
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action("Material Requisitions")
            {
                ApplicationArea = All;
                RunObject = Page "Material Requisition List";
            }
            action("Purchase Invoices")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Invoices";
            }
            action("Transfer Orders")
            {
                ApplicationArea = All;
                RunObject = Page "Transfer Orders";
            }
            action("Delivery Schedule")
            {
                ApplicationArea = All;
                Caption = 'Delivery Schedule';
                RunObject = Page "Delivery Schedule";
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                RunObject = Page "Item List";
            }
            action("Requests to Approve")
            {
                ApplicationArea = All;
                RunObject = Page "Requests to Approve";
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Purchase Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipt';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("<Page Posted Transfer Shipments>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page "Posted Transfer Shipments";
                }
                action("<Page Posted Transfer Receipts>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page "Posted Transfer Receipts";
                }
                action("<Posted Return Receipts>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts';
                    RunObject = Page "Posted Return Receipts";
                }
                action("Posted Return Receipts-Detailed")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts-Detailed';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipt Lines-M";
                }
                action("Item Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Item Ledger Entries';
                    RunObject = Page "Item Ledger Entries";
                }
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Phys. Inventory Journal")
            {
                ApplicationArea = All;
                Caption = 'Phys. Inventory Journal';
                Image = PhysicalInventoryLedger;
                RunObject = Page "Phys. Inventory Journal";
            }
            // action("Change Password")
            // {
            //     Caption = 'Change Password';
            //     Image = Permission;
            //     RunObject = Page 9809;
            // }
        }
    }
}

