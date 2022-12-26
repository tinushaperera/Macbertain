tableextension 50055 TransferHead extends "Transfer Header"
{
    fields
    {
        field(50000; MRN; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50002; "Created User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Date Time Created"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Date Time Released"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Status New"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Released,"Pending Approval";
            OptionCaption = ' ,Open,Released,Pending Approval';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Status New" = "Status New"::Open THEN
                    TransferEditable := TRUE
                ELSE
                    TransferEditable := FALSE;
            end;
        }
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()

            begin
                //<Chin 20160513 1709
                "Assigned User ID" := USERID;
                //>
            end;
        }
    }
    [Scope('Cloud')]
    procedure GetTransferEditable(): Boolean
    begin
        //<Chin
        EXIT(TransferEditable);
    end;

    local procedure SetTransferEditable(Editable: Boolean)
    begin

        //<Chin
        TransferEditable := Editable;
    end;

    var
        TransferEditable: Boolean;
}