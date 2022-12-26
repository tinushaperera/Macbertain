page 50061 "MCB Sales Team Role Center"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(grp)
            {
                part("Sales Activities"; "MCB Sales Activities")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    Caption = 'Sales Activities';
                }
            }
            group(grp2)
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
                    action("Inventory - Customer Sales")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory - Customer Sales';
                        Image = "Report";
                        RunObject = Report 713;
                    }
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Top 10 List';
                        Image = "Report";
                        RunObject = Report 111;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
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
                    action("Total Sales")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Sales';
                        Image = "Report";
                        RunObject = Report 50032;
                    }
                    action("Total Sales Summary")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Sales Summary';
                        Image = "Report";
                        RunObject = Report 50057;
                    }
                    action("Customer-Order Detail With Qty")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer-Order Detail With Qty';
                        Image = "Report";
                        RunObject = Report 50042;
                    }
                    action("Invoice Late Payment Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Invoice Late Payment Report';
                        Image = "Report";
                        RunObject = Report 50033;
                    }
                    action("Outstanding (Relesed) Sales Orders (IRN""s)")
                    {
                        ApplicationArea = All;
                        Caption = 'Outstanding (Relesed) Sales Orders (IRN"s)';
                        Image = "Report";
                        RunObject = Report 50021;
                    }
                    action("Export Sales Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Export Sales Report';
                        Image = "Report";
                        RunObject = Report 50051;
                    }
                    action("SRN Status Report")
                    {
                        ApplicationArea = All;
                        Caption = 'SRN Status Report';
                        Image = "Report";
                        RunObject = Report 50072;
                    }
                }
                group(DebtorAgeAnalysisSummary)
                {
                    Caption = 'Debtor Age Analysis Summary';
                    Image = "Report";
                    action("By Debtor")
                    {
                        ApplicationArea = All;
                        Caption = 'By Debtor';
                        Image = "Report";
                        RunObject = Report 50044;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
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
                group("Debtors Reports-NAV")
                {
                    Caption = 'Debtors Reports-NAV';
                    Image = "Report";
                    action("Customer - Detail Trial Bal.")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Detail Trial Bal.';
                        Image = "Report";
                        RunObject = Report 50063;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Client Activity")
                    {
                        ApplicationArea = All;
                        Caption = 'Client Activity';
                        Image = "Report";
                        RunObject = Report 50040;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                }
                group("Collection Reports-NAV")
                {
                    Caption = 'Collection Reports';
                    Image = "Report";
                    action("Allocated Receipt Listing")
                    {
                        ApplicationArea = All;
                        Caption = 'Allocated Receipt Listing';
                        Image = "Report";
                        RunObject = Report 50063;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Collection Age")
                    {
                        ApplicationArea = All;
                        Caption = 'Collection Age';
                        Image = "Report";
                        RunObject = Report 50078;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                }
                group("Inventory Reports")
                {
                    Caption = 'Inventory Reports';
                    Image = "Report";
                    action("Stock Ledger")
                    {
                        ApplicationArea = All;
                        Caption = 'Stock Ledger';
                        Image = "Report";
                        RunObject = Report 50081;
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                }
            }
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
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                RunObject = Page "Sales Order List";
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
                RunObject = Page 50015;
            }
            action("Sales Quotes")
            {
                ApplicationArea = All;
                Caption = 'Sales Quotes';
                RunObject = Page 9300;
            }
            action("Client Approval Entries")
            {
                ApplicationArea = All;
                RunObject = Page 50043;
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
            action("Query Reports")
            {
                ApplicationArea = All;
                Caption = 'Query Reports';
                Image = Excel;
                RunObject = Page 50099;
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
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Client Approval Entries History")
                {
                    ApplicationArea = All;
                    Caption = 'Client Approval Entries History';
                    RunObject = Page 50056;
                }
                action("Sales Order Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Archives';
                    RunObject = Page 9349;
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
        }
    }
}

