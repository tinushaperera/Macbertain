tableextension 50033 SipToAddress extends "Ship-to Address"
{
    DataCaptionFields = "Customer No.", Name, Code;

    fields
    {
        modify(Code)
        {
            trigger OnAfterValidate()
            var
                ShipAddRec: Record "Ship-to Address";
            begin
                IF xRec.Code <> Code THEN BEGIN
                    ShipAddRec.RESET;
                    ShipAddRec.SETFILTER(ShipAddRec."Customer No.", "Customer No.");
                    ShipAddRec.SETFILTER(ShipAddRec.Code, ' <>%1', Code);
                    IF ShipAddRec.FINDSET THEN
                        Active := FALSE
                    ELSE
                        Active := TRUE;
                END;
            end;
        }
        field(50000; "Route Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Route));
        }
        field(50001; "Route Code 2"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Route));
        }
        field(50002; "Route Code 3"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Route));
        }
        field(50003; "Route Code 4"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reference Data".Code WHERE(Type = CONST(Route));
        }
        field(50004; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Default; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Modified User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Modified Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Created User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Created Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()

    begin
        Cust.GET("Customer No.");
        Name := Cust.Name;
        Cust.TESTFIELD("Tax Area Code");
        "Tax Area Code" := Cust."Tax Area Code";
    end;

    var
        Cust: Record Customer;
}