page 50051 "ICT Role Center"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(grp1)
            {
                part("IT Operations Activities"; "IT Operations Activities")
                {
                    ApplicationArea = All;
                    Caption = 'IT Operations Activities';
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
            action("Check on Ne&gative Inventory")
            {
                ApplicationArea = All;
                Caption = 'Check on Ne&gative Inventory';
                Image = "Report";
                RunObject = Report "Items with Negative Inventory";
            }
            action("Customer-Order Detail With Qty")
            {
                ApplicationArea = All;
                Caption = 'Customer-Order Detail With Qty';
                Image = "Report";
                RunObject = Report "Customer-Order Detail With Qty";
            }
        }
        area(embedding)
        {
            action(Users)
            {
                ApplicationArea = All;
                RunObject = Page Users;
            }
            action("User Setup")
            {
                ApplicationArea = All;
                Caption = 'User Setup';
                Image = UserSetup;
                RunObject = Page "User Setup";
            }
            action("Reference Data")
            {
                ApplicationArea = All;
                RunObject = Page "Reference Data List";
            }
            action("Role Tailored Client")
            {
                ApplicationArea = All;
                RunObject = Page "User Settings List";
            }
            action("Client Approval Entries")
            {
                ApplicationArea = All;
                RunObject = Page "Client Approval Entries";
            }
            action("Profile List")
            {
                ApplicationArea = All;
                RunObject = Page "Profile List";
            }
            action("Permission Sets")
            {
                ApplicationArea = All;
                RunObject = Page "Permission Sets";
            }
            action("User Time Registers")
            {
                ApplicationArea = All;
                Caption = 'User Time Registers';
                RunObject = Page "User Time Registers";
            }
            action("No. Series")
            {
                ApplicationArea = All;
                Caption = 'No. Series';
                RunObject = Page "No. Series";
            }
            action("Approval User Setup")
            {
                ApplicationArea = All;
                Caption = 'Approval User Setup';
                RunObject = Page "Approval User Setup";
            }
            action("Data Templates List")
            {
                ApplicationArea = All;
                Caption = 'Data Templates List';
                RunObject = Page "Config. Template List";
            }
            action("Post Codes")
            {
                ApplicationArea = All;
                Caption = 'Post Codes';
                RunObject = Page "Post Codes";
            }
            action("Reason Codes")
            {
                ApplicationArea = All;
                Caption = 'Reason Codes';
                RunObject = Page "Reason Codes";
            }
            action(Employees)
            {
                ApplicationArea = All;
                RunObject = Page "Employee List";
            }
            action("User Personalization List")
            {
                ApplicationArea = All;
                RunObject = Page "User Settings";
            }
            action("Generic Charts")
            {
                ApplicationArea = All;
                RunObject = Page "Generic Charts";
            }
            action("Web Services")
            {
                ApplicationArea = All;
                RunObject = Page "Web Services";
            }
            // action("Session List")
            // {ApplicationArea = All;
            //     RunObject = Page session;
            // }
            action("Config. Packages")
            {
                ApplicationArea = All;
                Caption = 'Config. Packages';
                RunObject = Page "Config. Packages";
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
                    RunObject = Page 6662;
                }
                action("<Posted Return Shipments>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page 6652;
                }
                action("<Posted Assembly Orders>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page 922;
                }
                action("G/L Registers")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page 116;
                }
                action("Item Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Item Ledger Entries';
                    RunObject = Page 38;
                }
                action("General Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'General Ledger Entries';
                    RunObject = Page 20;
                }
                action("Bank Account Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account Ledger Entries';
                    RunObject = Page 372;
                }
                action("Vendor Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Ledger Entries';
                    RunObject = Page 29;
                }
                action("Customer Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Ledger Entries';
                    RunObject = Page 25;
                }
                action("Check Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Check Ledger Entries';
                    RunObject = Page 374;
                }
            }
            group("Analysis View")
            {
                Caption = 'Analysis View';
                Image = AnalysisView;
                action("Sales Analysis View List")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Analysis View List';
                    RunObject = Page 9371;
                }
                action("Purchase Analysis View List")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Analysis View List';
                    RunObject = Page 9370;
                }
                action("Inventory Analysis View List")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Analysis View List';
                    RunObject = Page 9372;
                }
            }
        }
        area(creation)
        {
            action("Purchase &Order")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Order';
                Image = Document;
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
                RunPageMode = Create;
            }
            action("Change Log Entries")
            {
                ApplicationArea = All;
                Image = ChangeLog;
                RunObject = Page 595;
            }
            // action("Change Log - Delete")
            // {
            //     ApplicationArea = All;
            //     Image = Delete;
            //     RunObject = Report "Change Log - Delete";
            // }
            action(Navigate)
            {
                ApplicationArea = All;
                Image = Navigate;
                RunObject = Page 344;
            }
            action("Analysis View List")
            {
                ApplicationArea = All;
                Image = AnalysisView;
                RunObject = Page 556;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Com&pany Information")
            {
                ApplicationArea = All;
                Caption = 'Com&pany Information';
                Image = CompanyInformation;
                RunObject = Page 1;
            }
            action("Change Salesperson")
            {
                ApplicationArea = All;
                Caption = 'Change Salesperson';
                Image = SalesPerson;
                // Promoted = true;
                // PromotedCategory = Process;
                RunObject = Report 50038;
            }
            // separator()
            // {
            // }
            group("&Change Setup")
            {
                Caption = '&Change Setup';
                Image = Setup;
                action("Client Approval Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Client Approval Setup';
                    Image = Setup;
                    RunObject = Page 50042;
                }
                action("&General Ledger Setup")
                {
                    ApplicationArea = All;
                    Caption = '&General Ledger Setup';
                    Image = Setup;
                    RunObject = Page 118;
                }
                action("Sales && Re&ceivables Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Sales && Re&ceivables Setup';
                    Image = Setup;
                    RunObject = Page 459;
                }
                action("Purchase && &Payables Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase && &Payables Setup';
                    Image = ReceivablesPayablesSetup;
                    RunObject = Page 460;
                }
                action("Fixed &Asset Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed &Asset Setup';
                    Image = Setup;
                    RunObject = Page 5607;
                }
                action("C&hange Log Setup")
                {
                    ApplicationArea = All;
                    Caption = 'C&hange Log Setup';
                    Image = LogSetup;
                    RunObject = Page 592;
                }
                action("&MapPoint Setup")
                {
                    ApplicationArea = All;
                    Caption = '&MapPoint Setup';
                    Image = MapSetup;
                    RunObject = Page 800;
                }
                // action("SMTP Mai&l Setup")
                // {ApplicationArea = All;
                //     Caption = 'SMTP Mai&l Setup';
                //     Image = MailSetup;
                //     RunObject = Page 409;
                // }
                action("Human Resources Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Human Resources Setup';
                    Image = HRSetup;
                    RunObject = Page 5233;
                }
                // action("Change Password")
                // {ApplicationArea = All;
                //     Caption = 'Change Password';
                //     Image = Permission;
                //     RunObject = Page 9809;
                // }
            }
            group("&Sales Analysis")
            {
                Caption = '&Sales Analysis';
                Image = Segment;
                action("Sales Analysis &Line Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Analysis &Line Templates';
                    Image = SetupLines;
                    RunObject = Page 7112;
                    RunPageView = SORTING("Analysis Area", Name)
                                  WHERE("Analysis Area" = CONST(Sales));
                }
                action("Sales Analysis &Column Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Analysis &Column Templates';
                    Image = SetupColumns;
                    RunObject = Page 7113;
                    RunPageView = SORTING("Analysis Area", Name)
                                  WHERE("Analysis Area" = CONST(Sales));
                }
            }
            group("P&urchase Analysis")
            {
                Caption = 'P&urchase Analysis';
                Image = Purchasing;
                action("Purchase &Analysis Line Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase &Analysis Line Templates';
                    Image = SetupLines;
                    RunObject = Page 7112;
                    RunPageView = SORTING("Analysis Area", Name)
                                  WHERE("Analysis Area" = CONST(Purchase));
                }
                action("Purchase Analysis &Column Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Analysis &Column Templates';
                    Image = SetupColumns;
                    RunObject = Page 7113;
                    RunPageView = SORTING("Analysis Area", Name)
                                  WHERE("Analysis Area" = CONST(Purchase));
                }
            }
        }
    }
}

