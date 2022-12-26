report 50015 "Credit Note – Stock Related"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CreditNoteStockRelated.rdl';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            column(ComName; ComRec.Name)
            {
            }
            column(ComAdd; ComRec.Address)
            {
            }
            column(ComAdd2; ComRec."Address 2")
            {
            }
            column(ComCity; ComRec.City)
            {
            }
            column(ComPH; ComRec."Phone No.")
            {
            }
            column(ComFax; ComRec."Fax No.")
            {
            }
            column(VatRegCom; ComRec."VAT Registration No.")
            {
            }
            column(CusNo; "Sell-to Customer No.")
            {
            }
            column(CusName; CusRec.Name)
            {
            }
            column(CusAdd; CusRec.Address)
            {
            }
            column(CusAdd2; CusRec."Address 2")
            {
            }
            column(Recon; ReasonCodeRec.Description)
            {
            }
            column(VatReg; CusRec."VAT Registration No.")
            {
            }
            column(CredNo; "No.")
            {
            }
            column(Date; "Posting Date")
            {
            }
            column(ExtNo; "External Document No.")
            {
            }
            column(HederTxt; HederTxt)
            {
            }
            column(SVAmt; Amt)
            {
            }
            column(REm; "Sales Cr.Memo Header".Remarks)
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Amount = FILTER(<> 0));
                column(ItemNo; "No.")
                {
                }
                column(ItemDes; Description)
                {
                }
                column(Qty; Quantity)
                {
                }
                column(UntPrice; "Unit Price")
                {
                }
                column(Amt; Amount)
                {
                }
                column(NBTAmount; NBTAmount)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(AmtIncVAT; "Amount Including VAT")
                {
                }

                trigger OnAfterGetRecord()
                var
                    CalCompTax: Codeunit "Calculate Tax Of Company";
                begin
                    NBTAmount := 0;
                    VATAmount := 0;
                    IF "Tax Liable" THEN
                        CalCompTax.CalTaxOnTax("Tax Group Code", "Tax Area Code", Amount,
                          NBTAmount, VATAmount);

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Amount Including VAT");
                IF CusRec.GET("Sell-to Customer No.") THEN;
                IF CusRec."SVAT Registration No." = '' THEN BEGIN
                    HederTxt := 'Tax';
                    Amt := 0;
                END
                ELSE BEGIN
                    HederTxt := 'Suspended Tax';
                    Amt := "Amount Including VAT" * (15 / 100);
                END;
                IF ReasonCodeRec.GET("Reason Code") THEN;
            end;

            trigger OnPreDataItem()
            var
                Amt: Decimal;
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
        CusRec: Record Customer;
        ReasonCodeRec: Record "Reason Code";
        NBTAmount: Decimal;
        VATAmount: Decimal;
        HederTxt: Text[20];
        Amt: Decimal;
}

