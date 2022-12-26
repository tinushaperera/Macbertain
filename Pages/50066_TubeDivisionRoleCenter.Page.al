page 50066 "Tube Division Role Center"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;
    //ApplicationArea = All;
    layout
    {
        area(rolecenter)
        {
            group(General)
            {
                part("Production Activities"; "Production Activities")
                {
                    ApplicationArea = All;
                }
            }
            group(Note)
            {
                systempart(Notes; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Reports)
            {

                Caption = 'Reports';
                group(SalesReports)
                {
                    Caption = 'Sales Reports';
                    Image = "Report";
                    action("Customer/Item Sales")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer/Item Sales';
                        Image = "Report";
                        RunObject = Report 113;
                    }
                    action("Inventory - Customer Sales")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory - Customer Sales';
                        Image = "Report";
                        RunObject = Report 713;
                    }
                    action("Customer - Order Detail")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Order Detail';
                        Image = "Report";
                        RunObject = Report 108;
                    }
                    action("Report Customer - Order Summary")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Order Summary';
                        Image = "Report";
                        RunObject = Report 107;
                    }
                }
                group(DebtorAgeAnalysisSummary)
                {

                    Caption = 'Debtor Age Analysis Summary';
                    Image = "Report";
                    action("BU Wise Sum")
                    {
                        ApplicationArea = All;
                        Caption = 'BU';
                        Image = "Report";
                        RunObject = Report 50089;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Operation wise Sum")
                    {
                        ApplicationArea = All;
                        Caption = 'Operation';
                        Image = "Report";
                        RunObject = Report 50095;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Sales Rep Sum")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Rep';
                        Image = "Report";
                        RunObject = Report 50096;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                }
                group(DebtorAgeAnalysisDetails)
                {
                    Caption = 'Debtor Age Analysis Details';
                    Image = "Report";
                    action("BU Wise")
                    {
                        ApplicationArea = All;

                        Caption = 'BU';
                        Image = "Report";
                        RunObject = Report 50090;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Operation wise")
                    {
                        ApplicationArea = All;
                        Caption = 'Operation';
                        Image = "Report";
                        RunObject = Report 50097;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Sales Rep wise")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Rep';
                        Image = "Report";
                        RunObject = Report 50098;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                }
                group(InventoryReports)
                {
                    Caption = 'Inventory Reports';
                    Image = "Report";
                    action(Status)
                    {
                        ApplicationArea = All;
                        Caption = 'Status';
                        Image = "Report";
                        RunObject = Report 706;
                    }
                    action("Stock Ledger")
                    {
                        ApplicationArea = All;
                        Caption = 'Stock Ledger';
                        Image = "Report";
                        RunObject = Report 50081;
                    }
                }
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
            action("Import Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Import Purchase Orders';
                RunObject = Page "Import Purchase List";
            }
            action("Purchase Order List")
            {
                ApplicationArea = All;
                Caption = 'Local Purchase Orders';
                RunObject = Page "Purchase Order List";
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
            action("Sales Quotes")
            {
                ApplicationArea = All;
                Caption = 'Sales Quotes';
                RunObject = Page "Sales Quotes";
            }
            action("Client Approval Entries")
            {
                ApplicationArea = All;
                RunObject = Page "Client Approval Entries";
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                RunObject = Page "Customer List";
            }
            action("Approval Request Entries")
            {
                ApplicationArea = All;
                Caption = 'Approval Request Entries';
                RunObject = Page "Approval Request Entries";
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
                action("Posted Sales Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                }
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
                action("Posted Return Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                }
                action("Client Approval Entries History")
                {
                    ApplicationArea = All;
                    Caption = 'Client Approval Entries History';
                    RunObject = Page "Client Approval Entries His.";
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
            //     ApplicationArea = All;
            //     Caption = 'Change Password';
            //     Image = Permission;
            //     RunObject = Page 9809;
            // }
        }
    }
}

