tableextension 50049 PostedApprovalEntry extends "Posted Approval Entry"
{
    fields
    {
        field(50000; "Approval Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Credit Limit","Over Due","Free Issue",Discounts;
            OptionCaption = ' ,Credit Limit,Over Due,Free Issue,Discounts';
        }
    }

    var
        myInt: Integer;
}