pageextension 50180 CheckCredLimitExt extends "Check Credit Limit"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    procedure CalcCreditLimitLCYModify(VAR CreditAmtLCY: Decimal; VAR CreditLimitLCY: Decimal; VAR BalanceDueLCY: Decimal; FilterDate: Date)
    var
    begin
        //    IF rec.GETFILTER("Date Filter") = '' THEN
        //        rec.SETFILTER("Date Filter", '..%1', WORKDATE);
        //    rec.CALCFIELDS("Balance (LCY)", "Shipped Not Invoiced (LCY)", "Serv Shipped Not Invoiced(LCY)");
        //    CalcReturnAmounts(OutstandingRetOrdersLCY, RcdNotInvdRetOrdersLCY);

        //    OrderAmountTotalLCY := CalcTotalOutstandingAmt - OutstandingRetOrdersLCY - CalcInvoicedPrepmtAmountLCY;
        //    ShippedRetRcdNotIndLCY := "Shipped Not Invoiced (LCY)" + "Serv Shipped Not Invoiced(LCY)" - RcdNotInvdRetOrdersLCY;
        //    IF rec."No." = CustNo THEN
        //        OrderAmountThisOrderLCY := NewOrderAmountLCY
        //    ELSE
        //        OrderAmountThisOrderLCY := 0;

        //    CustCreditAmountLCY :=
        //      rec."Balance (LCY)" + rec."Shipped Not Invoiced (LCY)" + rec."Serv Shipped Not Invoiced(LCY)" - RcdNotInvdRetOrdersLCY +
        //      OrderAmountTotalLCY + DeltaAmount;
        //    CalcOverdueBalanceLCY;
        //    CreditAmtLCY := CustCreditAmountLCY;
        //    CreditLimitLCY := rec."Credit Limit (LCY)";
        //    BalanceDueLCY := rec."Balance Due (LCY)";
    end;

    var
        NewOrderAmountLCY: Decimal;
        OldOrderAmountLCY: Decimal;
        OrderAmountThisOrderLCY: Decimal;
        OrderAmountTotalLCY: Decimal;
        CustCreditAmountLCY: Decimal;
        ShippedRetRcdNotIndLCY: Decimal;
        OutstandingRetOrdersLCY: Decimal;
        RcdNotInvdRetOrdersLCY: Decimal;
        CustNo: Code[20];


}