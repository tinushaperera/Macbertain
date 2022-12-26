codeunit 51000 "My Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    local procedure CustApprovedResponseCode(): Code[128]
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    // local procedure AddCustApprovedRespToLibrary(WorkflowResponseHandling: Codeunit "Workflow Response Handling")
    // begin
    //     WorkflowResponseHandling.AddResponseToLibrary(CustApprovedResponseCode, DATABASE::Customer, 'Set Approval Date', 'GROUP 50000')
    // end;

    local procedure CustApprovedResponse(Customer: Record Customer; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        IF WorkflowStepArgument.GET(WorkflowStepInstance.Argument) THEN;
        IF Customer."Approved Date" = 0D THEN
            Customer."Approved Date" := TODAY;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]
    local procedure ExcuteCustApprovedResponses(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            CASE WorkflowResponse."Function Name" OF
                'MyWFResponseCode':
                    BEGIN
                        CustApprovedResponse(Variant, ResponseWorkflowStepInstance);
                        ResponseExecuted := TRUE;
                    END;
            END;
    end;
}

