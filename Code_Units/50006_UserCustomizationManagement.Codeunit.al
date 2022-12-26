codeunit 50006 "User Customization Management"
{

    trigger OnRun()
    begin
    end;


    procedure CheckSalesHedBeforePost(SalesHed: Record "Sales Header")
    begin
        IF SalesHed."Sell-to Customer No." <> SalesHed."Bill-to Customer No." THEN
            ERROR('Sell to customer and Bill to customer must be same.');
    end;


    procedure CheckPurchHedBeforePost(PurchHed: Record "Purchase Header")
    begin
        IF PurchHed."Buy-from Vendor No." <> PurchHed."Pay-to Vendor No." THEN
            ERROR('Buy from vendor and Pay to vendor must be same.');
    end;
}

