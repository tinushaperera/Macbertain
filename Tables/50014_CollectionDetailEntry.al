table 50014 "Collection Details Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';

            trigger OnLookup()
            var
                IncomingDocument: Record "Incoming Document";
            begin
            end;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
            FieldClass = Normal;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = Normal;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Amt. (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amt. (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(18; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales (LCY)';
        }
        field(19; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = ',Initial Entry,Application,Unrealized Loss,Unrealized Gain,Realized Loss,Realized Gain,Payment Discount,Payment Discount (VAT Excl.),Payment Discount (VAT Adjustment),Appln. Rounding,Correction of Remaining Amount,Payment Tolerance,Payment Discount Tolerance,Payment Tolerance (VAT Excl.),Payment Tolerance (VAT Adjustment),Payment Discount Tolerance (VAT Excl.),Payment Discount Tolerance (VAT Adjustment)';
            OptionMembers = ,"Initial Entry",Application,"Unrealized Loss","Unrealized Gain","Realized Loss","Realized Gain","Payment Discount","Payment Discount (VAT Excl.)","Payment Discount (VAT Adjustment)","Appln. Rounding","Correction of Remaining Amount","Payment Tolerance","Payment Discount Tolerance","Payment Tolerance (VAT Excl.)","Payment Tolerance (VAT Adjustment)","Payment Discount Tolerance (VAT Excl.)","Payment Discount Tolerance (VAT Adjustment)";
        }
        field(20; "Payment Cust. Led. Entry No."; Integer)
        {
        }
        field(21; "Payment Amount"; Decimal)
        {
        }
        field(22; "Payment Det. Led. Enrty No."; Integer)
        {
        }
        field(23; Year; Integer)
        {
        }
        field(24; Month; Integer)
        {
            MaxValue = 12;
            MinValue = 1;
        }
        field(25; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(26; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(27; "Line No"; Integer)
        {
        }
        field(28; Amt1; Decimal)
        {
        }
        field(29; Amt2; Decimal)
        {
        }
        field(30; Amt3; Decimal)
        {
        }
        field(31; Amt4; Decimal)
        {
        }
        field(32; CollectAmt; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Payment Det. Led. Enrty No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

