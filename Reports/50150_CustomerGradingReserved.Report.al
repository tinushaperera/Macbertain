report 50150 "Customer Grading-Reserved"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE(Blocked = FILTER(<> All),
                                      "Customer Registered Date" = FILTER(<> ''));
            RequestFilterFields = "No.", "Global Dimension 1 Code", "Global Dimension 2 Code";

            trigger OnAfterGetRecord()
            var
                RefndCustLedEnty: Record "Cust. Ledger Entry";
                CusRec: Record Customer;
                TotSalesLCY: Decimal;
                CalDate: Decimal;
                AvgSalsTurnOver: Decimal;
                OverDueDates: Decimal;
                FirstRasioAmt: Decimal;
                SecondRasioAmt: Decimal;
                TotOverDueDates: Decimal;
                RefundAmt: Decimal;
                Over90D: Decimal;
            begin
                CalDate := 0;
                AvgSalsTurnOver := 0;
                OverDueDates := 0;
                TotOverDueDates := 0;
                FirstRasioAmt := 0;
                RefundAmt := 0;
                SecondRasioAmt := 0;
                CusRec.GET("No.");
                //REPEAT
                CustLedEnty.RESET;
                CustLedEnty.SETRANGE("Customer No.", "No.");
                CustLedEnty.SETRANGE("Document Type", CustLedEnty."Document Type"::Invoice);
                CustLedEnty.SETFILTER("Posting Date", '>=%1', "Customer Registered Date");
                CustLedEnty.CALCSUMS("Sales (LCY)");
                TotSalesLCY := CustLedEnty."Sales (LCY)";

                CalDate := (AsAtDate - "Customer Registered Date") / 31;

                IF CalDate <> 0 THEN
                    AvgSalsTurnOver := ROUND(TotSalesLCY / CalDate);
                IF AvgSalsTurnOver < 250000 THEN
                    CurrReport.SKIP;
                IF CustLedEnty.FINDSET THEN
                    REPEAT
                        OverDueDates := (AsAtDate - CustLedEnty."Posting Date");
                        //TotOverDueDates := TotOverDueDates + OverDueDates;
                        IF OverDueDates > 90 THEN
                            Over90D := CustLedEnty."Sales (LCY)";
                    UNTIL CustLedEnty.NEXT = 0;
                IF AvgSalsTurnOver <> 0 THEN
                    FirstRasioAmt := (Over90D / TotSalesLCY) * 100;

                RefndCustLedEnty.RESET;
                RefndCustLedEnty.SETRANGE("Customer No.", "No.");
                RefndCustLedEnty.SETRANGE("Document Type", RefndCustLedEnty."Document Type"::Refund);
                RefndCustLedEnty.SETFILTER("Posting Date", '>=%1', "Customer Registered Date");
                IF RefndCustLedEnty.FINDSET THEN
                    REPEAT
                        RefndCustLedEnty.CALCFIELDS("Amount (LCY)");
                        RefundAmt := RefundAmt + RefndCustLedEnty."Amount (LCY)";
                    UNTIL RefndCustLedEnty.NEXT = 0;

                IF AvgSalsTurnOver <> 0 THEN
                    SecondRasioAmt := (RefundAmt / TotSalesLCY) * 100;
                IF (TotOverDueDates < 90) AND (SecondRasioAmt <= 2.5) THEN
                    "Customer Grade" := Customer."Customer Grade"::A1;
                MODIFY;
                IF (FirstRasioAmt < 5) AND (SecondRasioAmt > 2.5) AND (SecondRasioAmt <= 5) THEN
                    "Customer Grade" := Customer."Customer Grade"::A2;
                MODIFY;
                IF (FirstRasioAmt > 5) AND (FirstRasioAmt < 10) AND (SecondRasioAmt > 5) AND (SecondRasioAmt <= 7.5) THEN
                    "Customer Grade" := Customer."Customer Grade"::A3;
                MODIFY;
                IF (FirstRasioAmt > 10) AND (FirstRasioAmt < 15) AND (SecondRasioAmt > 7.5) AND (SecondRasioAmt <= 10) THEN
                    "Customer Grade" := Customer."Customer Grade"::A4;
                MODIFY;
                IF (FirstRasioAmt > 15) AND (FirstRasioAmt < 20) THEN
                    "Customer Grade" := Customer."Customer Grade"::A5;
                MODIFY;
                //MESSAGE('%1 / %2 / %3 / %4 / %5 / %6',TotSalesLCY,AvgSalsTurnOver,TotOverDueDates,FirstRasioAmt,SecondRasioAmt,"Customer Grade");
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Process Completed');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field("As At Date"; AsAtDate)
                    {
                        Editable = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            AsAtDate := TODAY;
        end;
    }

    labels
    {
    }

    var
        CustLedEnty: Record "Cust. Ledger Entry";
        AsAtDate: Date;
}

