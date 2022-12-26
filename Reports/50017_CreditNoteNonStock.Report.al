report 50017 "Credit Note – Non Stock"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/CreditNoteNonStock.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
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
            column(CusNo; "Sales Header"."Sell-to Customer No.")
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
            column(CredNo; "Sales Header"."No.")
            {
            }
            column(Date; "Sales Header"."Posting Date")
            {
            }
            column(ExtNo; "Sales Header"."External Document No.")
            {
            }
            column(Amt1; Amt)
            {
            }
            column(HederTxt; HederTxt)
            {
            }
            column(AppInv; "Sales Header"."Applies-to Doc. No.")
            {
            }
            column(InvNo; SalesInvHedd."No.")
            {
            }
            column(PostDate; SalesInvHedd."Posting Date")
            {
            }
            column(Rem; "Sales Header".Remarks)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = FIELD("No.");
                column(Type_SalesLine; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(iNVDocNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(InvDate; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(AmtApp; "Cust. Ledger Entry"."Amount to Apply")
                {
                }
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Amount = FILTER(<> 0));
                column(NBTAmount; NBTAmount)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(AmtIncVAT; SubTot)
                {
                }

                trigger OnAfterGetRecord()
                var
                    CalCompTax: Codeunit "Calculate Tax Of Company";
                begin
                    NBTAmount := 0;
                    VATAmount := 0;

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
                    Amt := ("Amount Including VAT" * ComRec."SVAT Pecerntage(%)") / 100;
                END;
                IF "Tax Area Code" = 'NON-TAX' THEN BEGIN
                    HederTxt := ''
                END;

                IF ReasonCodeRec.GET("Reason Code") THEN;
                IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN
                    SalesInvHedd.GET("Applies-to Doc. No.");
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
        SubTot: Decimal;
        UnitPrice: Decimal;
        AmtIncVat: Decimal;
}

