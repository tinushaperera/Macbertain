report 50045 "Sales Invoice-Tube"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/SalesInvoiceTube.rdl';
    Permissions = TableData 112 = rimd;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(Cus_No; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(CusName; CusRec.Name)
            {
            }
            column(CusAdd1; CusRec.Address)
            {
            }
            column(CusAdd2; CusRec."Address 2")
            {
            }
            column(CusCity; CusRec.City)
            {
            }
            column(VatReg; CusRec."VAT Registration No.")
            {
            }
            column(CusCont; CusRec.Contact)
            {
            }
            column(CusTell; CusRec."Phone No.")
            {
            }
            column(SVATReg; CusRec."SVAT Registration No.")
            {
            }
            column(Payment_Mothod; "Sales Invoice Header"."Payment Method Code")
            {
            }
            column(INV_No; "Sales Invoice Header"."No.")
            {
            }
            column(Date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(Extenal; "Sales Invoice Header"."External Document No.")
            {
            }
            column(ComVATReg; ComRec."VAT Registration No.")
            {
            }
            column(NBTReg; CusRec."NBT Registration No.")
            {
            }
            column(ComSVATNo; ComRec."SVAT No.")
            {
            }
            column(PaymentTems; "Sales Invoice Header"."Payment Terms Code")
            {
            }
            column(Caption; Caption)
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(FoterTxt; FoterTxt)
            {
            }
            column(SVAT; "Sales Invoice Header"."SVAT %")
            {
            }
            column(SVATAmt; SVATAmt)
            {
            }
            column(SVATText; SVATText)
            {
            }
            column(Dup; Dup)
            {
            }
            column(OrdNo; "Sales Invoice Header"."Order No.")
            {
            }
            column(InvDoisNo; DisNo)
            {
            }
            column(dim; "Sales Invoice Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShipItem; SalesShipLine."No.")
            {
            }
            column(ShipDes; SalesShipLine.Description)
            {
            }
            column(ShipUOM; SalesShipLine."Unit of Measure Code")
            {
            }
            column(ShipQty; SalesShipLine.Quantity)
            {
            }
            column(ShipNo; SalesShipHedd."No.")
            {
            }
            column(ShipCusName; SalesShipHedd."Sell-to Customer Name")
            {
            }
            column(Ref; SalesShipHedd."Sell-to Customer No.")
            {
            }
            column(ShipDesdate; SalesShipHedd."Document Date")
            {
            }
            column(ShipLoc; SalesShipHedd."Location Code")
            {
            }
            column(ShipShipNo; SalesShipHedd."No.")
            {
            }
            column(ShipOrdNo; SalesShipHedd."Order No.")
            {
            }
            column(ShipInvDIs; SalesShipHedd."Invoice Despatch No.")
            {
            }
            column(ExchangRete; ExchangRete)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                column(ShipComName; ComRec.Name)
                {
                }
                column(ShipComAdd; ComRec.Address)
                {
                }
                column(ShipComAdd2; ComRec."Address 2")
                {
                }
                column(ShipComPhnNo; ComRec."Phone No.")
                {
                }
                column(ShipComFaxNo; ComRec."Fax No.")
                {
                }
                column(ShipComEmail; ComRec."E-Mail")
                {
                }
                column(ItemNo; "Sales Invoice Line"."No.")
                {
                }
                column(Description; "Sales Invoice Line".Description)
                {
                }
                column(Description2; "Sales Invoice Line"."Description 2")
                {
                }
                column(UOM; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(Qty; "Sales Invoice Line".Quantity)
                {
                }
                column(UntPrice; UnitPrice)
                {
                }
                column(Amt; "Sales Invoice Line".Amount)
                {
                }
                column(NBTAmount; NBTAmount)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(AmtInc; AmtIncVat)
                {
                }
                column(SubTot; SubTot)
                {
                }
                column(TaxArea; "Sales Invoice Line"."Tax Area Code")
                {
                }
                column(UnitP; "Sales Invoice Line"."Unit Price")
                {
                }

                trigger OnAfterGetRecord()
                var
                    CalCompTax: Codeunit "Calculate Tax Of Company";
                begin
                    NBTAmount := 0;
                    VATAmount := 0;
                    AmtIncVat := 0;
                    IF Quantity = 0 THEN
                        CurrReport.SKIP;

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
                                //VATAmount := ((Amount + NBTAmount) * 11)/100;
                                SubTot := Amount;// + NBTAmount;
                                IF (SubTot <> 0) AND (Quantity <> 0) THEN
                                    UnitPrice := SubTot / Quantity;
                                NBTAmount := 0;
                                AmtIncVat := SubTot + VATAmount + NBTAmount;
                            END
                            ELSE
                                IF ("Tax Area Code" = 'VAT15') THEN BEGIN
                                    CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", Amount,
                                        NBTAmount);
                                    CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", Amount, NBTAmount,
                                        VATAmount);
                                    //VATAmount := ((Amount + NBTAmount) * 15)/100;
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
                                //VATAmount := ((Amount + NBTAmount) * 11)/100;
                                SubTot := Amount + NBTAmount;
                                IF (SubTot <> 0) AND (Quantity <> 0) THEN
                                    UnitPrice := SubTot / Quantity;
                                AmtIncVat := SubTot + VATAmount;
                                NBTAmount := 0;
                            END
                            ELSE
                                IF ("Tax Area Code" = 'VAT15') THEN BEGIN
                                    CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", Amount,
                                        NBTAmount);
                                    CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", Amount, NBTAmount,
                                        VATAmount);
                                    //VATAmount := ((Amount + NBTAmount) * 15)/100;
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
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesShipment: Record "Sales Shipment Header";
            begin
                Dup := '';
                IF "No. Printed" > 0 THEN BEGIN
                    // IF NOT User."Inv. Reprint" THEN
                    //     Dup := 'COPY';
                END;
                DisNo := '';
                CusRec.GET("Sell-to Customer No.");
                CALCFIELDS(Amount, "Amount Including VAT");
                IF ("Tax Area Code" = 'SVAT') OR ("Tax Area Code" = 'SVAT/NBT') OR ("Tax Area Code" = 'SVAT/NBT EX') THEN BEGIN
                    Caption := 'SUSPENDED';
                    SVATAmt := (("Amount Including VAT" * ComRec."SVAT Pecerntage(%)") / 100);//"SVAT %";
                    SVATText := 'Suspended VAT Amount 15%';
                END;

                IF "Currency Code" = '' THEN
                    CurrCode := 'LKR'
                ELSE
                    CurrCode := "Currency Code";

                IF "Currency Code" <> '' THEN
                    ExchangRete := 1 / "Currency Factor" //CurrncyExchangRete.ExchangeRate("Posting Date",CurrencyCode)
                ELSE
                    ExchangRete := 1;

                SalesShipHedd.RESET;
                SalesShipHedd.SETRANGE("Invoice Despatch No.", "Invoice Despatch No.");
                SalesShipHedd.SETRANGE("Order No.", "Order No.");
                IF SalesShipHedd.FINDFIRST THEN;
            end;

            trigger OnPostDataItem()
            begin
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    "No. Printed" := "No. Printed" + 1;
                    MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                ComRec.GET;
                FoterTxt := 'All cheques to be drawn in favour of "Macbertan (private) Ltd" & crossed "A/C Payee Only"';
                IF User.GET(USERSECURITYID) THEN;
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
        CusRec: Record Customer;
        ComRec: Record "Company Information";
        SalesShipHedd: Record "Sales Shipment Header";
        SalesShipLine: Record "Sales Shipment Line";
        NBTAmount: Decimal;
        VATAmount: Decimal;
        SVATAmt: Decimal;
        ExchangRete: Decimal;
        GrossTot: Decimal;
        SubTot: Decimal;
        UnitPrice: Decimal;
        AmtIncVat: Decimal;
        Caption: Text[10];
        FoterTxt: Text[100];
        SVATText: Text;
        CurrCode: Code[10];
        DisNo: Code[20];
        ItemNo: Code[10];
        Dup: Text[10];
        User: Record User;
        LoopText: Code[10];
        Counter: Integer;
        LoopText1: Code[10];
        Counter1: Integer;
}

