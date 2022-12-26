report 50065 "Individual Sales Targets"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/IndividualSalesTargets.rdl';

    dataset
    {
        dataitem("Sales Targets"; "Sales Targets")
        {
            column(TargetYear; "Sales Targets"."Target Year")
            {
            }
            column(TargeMonth; "Sales Targets"."Target Month")
            {
            }
            column(SalespersonCode; "Sales Targets"."Salesperson Code")
            {
            }
            column(ProductCategoryCode; "Sales Targets"."Product Category Code")
            {
            }
            column(SalepPersonName; "Sales Targets"."SalepPerson Name")
            {
            }
            column(Designation; "Sales Targets".Designation)
            {
            }
            column(TerritoryCode; "Sales Targets"."Territory Code")
            {
            }
            column(TargetValue; "Sales Targets"."Target Value")
            {
            }
            column(BUCode; BUCode)
            {
            }
            column(Com_Name; ComInfo.Name)
            {
            }
            column(Com_Address; ComInfo.Address)
            {
            }
            column(City; ComInfo.City)
            {
            }
            column(Tell; ComInfo."Phone No.")
            {
            }
            column(Vat_No; ComInfo."VAT Registration No.")
            {
            }
            column(Fax_No; ComInfo."Fax No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF SalesPerRec.GET("Sales Targets"."Salesperson Code") THEN
                    BUCode := SalesPerRec."Global Dimension 1 Code"
                ELSE
                    BUCode := '';
            end;

            trigger OnPreDataItem()
            begin
                IF ComInfo.GET THEN;
                "Sales Targets".SETFILTER("Target Year", '%1', "Target Year");
                "Sales Targets".SETFILTER("Target Month", '%1', "Target Month");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(TargetYear;
                "Sales Targets"."Target Year")
                {
                    Caption = 'Year';
                }
                field(TargetMonth;
                "Sales Targets"."Target Month")
                {
                    Caption = 'Month';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesPerRec: Record "Salesperson/Purchaser";
        BuName: Text[60];
        BUCode: Code[20];
        ComInfo: Record "Company Information";
}

