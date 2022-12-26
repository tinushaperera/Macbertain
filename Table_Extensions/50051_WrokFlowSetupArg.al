tableextension 50051 WrokFlowSetupArg extends "Workflow Step Argument"
{
    fields
    {
        field(50000; "Customer Approval Option"; Code[128])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}