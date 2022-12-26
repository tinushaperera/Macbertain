report 50151 "Sales Quotation-Reserved"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SalesQuotationReserved.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(ComName; ComRec.Name)
            {
            }
            column(ComAdd1; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(ComPhnNo; ComRec."Phone No.")
            {
            }
            column(ComFaxNo; ComRec."Fax No.")
            {
            }
            column(ComEmail; ComRec."E-Mail")
            {
            }
            column(ComHomePage; ComRec."Home Page")
            {
            }
            column(CustName; CustRec.Name)
            {
            }
            column(CustCon; CustRec.Contact)
            {
            }
            column(CustDocDate; "Sales Header"."Document Date")
            {
            }
            column(Dim; DimRec.Name)
            {
            }
            column(From; From)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER(Item));
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(Amount_SalesLine; "Sales Line".Amount)
                {
                }
                column(Txt; ExtndTxtLine.Text)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ExtndTxtLine.RESET;
                    ExtndTxtLine.SETRANGE("No.", "No.");
                    ExtndTxtLine.SETRANGE(Selection, TRUE);
                    IF ExtndTxtLine.FINDFIRST THEN;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesPersonRec: Record "Salesperson/Purchaser";
                RefDeta: Record "Reference Data";
            begin
                IF CustRec.GET("Sell-to Customer No.") THEN;
                DimRec.RESET;
                DimRec.SETRANGE(Code, "Shortcut Dimension 2 Code");
                IF DimRec.FINDFIRST THEN;
                IF SalesPersonRec.GET("Salesperson Code") THEN;
                IF RefDeta.GET(RefDeta.Type::Designation, SalesPersonRec.Designation) THEN
                    From := SalesPersonRec.Name + ' - ' + RefDeta.Description;
            end;

            trigger OnPreDataItem()
            begin
                ComRec.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ComRec: Record "Company Information";
        CustRec: Record Customer;
        DimRec: Record "Dimension Value";
        ExtndTxt: Record "Extended Text Header";
        ExtndTxtLine: Record "Extended Text Line";
        From: Text[200];
}

