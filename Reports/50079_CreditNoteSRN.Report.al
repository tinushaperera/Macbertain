report 50079 "Credit Note-SRN"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CreditNoteSRN.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER("Return Order" | "Credit Memo"));
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
            column(ComVatRegNo; ComRec."VAT Registration No.")
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
            column(SelltoCity; "Sell-to City")
            {
            }
            column(VatReg; CusRec."VAT Registration No.")
            {
            }
            column(CusSvat; CusRec."SVAT Registration No.")
            {
            }
            column(Recon; ReasonCodeRec.Description)
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
            column(Amt1; Amt)
            {
            }
            column(HederTxt; HederTxt)
            {
            }
            column(AppInv; "Applies-to Doc. No.")
            {
            }
            column(InvNo; SalesInvHedd."No.")
            {
            }
            column(PostDate; SalesInvHedd."Posting Date")
            {
            }
            column(Rem; Remarks)
            {
            }
            column(InvApplyDate; InvApplyDate)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Document Type" = FIELD("Document Type");
                DataItemTableView = WHERE(Amount = FILTER(<> 0));
                column(ItemNo; "No.")
                {
                }
                column(ItemDes; Description)
                {
                }
                column(Qty; "Return Qty. Received")
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
                    CusRec: Record Customer;
                    CalCompTax: Codeunit "Calculate Tax Of Company";
                    ActPrice: Decimal;
                    DicAmt: Decimal;
                    NbtAmt: Decimal;
                    VatAmt: Decimal;
                begin
                    LineAmount := 0;
                    NBTAmount := 0;
                    VATAmount := 0;
                    AmtIncVat := 0;
                    ActPrice := 0;
                    DicAmt := 0;
                    NbtAmt := 0;
                    VatAmt := 0;
                    CusRec.GET("Sell-to Customer No.");
                    IF CusRec."NBT Registration No." <> '' THEN BEGIN
                        IF ("Tax Area Code" = 'NON-TAX') THEN BEGIN
                            LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                            CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                            CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                            SubTot := LineAmount + NBTAmount + VATAmount;
                            AmtIncVat := SubTot;
                            NBTAmount := 0;
                            VATAmount := 0;
                        END
                        ELSE
                            IF ("Tax Area Code" = 'SVAT') THEN BEGIN
                                LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                                SubTot := LineAmount + NBTAmount;
                                AmtIncVat := SubTot;
                                NBTAmount := 0;
                                VATAmount := 0;
                            END
                            ELSE
                                IF ("Tax Area Code" = 'VAT11') THEN BEGIN
                                    LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                    CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                                    CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                                    SubTot := LineAmount + NBTAmount;

                                    NBTAmount := 0;
                                    AmtIncVat := SubTot + VATAmount;
                                END
                                ELSE
                                    IF ("Tax Area Code" = 'VAT15') THEN BEGIN
                                        LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                        CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                                        CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                                        SubTot := LineAmount + NBTAmount;
                                        NBTAmount := 0;
                                        AmtIncVat := SubTot + VATAmount;
                                    END
                                    ELSE BEGIN
                                        IF "Tax Liable" THEN
                                            LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                        CalCompTax.CalTaxOnTax("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                                        SubTot := LineAmount;
                                        AmtIncVat := SubTot + VATAmount + NBTAmount;
                                        IF (SubTot <> 0) AND (Quantity <> 0) THEN
                                            UnitPrice := SubTot / Quantity;
                                    END;
                    END
                    ELSE BEGIN
                        IF ("Tax Area Code" = 'NON-TAX') THEN BEGIN
                            LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                            CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                            CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                            SubTot := LineAmount + NBTAmount + VATAmount;
                            AmtIncVat := SubTot;
                            NBTAmount := 0;
                            VATAmount := 0;
                        END
                        ELSE
                            IF ("Tax Area Code" = 'SVAT') THEN BEGIN
                                LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                                SubTot := LineAmount + NBTAmount;
                                AmtIncVat := SubTot;
                                NBTAmount := 0;
                                VATAmount := 0;
                            END
                            ELSE
                                IF ("Tax Area Code" = 'VAT11') THEN BEGIN
                                    LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                    CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                                    CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                                    SubTot := LineAmount + NBTAmount;
                                    NBTAmount := 0;
                                    AmtIncVat := SubTot + VATAmount;
                                END
                                ELSE
                                    IF ("Tax Area Code" = 'VAT15') THEN BEGIN
                                        LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                        CalCompTax.CalNBT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount);
                                        CalCompTax.CalVAT("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                                        SubTot := LineAmount + NBTAmount;
                                        NBTAmount := 0;
                                        AmtIncVat := SubTot + VATAmount;
                                    END
                                    ELSE BEGIN
                                        IF "Tax Liable" THEN
                                            LineAmount := ("Unit Price" * "Qty. to Invoice") - (("Unit Price" * "Qty. to Invoice") * "Line Discount %" / 100);
                                        CalCompTax.CalTaxOnTax("Tax Group Code", "Tax Area Code", LineAmount, NBTAmount, VATAmount);
                                        SubTot := LineAmount;
                                        NBTAmount := 0;
                                        AmtIncVat := SubTot + VATAmount + NBTAmount;
                                    END;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CustmrLdgrEntry: Record "Cust. Ledger Entry";
            begin
                InvApplyDate := 0D;
                CALCFIELDS("Amount Including VAT");
                IF CusRec.GET("Sell-to Customer No.") THEN;
                IF CusRec."SVAT Registration No." = '' THEN BEGIN
                    HederTxt := 'Tax';
                    Amt := 0;
                END
                ELSE BEGIN
                    HederTxt := 'Suspended Tax';
                    Amt := (("Amount Including VAT" * ComRec."SVAT Pecerntage(%)") / 100);
                END;
                IF "Tax Area Code" = 'NON-TAX' THEN BEGIN
                    HederTxt := ''
                END;
                IF ReasonCodeRec.GET("Reason Code") THEN;
                IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN
                    IF SalesInvHedd.GET("Applies-to Doc. No.") THEN
                        InvApplyDate := SalesInvHedd."Document Date";

                CustmrLdgrEntry.RESET;
                CustmrLdgrEntry.SETRANGE("Customer No.", "Sell-to Customer No.");
                CustmrLdgrEntry.SETRANGE(Open, TRUE);
                CustmrLdgrEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                IF CustmrLdgrEntry.FINDFIRST THEN
                    InvApplyDate := CustmrLdgrEntry."Document Date";
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
        CusRec: Record Customer;
        ReasonCodeRec: Record "Reason Code";
        NBTAmount: Decimal;
        VATAmount: Decimal;
        HederTxt: Text[100];
        Amt: Decimal;
        SalesInvHedd: Record "Sales Invoice Header";
        AmtIncVat: Decimal;
        SubTot: Decimal;
        UnitPrice: Decimal;
        InvApplyDate: Date;
        SubTot2: Decimal;
        LineAmount: Decimal;
}

