report 50069 "Debtor Incentive Scheme"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/DebtorIncentiveScheme.rdl';

    dataset
    {
        dataitem("Sales Incentives"; "Sales Incentives")
        {
            DataItemTableView = WHERE("Icentive Type" = CONST(Collection),
                                      Month = CONST(0));
            column(Year; Year)
            {
            }
            column(Month; Month)
            {
            }
            column(GlobalDim1; "Global Dimension 1 Code")
            {
            }
            column(Designation; Designation)
            {
            }
            column(BUProductCategory; "Sales Incentives"."BU Product Category")
            {
            }
            column(Rate1; "Rate 1")
            {
            }
            column(Rate2; "Rate 2")
            {
            }
            column(Rate3; "Rate 3")
            {
            }
            column(Rate4; "Rate 4")
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

            trigger OnPreDataItem()
            begin
                IF ComInfo.GET THEN;

                "Sales Incentives".SETFILTER(Year, '%1', "Sales Incentives".Year);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Sales Incentives Year";
                "Sales Incentives".Year)
                {
                    Caption = 'Year';
                }
                field("Sales Incentives Global Dimension 1 Code";
                "Sales Incentives"."Global Dimension 1 Code")
                {
                    CaptionClass = '1,1,1';
                    Caption = 'BU';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
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
        ComInfo: Record "Company Information";
}

