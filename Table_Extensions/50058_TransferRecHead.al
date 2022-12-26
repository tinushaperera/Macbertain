tableextension 50058 TransferRecHead extends "Transfer Receipt Header"
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
        }  // Add changes to table fields here
        field(50005; "Status New"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Open,Released,"Pending Approval";
            OptionCaption = ' ,Open,Released,Pending Approval';
        }
    }

    var
        myInt: Integer;
}