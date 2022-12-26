report 50066 "Collection Incentive Scheme"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CollectionIncentiveScheme.rdl';

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

