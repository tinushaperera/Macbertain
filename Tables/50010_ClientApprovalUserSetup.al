table 50010 "Client Approval User Setup"
{

    fields
    {
        field(1; "Table No."; Integer)
        {
            Caption = 'Linked To Table No.';
            // TableRelation = Object.ID WHERE(Type = CONST(Table));

            // trigger OnValidate()
            // var
            //     Objects: Record "2000000001";
            // begin
            //     Objects.SETRANGE(Type, Objects.Type::Table);
            //     Objects.SETRANGE(ID, "Table No.");
            //     IF Objects.FINDFIRST THEN
            //         "Table Name" := Objects.Name
            //     ELSE
            //         "Table Name" := '';
            // end;
        }
        field(2; "Table Name"; Text[50])
        {
            Caption = 'Linked To Table Name';
            Editable = false;
        }
        field(3; "Table Code"; Code[20])
        {
            TableRelation = "Reference Data".Code WHERE(Type = CONST("Table Code"));

            trigger OnValidate()
            begin
                //ActivateRec;
            end;
        }
        field(4; "Approval Sequence No."; Integer)
        {

            trigger OnValidate()
            begin
                "Approval Sequence No." := ABS("Approval Sequence No.");
                SetSequenceLineNo;
            end;
        }
        field(5; "Approve Type"; Option)
        {
            OptionCaption = ' ,Credit Limit,OverDue,Sample,Free Issue,Discount,OverDiscount';
            OptionMembers = " ","Credit Limit",OverDue,Sample,"Free Issue",Discount,OverDiscount;

            trigger OnValidate()
            begin
                SetSequenceLineNo;
            end;
        }
        field(6; "Approve Lower Limit"; Decimal)
        {

            trigger OnValidate()
            begin
                SetSequenceLineNo;
            end;
        }
        field(7; "Approve Upper Limit"; Decimal)
        {
        }
        field(8; "Approve User ID"; Code[50])
        {
            Caption = 'Approve User ID';
            NotBlank = true;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.LookupUserID("Approve User ID");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.ValidateUserID("Approve User ID");
                // ActivateRec;
            end;
        }
        field(9; "Approval Method"; Option)
        {
            OptionCaption = 'All,Either';
            OptionMembers = All,Either;

            trigger OnValidate()
            begin
                IF "Approval Method" <> xRec."Approval Method" THEN BEGIN
                    MODIFY;
                    COMMIT;
                    SetApprovalMethod;
                END
            end;
        }
        field(10; "Sequence Line No."; Integer)
        {
            Editable = false;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(13; "Send Request Mail"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Table No.", "Table Code", "Approve Type", "Approval Sequence No.", "Approve Lower Limit", "Sequence Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        ClientApp: Record "Client Approval User Setup";
    begin
    end;

    local procedure SetSequenceLineNo()
    var
        ClientApp: Record "Client Approval User Setup";
    begin
        ClientApp.SETFILTER("Table No.", '%1', "Table No.");
        ClientApp.SETFILTER("Table Code", "Table Code");
        ClientApp.SETFILTER("Approve Type", '%1', "Approve Type");
        ClientApp.SETFILTER("Approval Sequence No.", '%1', "Approval Sequence No.");
        ClientApp.SETFILTER("Approve Lower Limit", '%1', "Approve Lower Limit");
        IF ClientApp.FINDLAST THEN
            "Sequence Line No." := ClientApp."Sequence Line No." + 1
        ELSE
            "Sequence Line No." := 1;
    end;

    local procedure SetApprovalMethod()
    var
        ClientApp: Record "Client Approval User Setup";
    begin

        ClientApp.SETFILTER("Table No.", '%1', "Table No.");
        ClientApp.SETFILTER("Table Code", "Table Code");
        ClientApp.SETFILTER("Approve Type", '%1', "Approve Type");
        ClientApp.SETFILTER("Approval Sequence No.", '%1', "Approval Sequence No.");
        ClientApp.SETFILTER("Approve Lower Limit", '%1', "Approve Lower Limit");
        IF ClientApp.FINDSET THEN
            REPEAT
                IF ClientApp."Approval Method" <> "Approval Method" THEN BEGIN
                    ClientApp."Approval Method" := "Approval Method";
                    ClientApp.MODIFY;
                END;
            UNTIL ClientApp.NEXT = 0;
    end;
}

