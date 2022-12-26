table 50008 "Monthly Sales Incentive"
{

    fields
    {
        field(1; Year; Integer)
        {
        }
        field(2; Month; Integer)
        {
            MaxValue = 12;
            MinValue = 1;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(5; Sequence; Integer)
        {
        }
        field(6; "Field Type"; Option)
        {
            OptionCaption = 'Row,Column';
            OptionMembers = Row,Column;
        }
        field(7; "Field Name"; Code[30])
        {
        }
        field(8; "Field Caption"; Text[60])
        {
        }
        field(9; Designation; Code[30])
        {
        }
        field(10; Target; Decimal)
        {
        }
        field(11; "Gross Sales"; Decimal)
        {
        }
        field(12; Returns; Decimal)
        {
        }
        field(13; "Net Sales"; Decimal)
        {
        }
        field(14; "Incentive %"; Decimal)
        {
        }
        field(15; "Sales Incentive"; Decimal)
        {
        }
        field(16; "Field Value"; Decimal)
        {
        }
        field(17; "Param 1"; Decimal)
        {
        }
        field(18; "Param 2"; Decimal)
        {
        }
        field(19; "Param 3"; Decimal)
        {
        }
        field(20; "Param 4"; Decimal)
        {
        }
        field(21; "Amount 1"; Decimal)
        {
        }
        field(22; "Amount 2"; Decimal)
        {
        }
        field(23; "Amount 3"; Decimal)
        {
        }
        field(24; "Amount 4"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Year, Month, "Global Dimension 1 Code", "Salesperson Code", "Field Type", "Field Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

