page 50069 "Revaluation Jour. Summary"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ShowFilter = false;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            field(Inv_Value_Calc; Inv_Value_Calc)
            {
                ApplicationArea = All;
                Caption = 'Inventory Value (Calculated)';
            }
            field(Inv_Value_Reval; Inv_Value_Reval)
            {
                ApplicationArea = All;
                Caption = 'Inventory Value (Revalued)';
            }
            field(Amt; Amt)
            {
                ApplicationArea = All;
                Caption = 'Value Adjustment';
            }
        }
    }

    actions
    {
    }

    var
        Inv_Value_Calc: Decimal;
        Inv_Value_Reval: Decimal;
        Amt: Decimal;

    procedure GetAmounts(CalcValue: Decimal; RevalValue: Decimal; AdjustAmt: Decimal)
    begin
        Inv_Value_Calc := CalcValue;
        Inv_Value_Reval := RevalValue;
        Amt := AdjustAmt;
    end;
}

