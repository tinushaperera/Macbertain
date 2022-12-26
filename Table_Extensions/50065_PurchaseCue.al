tableextension 50065 PurchaseCue extends "Purchase Cue"
{
    fields
    {
        field(50000; "Delayed PO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order), Status = CONST("Pending Approval"), "Order Date" = FIELD("Date Filter2")));
        }
        field(50001; "Date Filter2"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
            Editable = false;
        }
        field(50002; "Pending Approval"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order), Status = CONST("Pending Approval")));
        }
    }

    var
        myInt: Integer;
}