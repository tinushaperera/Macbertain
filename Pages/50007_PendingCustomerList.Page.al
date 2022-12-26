page 50007 "Pending Customer List"
{
    Caption = 'Pending Customer List';
    CardPageID = "Customer Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Approve';
    SourceTable = Customer;
    SourceTableView = WHERE(Blocked = CONST("Pending Approval"));
    ApplicationArea = All;
    UsageCategory = Lists;
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
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Fax No."; rec."Fax No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Contact; rec.Contact)
                {
                    ApplicationArea = all;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Customer Posting Group"; rec."Customer Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Customer Price Group"; rec."Customer Price Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Customer Disc. Group"; rec."Customer Disc. Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Reminder Terms Code"; rec."Reminder Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Fin. Charge Terms Code"; rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Language Code"; rec."Language Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Search Name"; rec."Search Name")
                {
                    ApplicationArea = all;
                }
                field("Credit Limit (LCY)"; rec."Credit Limit (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Blocked; rec.Blocked)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Last Date Modified"; rec."Last Date Modified")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Application Method"; rec."Application Method")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Combine Shipments"; rec."Combine Shipments")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Reserve; rec.Reserve)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Base Calendar Code"; rec."Base Calendar Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Tax Area Code"; rec."Tax Area Code")
                {
                    ApplicationArea = all;
                }
                field("Tax Liable"; rec."Tax Liable")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part("CRM Statistics FactBox"; "CRM Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No.");
                Visible = CRMIsCoupledToRecord;
            }
            // part("Social Listening FactBox"; "Social Listening FactBox")
            // {
            //     SubPageLink = "Source Type" = CONST(Customer),
            //                   "Source No." = FIELD("No.");
            //     Visible = SocialListeningVisible;
            // }
            // part("Social Listening Setup FactBox"; "Social Listening Setup FactBox")
            // {
            //     SubPageLink = "Source Type" = CONST(Customer),
            //                   "Source No." = FIELD("No.");
            //     UpdatePropagation = Both;
            //     Visible = SocialListeningSetupVisible;
            // }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part("Service Hist. Sell-to FactBox"; "Service Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part("Service Hist. Bill-to FactBox"; "Service Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            // systempart(; Links)
            // {
            //     Visible = true;
            // }
            // systempart(; Notes)
            // {
            //     Visible = true;
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Customer")
            {
                Caption = '&Customer';
                Image = Customer;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(18),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    // action("Dimensions-&Multiple")
                    // {
                    //     AccessByPermission = TableData 348 = R;
                    //     Caption = 'Dimensions-&Multiple';
                    //     Image = DimensionSets;

                    //     trigger OnAction()
                    //     var
                    //         Cust: Record Customer;
                    //         DefaultDimMultiple: Page "Default Dimensions-Multiple";
                    //     begin
                    //         CurrPage.SETSELECTIONFILTER(Cust);
                    //         DefaultDimMultiple.SetMultiCust(Cust);
                    //         DefaultDimMultiple.RUNMODAL;
                    //     end;
                    // }
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account List";/////////
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("Direct Debit Mandates")
                {
                    Caption = 'Direct Debit Mandates';
                    Image = MakeAgreement;
                    RunObject = Page "SEPA Direct Debit Mandates";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("Ship-&to Addresses")
                {
                    Caption = 'Ship-&to Addresses';
                    Image = ShipAddress;
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("C&ontact")
                {
                    AccessByPermission = TableData 5050 = R;
                    Caption = 'C&ontact';
                    Image = ContactPerson;

                    trigger OnAction()
                    begin
                        rec.ShowContact;
                    end;
                }
                // action("Cross Re&ferences")
                // {
                //     Caption = 'Cross Re&ferences';
                //     Image = Change;
                //     RunObject = Page "Cross References";
                //     RunPageLink = "Cross-Reference Type" = CONST(Customer),
                //                   "Cross-Reference Type No." = FIELD("No.");
                //     RunPageView = SORTING("Cross-Reference Type", "Cross-Reference Type No.");
                // }
                action(ApprovalEntries)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RECORDID);
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoAccount)
                {
                    Caption = 'Account';
                    Image = CoupledCustomer;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM account.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(rec.RECORDID);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData 5331 = IM;
                    Caption = 'Synchronize Now';
                    Image = Refresh;
                    ToolTip = 'Send or get updated data to or from Microsoft Dynamics CRM.';

                    trigger OnAction()
                    var
                        Customer: Record Customer;
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        CustomerRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(Customer);
                        Customer.NEXT;

                        IF Customer.COUNT = 1 THEN
                            CRMIntegrationManagement.UpdateOneNow(Customer.RECORDID)
                        ELSE BEGIN
                            CustomerRecordRef.GETTABLE(Customer);
                            CRMIntegrationManagement.UpdateMultipleNow(CustomerRecordRef);
                        END
                    end;
                }
                action(UpdateStatisticsInCRM)
                {
                    Caption = 'Update Account Statistics';
                    Enabled = CRMIsCoupledToRecord;
                    Image = UpdateXML;
                    ToolTip = 'Send Customer Statistics data to Microsoft Dynamics CRM to update the Account Statistics factbox';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.CreateOrUpdateCRMAccountStatistics(Rec);
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling', Comment = 'Coupling is a noun';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData 5331 = IM;
                        Caption = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM account.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(rec.RecordId);
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData 5331 = IM;
                        Caption = 'Delete Coupling';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM account.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(rec.RECORDID);
                        end;
                    }
                }
                group(Create)
                {
                    Caption = 'Create';
                    Image = NewCustomer;
                    action(CreateInCRM)
                    {
                        Caption = 'Create Account in Dynamics CRM';
                        Image = NewCustomer;

                        trigger OnAction()
                        var
                            Customer: Record Customer;
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                            CustomerRecordRef: RecordRef;
                        begin
                            CurrPage.SetSelectionFilter(Customer);
                            CRMIntegrationManagement.CreateNewRecordsInCRM(Customer);
                        end;
                    }
                    action(CreateFromCRM)
                    {
                        Caption = 'Create Customer in Dynamics NAV';
                        Image = NewCustomer;

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.ManageCreateNewRecordFromCRM(DATABASE::Customer);
                        end;
                    }
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("S&ales1")
                {
                    Caption = 'S&ales';
                    Image = Sales;
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                action("Statistics by C&urrencies")
                {
                    Caption = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page "Cust. Stats. by Curr. Lines";
                    RunPageLink = "Customer Filter" = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Date Filter" = FIELD("Date Filter");
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        ItemTrackingDocMgt.ShowItemTrackingForEntity(1, rec."No.", '', '', '');
                    end;
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                Image = Sales;
                action("Invoice &Discounts")
                {
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                }
                // action(Prices)
                // {
                //     Caption = 'Prices';
                //     Image = Price;
                //     RunObject = Page "Sales Prices";
                //     RunPageLink = "Sales Type" = CONST(Customer),
                //                   "Sales Code" = FIELD("No.");
                //     RunPageView = SORTING("Sales Type", "Sales Code");
                // }
                // action("Line Discounts")
                // {
                //     Caption = 'Line Discounts';
                //     Image = LineDiscount;
                //     RunObject = Page "Sales Line Discounts";
                //     RunPageLink = "Sales Type" = CONST(Customer),
                //                   "Sales Code" = FIELD("No.");
                //     RunPageView = SORTING("Sales Type", "Sales Code");
                // }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Sales Type" = CONST(Customer),
                                  "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                }
                action("S&td. Cust. Sales Codes")
                {
                    Caption = 'S&td. Cust. Sales Codes';
                    Image = CodesList;
                    RunObject = Page "Standard Customer Sales Codes";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Quotes)
                {
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Image = Documents;
                    action("Issued &Reminders")
                    {
                        Caption = 'Issued &Reminders';
                        Image = OrderReminder;
                        RunObject = Page "Issued Reminder List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        Caption = 'Issued &Finance Charge Memos';
                        Image = FinChargeMemo;
                        RunObject = Page "Issued Fin. Charge Memo List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                    }
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Sales Orders";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                }
            }
            group("Credit Card")
            {
                Caption = 'Credit Card';
                Image = CreditCard;
                // group("Credit Cards")
                // {
                //     Caption = 'Credit Cards';
                //     Image = CreditCard;
                //     action("C&redit Cards")
                //     {
                //         Caption = 'C&redit Cards';
                //         Image = CreditCard;
                //         RunObject = Page 828; //cand find page - TL
                //         RunPageLink = "Customer No." = FIELD("No.");
                //     }
                //     action("Credit Cards Transaction Lo&g Entries")
                //     {
                //         Caption = 'Credit Cards Transaction Lo&g Entries';
                //         Image = CreditCardLog;
                //         RunObject = Page 829;
                //         RunPageLink = "Customer No." = FIELD("No.");
                //     }
                // }
            }
            group(Service)
            {
                Caption = 'Service';
                Image = ServiceItem;
                action("Service Orders")
                {
                    Caption = 'Service Orders';
                    Image = Document;
                    RunObject = Page "Service Orders";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Customer No.");
                }
                action("Ser&vice Contracts")
                {
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Customer Service Contracts";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                }
                action("Service &Items")
                {
                    Caption = 'Service &Items';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                }
            }
        }
        area(creation)
        {
            action("Blanket Sales Order")
            {
                Caption = 'Blanket Sales Order';
                Image = BlanketOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Blanket Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Quote")
            {
                Caption = 'Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Invoice")
            {
                Caption = 'Sales Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Invoice";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Order")
            {
                Caption = 'Sales Order';
                Image = Document;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Credit Memo")
            {
                Caption = 'Sales Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Sales Credit Memo";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Return Order")
            {
                Caption = 'Sales Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Sales Return Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Quote")
            {
                Caption = 'Service Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Line List";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Invoice")
            {
                Caption = 'Service Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Invoice";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Order")
            {
                Caption = 'Service Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Order";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Credit Memo")
            {
                Caption = 'Service Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Credit Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action(Reminder1)
            {
                Caption = 'Reminder';
                Image = Reminder;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page Reminder;
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Finance Charge Memo")
            {
                Caption = 'Finance Charge Memo';
                Image = FinChargeMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Finance Charge Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                Visible = false;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendCustomerForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
                    end;
                }
            }
            action("Cash Receipt Journal")
            {
                Caption = 'Cash Receipt Journal';
                Image = CashReceiptJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Cash Receipt Journal";
            }
            action("Sales Journal")
            {
                Caption = 'Sales Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sales Journal";
            }
        }
        area(reporting)
        {
            group(General1)
            {
                Caption = 'General';
                action("Customer List")
                {
                    Caption = 'Customer List';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - List";
                }
                action("Customer Register")
                {
                    Caption = 'Customer Register';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer Register";
                }
                action("Customer - Top 10 List")
                {
                    Caption = 'Customer - Top 10 List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Top 10 List";
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                action("Customer - Order Summary")
                {
                    Caption = 'Customer - Order Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Order Summary";
                }
                action("Customer - Order Detail")
                {
                    Caption = 'Customer - Order Detail';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Order Detail";
                }
                action("Customer - Sales List")
                {
                    Caption = 'Customer - Sales List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Sales List";
                }
                action("Sales Statistics")
                {
                    Caption = 'Sales Statistics';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Sales Statistics";
                }
                action("Customer/Item Sales")
                {
                    Caption = 'Customer/Item Sales';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer/Item Sales";
                }
            }
            group("Financial Management")
            {
                Caption = 'Financial Management';
                Image = "Report";
                action("Customer - Detail Trial Bal.")
                {
                    Caption = 'Customer - Detail Trial Bal.';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Detail Trial Bal.";
                }
                action("Customer - Summary Aging")
                {
                    Caption = 'Customer - Summary Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Summary Aging";
                }
                action("Customer Detailed Aging")
                {
                    Caption = 'Customer Detailed Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer Detailed Aging";
                }
                action(Statement)
                {
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Codeunit "Customer Layout - Statement";
                }
                action(Reminder)
                {
                    Caption = 'Reminder';
                    Image = Reminder;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report Reminder;
                }
                action("Aged Accounts Receivable")
                {
                    Caption = 'Aged Accounts Receivable';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                }
                action("Customer - Balance to Date")
                {
                    Caption = 'Customer - Balance to Date';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Balance to Date";
                }
                action("Customer - Trial Balance")
                {
                    Caption = 'Customer - Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Trial Balance";
                }
                action("Customer - Payment Receipt")
                {
                    Caption = 'Customer - Payment Receipt';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Payment Receipt";
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        //SetSocialListeningFactboxVisibility;

        CRMIsCoupledToRecord :=
          CRMCouplingManagement.IsRecordCoupledToCRM(rec.RECORDID) AND CRMIntegrationEnabled;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;

    // trigger OnAfterGetRecord()
    // begin
    //     SetSocialListeningFactboxVisibility;
    // end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SocialListeningSetupVisible: Boolean;
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;


    procedure GetSelectionFilter(): Text
    var
        Cust: Record Customer;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        EXIT(SelectionFilterManagement.GetSelectionFilterForCustomer(Cust));
    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;

    // local procedure SetSocialListeningFactboxVisibility()
    // var
    //     SocialListeningMgt: Codeunit "871";
    // begin
    //     SocialListeningMgt.GetCustFactboxVisibility(Rec, SocialListeningSetupVisible, SocialListeningVisible);
    // end;
}

