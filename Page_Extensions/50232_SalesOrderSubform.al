pageextension 50232 SalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        addafter("Description 2")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Available Inventory"; Rec."Available Inventory")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Free Issue Quantity"; Rec."Free Issue Quantity")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("Gross Price"; Rec."Gross Price")
            {
                ApplicationArea = All;
                Editable = false;
                Style = Ambiguous;
                StyleExpr = TRUE;
            }
        }
        addafter("Line Discount %")
        {
            field("Gross Line Discount Amount"; Rec."Gross Line Discount Amount")
            {
                ApplicationArea = All;
                Editable = DisCountEdit;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Discounted Gross Price"; Rec."Discounted Gross Price")
            {
                ApplicationArea = All;
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Description 2")
        {
            Visible = false;
        }
        modify(Quantity)
        {
            Editable = QtyEdit;

            trigger OnAfterValidate()
            begin
                QuantityOnAfterValidate;
                //NS
                //IsServiceItem;
                //CurrPage.UPDATE;
                //<Chin 201602111530
                Rec.CreateNewLine;
                CurrPage.UPDATE;
                //>
            end;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Unit Price")
        {
            Editable = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Editable = DisCountEdit;
        }
        modify("Quantity Shipped")
        {
            Visible = false;
        }


    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        User1: Record User;
    begin
        User1.RESET;
        User1.SETRANGE("User Name", USERID);
        User1.FINDFIRST;
        SaleRecSetup.GET;
        SaleRecSetup.TESTFIELD("Free Issue Code");
    end;

    var
        DisCountEdit: Boolean;
        QtyEdit: Boolean;
        FreeIssueEdit: Boolean;
        User: Record "User Setup";
        SaleRecSetup: Record "Sales & Receivables Setup";


    [Scope('Cloud')]
    procedure Ed_Fields()
    begin
        SaleRecSetup.Get();
        IF Rec."Purchasing Code" = SaleRecSetup."Free Issue Code" THEN
            FreeIssueEdit := FALSE
        ELSE
            FreeIssueEdit := FALSE; //< Chin 20160621 11:08 FreeIssueEdit := TRUE;

        IF NOT User."Sales Order Editable" THEN BEGIN
            DisCountEdit := FALSE;
            IF Rec."Purchasing Code" = SaleRecSetup."Free Issue Code" THEN
                QtyEdit := FALSE
            ELSE
                QtyEdit := TRUE;
        END
        ELSE BEGIN
            DisCountEdit := TRUE;
            QtyEdit := TRUE;
        END
    end;

    trigger OnAfterGetRecord()

    begin
        Ed_Fields();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Ed_Fields();
    end;
}