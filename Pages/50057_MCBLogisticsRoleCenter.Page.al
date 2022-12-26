page 50057 "MCB Logistics Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    layout
    {
        area(rolecenter)
        {
            group(grp1)
            {
                part("Logistics Activities"; "Logistics Activities")
                {
                    ApplicationArea = All;
                }
                part("Stores Activities"; "MCB Stores Activities")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    Caption = 'Stores Activities';
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
            action(Balance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action("Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action("Purchase Invoices")
            {
                ApplicationArea = All;
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
            }
            action("Import Jobs")
            {
                ApplicationArea = All;
                Caption = 'Import Jobs';
                RunObject = Page "Import Jobs List";
            }
            action("Import Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Import Purchase Orders';
                RunObject = Page "Import Purchase List";
            }
            action("Local Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Local Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action(Items1)
            {
                ApplicationArea = All;
                Caption = 'Items';
                RunObject = Page 31;
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("Posted Purchase Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipt';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("<Page Posted Return Receipts>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts';
                    RunObject = Page "Posted Return Receipts";
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
                action("<Posted Return Shipments>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                }
                action("Item Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Item Ledger Entries';
                    RunObject = Page "Item Ledger Entries";
                }
                action("Vendor Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Entries';
                    RunObject = Page "Vendor Ledger Entries";
                }
            }
            group("Stores Activities1")
            {
                Caption = 'Stores Activities';
                action(Items)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    Image = Item;
                    RunObject = Page "Item List";
                }
                action("Material Requisitions")
                {
                    ApplicationArea = All;
                    RunObject = Page "Material Requisition List";
                }
                action("Delivery Schedule")
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Schedule';
                    RunObject = Page "Delivery Schedule";
                }
                action("Purchase Order List")
                {
                    ApplicationArea = All;
                    Caption = 'Local Purchase Orders';
                    RunObject = Page "Purchase Orders";
                }
                action("Loan Purchase List (50036)")
                {
                    ApplicationArea = All;
                    Caption = 'Material Loans-In';
                    RunObject = Page "Loan Purchase List";
                }
                action("Material Loan-Out")
                {
                    ApplicationArea = All;
                    Caption = 'Material Loan-Out';
                    RunObject = Page "Material Loan-Out";
                }
                action(Customers)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
                action("Sales Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    RunObject = Page "Sales Order List";
                }
                action("Ship-to Address")
                {
                    ApplicationArea = All;
                    RunObject = Page "Ship-to Address List";
                }
                action("Transfer Orders")
                {
                    ApplicationArea = All;
                    RunObject = Page "Transfer Orders";
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = All;
                    RunObject = Page "Sales Return Orders";
                }
                action("Sample Sales Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Sales Orders';
                    RunObject = Page "Sample Sales Order List";
                }
                action("Requests to Approve")
                {
                    ApplicationArea = All;
                    Caption = 'Requests to Approve';
                    RunObject = Page "Requests to Approve";
                }
                action("Approval Request Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Request Entries';
                    RunObject = Page "Approval Request Entries";
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = All;
                    RunObject = Page "Purchase Return Order List";
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
            // action("Change Password")
            // {
            //     Caption = 'Change Password';
            //     Image = Permission;
            //     RunObject = Page 9809;
            // }
        }
    }
}

