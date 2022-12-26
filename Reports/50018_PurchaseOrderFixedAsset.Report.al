report 50018 "Purchase Order – Fixed Asset"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Report_Layouts/PurchaseOrderFixedAsset.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.";
            column(ComName; ComInfo.Name)
            {
            }
            column(ComAdd; ComInfo.Address)
            {
            }
            column(ComAdd2; ComInfo."Address 2")
            {
            }
            column(ComCity; ComInfo.City)
            {
            }
            column(ComPH; ComInfo."Phone No.")
            {
            }
            column(ComFax; ComInfo."Fax No.")
            {
            }
            column(ComPic; ComInfo.Picture)
            {
            }
            column(ComEmail; ComInfo."E-Mail")
            {
            }
            column(ComVatReg; ComInfo."VAT Registration No.")
            {
            }
            column(PoNo; "Purchase Header"."No.")
            {
            }
            column(VendNo; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(PaymentTerms; PamntTems.Description)
            {
            }
            column(DueDate; "Purchase Header"."Due Date")
            {
            }
            column(PostDate; "Purchase Header"."Posting Date")
            {
            }
            column(ShipName; "Purchase Header"."Ship-to Name")
            {
            }
            column(ShipAdd; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShipAdd2; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(VendPH; VendRec."Phone No.")
            {
            }
            column(VendFax; VendRec."Fax No.")
            {
            }
            column(VendEmail; VendRec."E-Mail")
            {
            }
            column(VendName; VendRec.Name)
            {
            }
            column(VendVatReg; VendRec."VAT Registration No.")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(Caption; Caption)
            {
            }
            column(Loc; "Purchase Header"."Location Code")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE(Type = CONST("Fixed Asset"));
                column(ItemNo; "Purchase Line"."No.")
                {
                }
                column(ItemDescription; "Purchase Line".Description)
                {
                }
                column(UOM; "Purchase Line"."Unit of Measure Code")
                {
                }
                column(Qty; "Purchase Line".Quantity)
                {
                }
                column(UnitCostLCY; "Purchase Line"."Unit Cost (LCY)")
                {
                }
                column(AmtIncVAT; "Purchase Line"."Amount Including VAT")
                {
                }
                column(SNo; SNo)
                {
                }
                column(NBTAmount; NBTAmount)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(Amt; "Purchase Line".Amount)
                {
                }

                trigger OnAfterGetRecord()
                var
                    CalCompTax: Codeunit "Calculate Tax Of Company";
                begin
                    SNo := SNo + 1;
                    NBTAmount := 0;
                    VATAmount := 0;

                    IF "Tax Liable" THEN
                        CalCompTax.CalTaxOnTax("Tax Group Code", "Tax Area Code", Amount,
                          NBTAmount, VATAmount);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ComInfo.CALCFIELDS(Picture);
                VendRec.GET("Buy-from Vendor No.");

                IF "Currency Code" <> '' THEN
                    CurrCode := "Currency Code"
                ELSE
                    CurrCode := 'LKR';

                IF PamntTems.GET("Payment Terms Code") THEN;
            end;

            trigger OnPreDataItem()
            begin
                ComInfo.GET;
                Caption := 'PURCHASE ORDER (Fixed Assets)';
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
        ComInfo: Record "Company Information";
        VendRec: Record Vendor;
        PurchLineRec: Record "Purchase Line";
        PamntTems: Record "Payment Terms";
        Caption: Text[30];
        SNo: Integer;
        CurrCode: Code[10];
        NBTAmount: Decimal;
        VATAmount: Decimal;
}

