tableextension 50064 SalesCue extends "Sales Cue"
{
    fields
    {
        field(50000; "Pending Customer Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE(Blocked = filter('Pending Approval')));
        }
        field(50001; "Pending Sales Order Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order), Status = CONST("Pending Approval")));
        }
        field(50002; "Pending Credit Limit Approvals"; Integer)
        {
            CalcFormula = Count("Client Approval Entry" WHERE(Status = CONST(Open), "Approve Type" = CONST("Credit Limit")));
            FieldClass = FlowField;
        }
        field(50003; "Pending Overdue Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Client Approval Entry" WHERE(Status = CONST(Open), "Approve Type" = CONST(OverDue)));
        }
        field(50004; "Pending Free Issue Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Client Approval Entry" WHERE(Status = CONST(Open), "Approve Type" = CONST("Free Issue")));
        }
        field(50005; "Pending Discounts Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Client Approval Entry" WHERE(Status = CONST(Open), "Approve Type" = CONST(Discount)));
        }
        field(50006; "Pending Sample Order Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order), Status = CONST("Pending Approval"), "Order Type" = CONST(Sample)));
        }
        field(50007; "Posted Sales Invoices-All"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Invoice Header" WHERE("Order No." = FILTER(<> '')));
        }
        field(50008; "Posted Sales Invoices-Today"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Invoice Header" WHERE("Order No." = FILTER(<> ''), "Posting Date" = FIELD("Date Filter2"), "Responsibility Center" = FIELD("Responsibility Center Filter")));
        }
        field(50009; "Pending Deliveries-Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Amount Including VAT" WHERE("Document Type" = FILTER(Order), "Qty. to Ship" = FILTER(> 0)));
        }
        field(50012; "Approved-Sales Orders Today"; Integer)
        {

            // FieldClass = FlowField;
            // CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order), Status = FILTER(Released), "Date-Time Released" = FIELD("Date Filter2")));
        }
        field(50013; "Not Fully Shipped"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order), Status = FILTER(Released), Shipped = FILTER(true), "Completely Shipped" = FILTER(false), "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Editable = false;
        }
    }

    var
        myInt: Integer;
}