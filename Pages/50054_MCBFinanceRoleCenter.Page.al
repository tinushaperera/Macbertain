page 50054 "MCB Finance Role Center"
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
                part("MCB Finance Activities"; "MCB Finance Activities")
                {
                    ApplicationArea = All;
                }
                part("Trial Balance"; "Trial Balance")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "G/L Entry" = R;
                }
                part("Activities"; "O365 Activities")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "G/L Entry" = R;
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
            group(Reports)
            {
                Caption = 'Reports';
                group(SalesReports)
                {
                    Caption = 'Sales Reports';
                    Image = "Report";
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Top 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Customer - Sales List")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Sales List';
                        Image = "Report";
                        RunObject = Report "Customer - Sales List";
                        ToolTip = 'View, print, or save customer sales in a period, for example, to report sales activity to customs and tax authorities.';
                    }
                    action("Sales Statistics")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Statistics';
                        Image = "Report";
                        RunObject = Report "Sales Statistics";
                        ToolTip = 'View, print, or save customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                    }
                }
                group(FinanceReports)
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action("&G/L Trial Balance")
                    {
                        ApplicationArea = All;
                        Caption = '&G/L Trial Balance';
                        Image = "Report";
                        RunObject = Report "Trial Balance";
                    }
                    action("&Bank Detail Trial Balance")
                    {
                        ApplicationArea = All;
                        Caption = '&Bank Detail Trial Balance';
                        Image = "Report";
                        RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    }
                    action("&Account Schedule")
                    {
                        ApplicationArea = All;
                        Caption = '&Account Schedule';
                        Image = "Report";
                        RunObject = Report "Account Schedule";
                    }
                    action("Bu&dget")
                    {
                        ApplicationArea = All;
                        Caption = 'Bu&dget';
                        Image = "Report";
                        RunObject = Report Budget;
                    }
                    action("Trial Bala&nce/Budget")
                    {
                        ApplicationArea = All;
                        Caption = 'Trial Bala&nce/Budget';
                        Image = "Report";
                        RunObject = Report "Trial Balance/Budget";
                    }
                    action("Trial Balance by &Period")
                    {
                        ApplicationArea = All;
                        Caption = 'Trial Balance by &Period';
                        Image = "Report";
                        RunObject = Report "Trial Balance by Period";
                    }
                    action("&Fiscal Year Balance")
                    {
                        ApplicationArea = All;
                        Caption = '&Fiscal Year Balance';
                        Image = "Report";
                        RunObject = Report "Fiscal Year Balance";
                    }
                    action("Balance Comp. - Prev. Y&ear")
                    {
                        ApplicationArea = All;
                        Caption = 'Balance Comp. - Prev. Y&ear';
                        Image = "Report";
                        RunObject = Report "Balance Comp. - Prev. Year";
                    }
                    action("&Closing Trial Balance")
                    {
                        ApplicationArea = All;
                        Caption = '&Closing Trial Balance';
                        Image = "Report";
                        RunObject = Report "Closing Trial Balance";
                    }
                    // separator()
                    // {ApplicationArea = All;
                    // }
                    action("Cash Flow Date List")
                    {
                        ApplicationArea = All;
                        Caption = 'Cash Flow Date List';
                        Image = "Report";
                        RunObject = Report "Cash Flow Date List";
                    }
                    // separator()
                    // {ApplicationArea = All;
                    // }
                    action("Aged Accounts &Receivable")
                    {
                        ApplicationArea = All;
                        Caption = 'Aged Accounts &Receivable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Receivable";
                    }
                    action("Aged Accounts Pa&yable")
                    {
                        ApplicationArea = All;
                        Caption = 'Aged Accounts Pa&yable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Payable";
                    }
                    action("Reconcile Cus&t. and Vend. Accs")
                    {
                        ApplicationArea = All;
                        Caption = 'Reconcile Cus&t. and Vend. Accs';
                        Image = "Report";
                        RunObject = Report "Reconcile Cust. and Vend. Accs";
                    }
                    // separator()
                    // {
                    // }
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
                        RunObject = Report "Debtor Age Anaysis-By Debtor";
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("BU Wise Sum")
                    {
                        ApplicationArea = All;
                        Caption = 'BU';
                        Image = "Report";
                        RunObject = Report "Debtor Age Anly Sum- BU Wise";
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Operation wise Sum")
                    {
                        ApplicationArea = All;
                        Caption = 'Operation';
                        Image = "Report";
                        RunObject = Report "Debtor Age Anl Sum- Oper. Wise";
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Sales Rep Sum")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Rep';
                        Image = "Report";
                        RunObject = Report "Debtor Age Anly Sum-SP Wise";
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
                        RunObject = Report "Debtor Age Anly Details- BU";
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Operation wise")
                    {
                        ApplicationArea = All;
                        Caption = 'Operation';
                        Image = "Report";
                        RunObject = Report "Age Analysis Oepration Detail";
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Sales Rep wise")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Rep';
                        Image = "Report";
                        RunObject = Report "Age Analysis Sales Rep Detail";
                        ToolTip = 'View, print, or save an overview of the customers that purchase the most or that owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                }
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                ApplicationArea = All;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action("Reference Data")
            {
                ApplicationArea = All;
                RunObject = Page "Reference Data List";
            }
            action("Customer Securities")
            {
                ApplicationArea = All;
                RunObject = Page "Customer Security List";
            }
            action("User Setup")
            {
                ApplicationArea = All;
                RunObject = Page "User Setup";
            }
            action("Delivery Schedule")
            {
                ApplicationArea = All;
                Caption = 'Delivery Schedule';
                RunObject = Page "Delivery Schedule";
            }
            action("Approval User Setup")
            {
                ApplicationArea = All;
                Caption = 'Approval User Setup';
                RunObject = Page "Approval User Setup";
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(Balance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Balance1)
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
            action("Client Approval Entries")
            {
                ApplicationArea = All;
                Caption = 'Client Approval Entries';
                RunObject = Page "Client Approval Entries";
            }
            action("Sales Budget")
            {
                ApplicationArea = All;
                Caption = 'Sales Budget';
                RunObject = Page "Budget Names Sales";
            }
            action("G/L Budgets")
            {
                ApplicationArea = All;
                Caption = 'G/L Budgets';
                RunObject = Page "G/L Budget Names";
            }
            action("Account Schedules1")
            {
                ApplicationArea = All;
                Caption = 'Account Schedules';
                RunObject = Page "Account Schedule Names";
            }
            action(Employees)
            {
                ApplicationArea = All;
                Caption = 'Employees';
                RunObject = Page "Employee List";
            }
            action(Budgets)
            {
                ApplicationArea = All;
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
            }
            action("Bank Accounts")
            {
                ApplicationArea = All;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
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
                    RunObject = Page "Posted Sales Shipments";
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
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
                    RunObject = Page "Posted Sales Credit Memos";
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
                action("G/L Registers")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                }
                action("Value Entries")
                {
                    ApplicationArea = All;
                    RunObject = Page "Value Entries";
                }
                action("Item Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Item Ledger Entries';
                    RunObject = Page "Item Ledger Entries";
                }
                action("General Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'General Ledger Entries';
                    RunObject = Page "General Ledger Entries";
                }
                action("Unidentified Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Unidentified Ledger Entries';
                    RunObject = Page "Unidentified Ledger Entries";
                }
                action("Bank Account Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account Ledger Entries';
                    RunObject = Page "Bank Account Ledger Entries";
                }
                action("Vendor Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Entries';
                    RunObject = Page "Vendor Ledger Entries";
                }
                action("Customer Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Ledger Entries';
                    RunObject = Page "Customer Ledger Entries";
                }
                action("Check Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Check Ledger Entries';
                    RunObject = Page "Check Ledger Entries";
                }
            }
            group("Sales Incentive1")
            {
                Caption = 'Sales Incentive';
                Image = Administration;
            }
            group(Administration1)
            {
                Caption = 'Administration';
                Image = Administration;
                action(Currencies)
                {
                    ApplicationArea = All;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                }
                action("Number Series")
                {
                    ApplicationArea = All;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                }
                action("Analysis Views")
                {
                    ApplicationArea = All;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                }
                action("Account Schedules")
                {
                    ApplicationArea = All;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                }
            }
        }
        area(processing)
        {
            group(Setup1)
            {
                Caption = 'Setup';
                Image = Setup;
                group(Setup)
                {
                    Caption = 'Setup';
                    Image = Setup;
                    action("Company Information")
                    {
                        ApplicationArea = All;
                        Caption = 'Company Information';
                        Image = CompanyInformation;
                        RunObject = Page "Company Information";
                        ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                    }
                    action("General Ledger Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'General Ledger Setup';
                        Image = JournalSetup;
                        RunObject = Page "General Ledger Setup";
                        ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                    }
                    action("Sales & Receivables Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales & Receivables Setup';
                        Image = ReceivablesPayablesSetup;
                        RunObject = Page "Sales & Receivables Setup";
                        ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    }
                    action("Purchases & Payables Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchases & Payables Setup';
                        Image = Purchase;
                        RunObject = Page "Purchases & Payables Setup";
                        ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    }
                    action("Client Approval Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Client Approval Setup';
                        Image = ApprovalSetup;
                        RunObject = Page "Client Approval Setup";
                    }
                }
                group(Journals)
                {
                    Caption = 'Journals';
                    Image = Journals;
                    action("Cas&h Receipt Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Cas&h Receipt Journal';
                        Image = CashReceiptJournal;
                        RunObject = Page "Cash Receipt Journal";
                    }
                    action("Pa&yment Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Pa&yment Journal';
                        Image = PaymentJournal;
                        RunObject = Page "Payment Journal";
                    }
                    action("Phys. Inventory Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Phys. Inventory Journal';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Journal";
                    }
                    action("Revaluation Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Revaluation Journal';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Revaluation Journal";
                    }
                }
                group("Incentive Calculation")
                {
                    Caption = 'Incentive Calculation';
                    Image = Sales;
                    action("Product Categories")
                    {
                        ApplicationArea = All;
                        Caption = 'Product Categories';
                        Image = PayrollStatistics;
                        RunObject = Page "Product Categories";
                    }
                    action("Sales Targets")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Targets';
                        Image = Sales;
                        RunObject = Page "Sales Targets";
                    }
                    action("Collection Incentive Scheme")
                    {
                        ApplicationArea = All;
                        Caption = 'Collection Incentive Scheme';
                        Image = Receipt;
                        RunObject = Page "Collection Incentive Scheme";
                    }
                    action("PD Cheque Incentive Scheme")
                    {
                        ApplicationArea = All;
                        Caption = 'PD Cheque Incentive Scheme';
                        Image = Check;
                        RunObject = Page "PD Cheque Incentive Scheme";
                    }
                    action("Sales Incentive Scheme")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Incentive Scheme';
                        Image = Sales;
                        RunObject = Page "Sales Incentive Scheme";
                    }
                    action("Debtor Incentive Scheme")
                    {
                        ApplicationArea = All;
                        Caption = 'Debtor Incentive Scheme';
                        Image = Customer;
                        RunObject = Page "Debtor Incentive Scheme";
                    }
                    action("Salesperson Hierarchy")
                    {
                        ApplicationArea = All;
                        Caption = 'Salesperson Hierarchy';
                        Image = Hierarchy;
                        RunObject = Page "Salesperson Hierarchy";
                    }
                    action("Customized Aging Report")
                    {
                        ApplicationArea = All;
                        Image = "Report";

                        RunObject = Report "Customized Debtor Age Anly";
                    }
                    action("Sales Incentive")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Incentive';
                        Image = "Report";
                        RunObject = Report "Payment Voucher  - Online";
                    }
                    action("Individual Sales Targets")
                    {
                        ApplicationArea = All;
                        Caption = 'Individual Sales Targets List';
                        Image = "Report";
                        RunObject = Report "Individual Sales Targets";
                    }
                    action("Collection Incentive List")
                    {
                        ApplicationArea = All;
                        Caption = 'Collection Incentive List';
                        Image = "Report";
                        RunObject = Report "Collection Incentive Scheme";
                    }
                    action("Sales Incentive List")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Incentive List';
                        Image = "Report";
                        RunObject = Report "Sales Incentive Scheme";
                    }
                    action("Debtor Incentive List")
                    {
                        ApplicationArea = All;
                        Caption = 'Debtor Incentive List';
                        Image = "Report";
                        RunObject = Report "Debtor Incentive Scheme";
                    }
                }
            }
            // separator()
            // {
            // }
            action("Analysis View List Sales")
            {
                ApplicationArea = All;
                Caption = 'Analysis View List Sales';
                Image = AnalysisView;
                RunObject = Page "Analysis View List Sales";
            }
            action("Calculate Deprec&iation")
            {
                ApplicationArea = All;
                Caption = 'Calculate Deprec&iation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report "Calculate Depreciation";
            }
            action("Bank Account R&econciliation")
            {
                ApplicationArea = All;
                Caption = 'Bank Account R&econciliation';
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation";
            }
            action("Query Reports")
            {
                ApplicationArea = All;
                Caption = 'Query Reports';
                Image = Excel;
                RunObject = Page "Excel Reports";
            }
            action("Change Salesperson")
            {
                ApplicationArea = All;
                Caption = 'Change Salesperson';
                Image = SalesPerson;
                RunObject = Report "Customized Debtor Age Anly";
            }
            action("Change Cus. Payment Method")
            {
                ApplicationArea = All;
                Caption = 'Change Cus. Payment Method';
                Image = Payment;
                RunObject = Report "Pending SRN With Status";
            }
            separator(Administration)
            {

                Caption = 'Administration';
                IsHeader = true;
            }
            separator(History)
            {

                Caption = 'History';
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
            // {ApplicationArea = All;
            //     Caption = 'Change Password';
            //     Image = Permission;
            //     RunObject = Page 9809;
            // }
            action("Change Log Entries")
            {
                ApplicationArea = All;
                Image = ChangeLog;
                RunObject = Page "Change Log Entries";
            }
            separator(Incentive)
            {

                Caption = 'Incentive';
                IsHeader = false;
            }
        }
    }
}

