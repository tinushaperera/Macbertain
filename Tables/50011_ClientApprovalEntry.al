table 50011 "Client Approval Entry"
{

    fields
    {
        field(1; "Table No."; Integer)
        {
        }
        field(2; "Table Code"; Code[20])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(4; "No."; Code[20])
        {
        }
        field(5; "Approval Sequence No."; Integer)
        {
            Caption = 'Approval Sequence No.';
        }
        field(6; "Approve Type"; Option)
        {
            OptionCaption = ' ,Credit Limit,OverDue,Sample,Free Issue,Discount,OverDiscount';
            OptionMembers = " ","Credit Limit",OverDue,Sample,"Free Issue",Discount,OverDiscount;
        }
        field(7; "Approve Lower Limit"; Decimal)
        {
        }
        field(8; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            begin
                //UserMgt.LookupUserID("Sender ID");
            end;
        }
        field(9; "Sender Document Type"; Code[20])
        {
        }
        field(10; "Approved ID"; Code[50])
        {
            Caption = 'Approver ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            begin
                //UserMgt.LookupUserID("Approver ID");
            end;
        }
        field(11; "Approved Document Type"; Code[20])
        {
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved,Closed';
            OptionMembers = Created,Open,Canceled,Rejected,Approved,Closed;
        }
        field(13; "Date-Time Sent for Approval"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
        }
        field(14; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
        }
        field(15; "Last Modified By ID"; Code[50])
        {
            Caption = 'Last Modified By ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            begin
                //UserMgt.LookupUserID("Last Modified By ID");
            end;
        }
        field(16; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(18; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(19; "Credit Limit (LCY)"; Decimal)
        {
            Caption = 'Available Credit Limit (LCY)';
        }
        field(20; "Line No."; Integer)
        {
        }
        field(21; "Approver Designation"; Code[20])
        {
        }
        field(22; "Date-Time Approved"; DateTime)
        {
        }
        field(23; "Sender Designation"; Code[20])
        {
        }
        field(24; "Total Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(25; "Due Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(26; "Amount Approval"; Boolean)
        {
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(28; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Text00M: Label 'This customer is black listed.';
            begin
            end;
        }
        field(29; "Sell-to Customer Name"; Text[50])
        {
            Caption = 'Sell-to Customer Name';
        }
        field(30; "Discount Approval"; Boolean)
        {
            Editable = false;
        }
        field(31; "Free Issue Approval"; Boolean)
        {
            Editable = false;
        }
        field(32; "Salesperson Code"; Code[20])
        {
            Editable = false;
        }
        field(33; "Overdue No Cheques"; Boolean)
        {
        }
        field(34; "Approve Upper Limit"; Decimal)
        {
        }
        field(35; "Approval Method"; Option)
        {
            OptionCaption = 'All,Either';
            OptionMembers = All,Either;
        }
        field(36; "Sequence Line No."; Integer)
        {
        }
        field(37; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(38; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Table No.", "Table Code", Type, "No.", "Approval Sequence No.", "Approve Type", "Approve Lower Limit", "Sequence Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        UserSetupRec: Record "User Setup";
    begin
        //<Chin 20160520
        //UserSetupRec.GET(USERID);
        //UserSetupRec.TESTFIELD("Salespers./Purch. Code");
        //"Salesperson Code" := UserSetupRec."Salespers./Purch. Code" ;
        //>
    end;

    var
        UserMgt: Codeunit "User Management";

    [Scope('Cloud')]
    procedure ShowDocument()
    var
        SalesHeader: Record "Sales Header";
    begin
        CASE "Table No." OF
            DATABASE::"Sales Header":
                BEGIN
                    IF NOT SalesHeader.GET(Type, "No.") THEN
                        EXIT;
                    CASE Type OF
                        Type::Quote:
                            PAGE.RUNMODAL(PAGE::"Sales Quote", SalesHeader);
                        Type::Order:
                            IF "Approve Type" = "Approve Type"::Sample THEN  //GJ
                                PAGE.RUNMODAL(PAGE::"Sample Sales Order", SalesHeader)
                            ELSE
                                PAGE.RUNMODAL(PAGE::"Sales Order", SalesHeader);
                        Type::Invoice:
                            PAGE.RUNMODAL(PAGE::"Sales Invoice", SalesHeader);
                        Type::"Credit Memo":
                            PAGE.RUNMODAL(PAGE::"Sales Credit Memo", SalesHeader);
                        Type::"Blanket Order":
                            PAGE.RUNMODAL(PAGE::"Blanket Sales Order", SalesHeader);
                        Type::"Return Order":
                            PAGE.RUNMODAL(PAGE::"Sales Return Order", SalesHeader);
                    END;
                END;
        END;
    end;

    local procedure SetSequenceLineNo(Rec: Record "Client Approval User Setup")
    begin
    end;

    [Scope('Cloud')]
    procedure GetLastEntryNo(): Integer
    var
        ClientAppEntry: Record "Client Approval Entry";
    begin
        ClientAppEntry.RESET;
        IF ClientAppEntry.FINDLAST THEN
            EXIT(ClientAppEntry."Entry No.");
        EXIT(0);
    end;
}

