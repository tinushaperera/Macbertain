page 50018 "Import Job Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Import Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("LC No."; rec."LC No.")
                {
                    ApplicationArea = all;
                }
                field("LC Opening date"; rec."LC Opening date")
                {
                    ApplicationArea = all;
                    Caption = 'LC Opening Date';
                }
                field(Currency; rec.Currency)
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Bank Bill No"; rec."Bank Bill No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Guarentees)
            {
                Caption = 'Guarentees';
                Image = Purchasing;
                action(ShippingGuarentee)
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Guarentee';
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ShipGuaRec: Record "Shipping Guarantee";
                        ShipGuaPg: Page "Shipping Guarentee List";
                    begin
                        ShipGuaRec.RESET;
                        ShipGuaRec.SETRANGE("Shipping Guarantee Type", ShipGuaRec."Shipping Guarantee Type"::Guarantee);
                        ShipGuaRec.SETFILTER("Import Job No.", rec."No.");
                        ShipGuaPg.SETTABLEVIEW(ShipGuaRec);
                        ShipGuaPg.SetImportJobNo(rec."No.");
                        ShipGuaPg.RUN;
                    end;
                }
                action(ContainerDeposits)
                {
                    ApplicationArea = All;
                    Caption = 'Container Deposits';
                    Image = DepositSlip;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ShipGuaRec: Record "Shipping Guarantee";
                        ShipGuaPg: Page "Container Deposit List";
                    begin
                        ShipGuaRec.RESET;
                        //ShipGuaPg.CAPTION := 'Container Deposit'  ;
                        ShipGuaRec.SETRANGE("Shipping Guarantee Type", ShipGuaRec."Shipping Guarantee Type"::Deposit);
                        ShipGuaRec.SETFILTER("Import Job No.", rec."No.");
                        ShipGuaPg.SETTABLEVIEW(ShipGuaRec);
                        ShipGuaPg.SetImportJobNo(rec."No.");
                        ShipGuaPg.RUN;
                    end;
                }
            }
        }
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                group(SalesReports)
                {
                    Caption = 'Import Loan Facility';
                    Image = "Report";
                    action("Short Term Loan-STL")
                    {
                        ApplicationArea = All;
                        Caption = 'Short Term Loan-STL';
                        Image = "Report";
                        RunObject = Report "Short Term Loan-STL";
                    }
                    action("Import Loan-LC")
                    {
                        ApplicationArea = All;
                        Caption = 'Import Loan-LC';
                        Image = "Report";
                        RunObject = Report "Import Loan-LC";
                    }
                    action("Import Loan - DA")
                    {
                        ApplicationArea = All;
                        Caption = 'Import Loan-DA';
                        Image = Report;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Report;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Report "Import Loan-DA";
                    }
                    action("Receipt Letter - SLT")
                    {
                        ApplicationArea = All;
                        Caption = 'STL-Receipt';
                        Image = Report;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Report "Receipt Letter - SLT";
                    }
                    action("Receipt Letter - LC")
                    {
                        ApplicationArea = All;
                        Caption = 'Import Loan LC-Receipt';
                        Image = Report;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Report "Receipt Letter - LC";
                    }
                    action("Receipt Letter - DA")
                    {
                        ApplicationArea = All;
                        Caption = 'Import Loan DA-Receipt';
                        Image = Report;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Report "Receipt Letter-DA";
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PageEdit := NOT (rec.Status = rec.Status::Closed);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Date := TODAY;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        PageEdit := NOT (rec.Status = rec.Status::Closed);
    end;

    var
        PageEdit: Boolean;
}

