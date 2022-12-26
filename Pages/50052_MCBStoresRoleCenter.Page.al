page 50052 "MCB Stores Role Center"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Grp1)
            {
                part("Stores Activities"; "MCB Stores Activities")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    Caption = 'Stores Activities';
                }
            }
            group(Grp2)
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
            action("Customer - &Order Summary")
            {
                ApplicationArea = All;
                Caption = 'Customer - &Order Summary';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
            }
            action("<Report Customer-Order Detail With Qty")
            {
                ApplicationArea = All;
                Caption = 'Customer-Order Detail With Qty';
                Image = "Report";
                RunObject = Report "Customer-Order Detail With Qty";
            }
            action("Stock Ledger")
            {
                ApplicationArea = All;
                Caption = 'Stock Ledger';
                Image = "Report";
                RunObject = Report "Stock Ledger";
            }
            action("Sales Return Sum.-by Reason")
            {
                ApplicationArea = All;
                Caption = 'Sales Return Sum.-by Reason';
                Image = "Report";
                RunObject = Report "Sales Return Sum.-by Reason";
            }
            action("Sales Return Sum.- by Debtor")
            {
                ApplicationArea = All;
                Caption = 'Sales Return Sum.- by Debtor';
                Image = "Report";
                RunObject = Report "Sales Return Sum.- by Debtor";
            }
            action("Inventory - Transaction Detail")
            {
                ApplicationArea = All;
                Caption = 'Inventory - Transaction Detail';
                Image = "Report";
                RunObject = Report "Inventory - Transaction Detail";
            }
            action("Inventory Aging Report-W/O/C")
            {
                ApplicationArea = All;
                Caption = 'Inventory Aging Report- W/O/C';
                Image = "Report";
                RunObject = Report "Stock Age Analysis-W/O Cost-N";
            }
            action(Status)
            {
                ApplicationArea = All;
                Caption = 'Status';
                Image = "Report";
                RunObject = Report Status;
            }
            // separator()
            // {
            // }
        }
        area(embedding)
        {
            ToolTip = 'Manage sales processes. See KPIs and your favorite items and customers.';
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
                RunObject = Page "Purchase Order List";
            }
            action("Import Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Import Purchase Orders';
                RunObject = Page "Import Purchase List";
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
            action("Purchase Invoice")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Invoices";
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
                RunObject = Page "Sales Return Order List";
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
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.';
                action("Posted Sales Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Return Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                }
                action("Posted Return Receipts-Detailed")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts-Detailed';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipt Lines-M";
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';
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
                action("Sales Order Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Archives';
                    RunObject = Page "Sales Order Archives";
                }
                action("Sales Return Orders Archives")
                {
                    ApplicationArea = All;
                    RunObject = Page "Sales Return List Archive";
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
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
            action("Navi&gate")
            {
                ApplicationArea = All;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
            // action("Change Password")
            // {
            //     Caption = 'Change Password';
            //     Image = Permission;
            //     RunObject = Page 9809;
            // }
            action("Phys. Inventory Journal")
            {
                ApplicationArea = All;
                Caption = 'Phys. Inventory Journal';
                Image = PhysicalInventoryLedger;
                RunObject = Page "Phys. Inventory Journal";
            }
        }
    }
}

