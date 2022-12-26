report 50003 "GRN "
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/GRN.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
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
            column(GRN_No; "Purch. Rcpt. Header"."No.")
            {
            }
            column(PO_No; "Purch. Rcpt. Header"."Order No.")
            {
            }
            column(Date; "Purch. Rcpt. Header"."Posting Date")
            {
            }
            column(VendName; "Purch. Rcpt. Header"."Buy-from Vendor Name")
            {
            }
            column(VendAdd; VendRec.Address)
            {
            }
            column(VendAdd2; VendRec."Address 2")
            {
            }
            column(Caption; Caption)
            {
            }
            column(Loc; "Purch. Rcpt. Header"."Location Code")
            {
            }
            column(DONo; "Purch. Rcpt. Header"."Your Reference")
            {
            }
            column(DimName; DimRec.Name)
            {
            }
            column(Ope; DimRec1.Name)
            {
            }
            column(GRNInvoiceNo; "Purch. Rcpt. Header"."GRN Invoice No.")
            {
            }
            column(InvNo; InvNo)
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItmNo; "Purch. Rcpt. Line"."No.")
                {
                }
                column(Description; "Purch. Rcpt. Line".Description)
                {
                }
                column(UOMCode; "Purch. Rcpt. Line"."Unit of Measure Code")
                {
                }
                column(Qty; "Purch. Rcpt. Line".Quantity)
                {
                }
                column(Location; LocRec.Name)
                {
                }
                column(Rem; "Purch. Rcpt. Line".Remarks)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF LocRec.GET("Location Code") THEN;
                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchInvHedd: Record "Purch. Inv. Header";
            begin
                InvNo := '';
                IF VendRec.GET("Buy-from Vendor No.") THEN;
                DimRec.RESET;
                DimRec.SETRANGE(Code, "Shortcut Dimension 1 Code");
                IF DimRec.FINDFIRST THEN
                    DimRec1.RESET;
                DimRec1.SETRANGE(Code, "Shortcut Dimension 2 Code");
                IF DimRec1.FINDFIRST THEN
                    PurchInvHedd.RESET;
                PurchInvHedd.SETRANGE("Order No.", "Order No.");
                IF PurchInvHedd.FINDFIRST THEN
                    InvNo := PurchInvHedd."Vendor Invoice No.";
            end;

            trigger OnPreDataItem()
            begin
                ComInfo.GET;
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

    trigger OnPreReport()
    begin
        Caption := 'GOODS RECEIVED NOTE';
    end;

    var
        ComInfo: Record "Company Information";
        VendRec: Record Vendor;
        Caption: Text[20];
        DimRec: Record "Dimension Value";
        LocRec: Record Location;
        DimRec1: Record "Dimension Value";
        InvNo: Code[35];
}

