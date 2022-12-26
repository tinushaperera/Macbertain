report 50050 "Credit Note - Stock"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CreditNoteStock.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST("Credit Memo"));
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
            column(CusSvat; CusRec."SVAT Registration No.")
            {
            }
            dataitem(DataItem2; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
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
                column(UntPrice; UnitPrice)
                {
                }
                column(Amt; SubTot)
                {
                }
                column(NBTAmount; NBTAmount)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(AmtIncVAT; AmtIncVat)
                {
                }

                trigger OnAfterGetRecord()
                var
                    CalCompTax: Codeunit "Calculate Tax Of Company";
                begin
                    NBTAmount := 0;
                    VATAmount := 0;
                    AmtIncVat := 0;

                    CusRec.GET("Sell-to Customer No.");
                    IF CusRec."NBT Registration No." <> '' THEN BEGIN
                        IF ("Tax Area Code" = 'NON-TAX') OR ("Tax Area Code" = 'SVAT') THEN BEGIN
                            NBTAmount := 0;
                            VATAmount := 0;
                            SubTot := "Amount Including VAT";
                            IF Quantity <> 0 THEN
                                UnitPrice := ("Amount Including VAT" / Quantity);
                            AmtIncVat := SubTot + VATAmount;
                        END
                        ELSE
                            IF ("Tax Area Code" = 'VAT11') THEN BEGIN
                                CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", Amount,
                                    NBTAmount);
                                CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", Amount, NBTAmount,
                                    VATAmount);
                                SubTot := Amount + NBTAmount;
                                IF SubTot <> 0 THEN
                                    UnitPrice := SubTot / Quantity;
                                NBTAmount := 0;
                                AmtIncVat := SubTot + VATAmount;
                            END
                            ELSE
                                IF ("Tax Area Code" = 'VAT15') THEN BEGIN
                                    CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", Amount,
                                        NBTAmount);
                                    VATAmount := ((Amount + NBTAmount) * 15) / 100;
                                    SubTot := Amount + NBTAmount;
                                    IF (SubTot <> 0) AND (Quantity <> 0) THEN
                                        UnitPrice := SubTot / Quantity;
                                    NBTAmount := 0;
                                    AmtIncVat := SubTot + VATAmount;
                                END
                                ELSE BEGIN
                                    IF "Tax Liable" THEN
                                        CalCompTax.CalTaxOnTax("Tax Group Code", "Tax Area Code", Amount,
                                          NBTAmount, VATAmount);
                                    SubTot := Amount;
                                    AmtIncVat := SubTot + VATAmount + NBTAmount;
                                    IF (SubTot <> 0) AND (Quantity <> 0) THEN
                                        UnitPrice := SubTot / Quantity; //"Unit Price";
                                END;
                    END
                    ELSE BEGIN
                        IF ("Tax Area Code" = 'NON-TAX') OR ("Tax Area Code" = 'SVAT') THEN BEGIN
                            NBTAmount := 0;
                            VATAmount := 0;
                            SubTot := "Amount Including VAT";
                            IF Quantity <> 0 THEN
                                UnitPrice := ("Amount Including VAT" / Quantity);
                            AmtIncVat := SubTot + VATAmount;
                        END
                        ELSE
                            IF ("Tax Area Code" = 'VAT11') THEN BEGIN
                                CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", Amount,
                                    NBTAmount);
                                CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", Amount, NBTAmount,
                                    VATAmount);
                                SubTot := Amount + NBTAmount;
                                IF SubTot <> 0 THEN
                                    UnitPrice := SubTot / Quantity;
                                NBTAmount := 0;
                                AmtIncVat := SubTot + VATAmount;
                            END
                            ELSE
                                IF ("Tax Area Code" = 'VAT15') THEN BEGIN
                                    CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", Amount,
                                        NBTAmount);
                                    CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", Amount,
                                        VATAmount);
                                    SubTot := Amount + NBTAmount;
                                    IF (SubTot <> 0) AND (Quantity <> 0) THEN
                                        UnitPrice := SubTot / Quantity;
                                    NBTAmount := 0;
                                    AmtIncVat := SubTot + VATAmount;
                                END
                                ELSE BEGIN
                                    IF "Tax Liable" THEN
                                        CalCompTax.CalTaxOnTax("Tax Group Code", "Tax Area Code", Amount,
                                          NBTAmount, VATAmount);
                                    SubTot := Amount;
                                    NBTAmount := 0;
                                    AmtIncVat := SubTot + VATAmount + NBTAmount;
                                    IF (SubTot <> 0) AND (Quantity <> 0) THEN
                                        UnitPrice := SubTot / Quantity; //"Unit Price";
                                END;
                    END;
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
        UnitPrice: Decimal;
        AmtIncVat: Decimal;
        SubTot: Decimal;
}

