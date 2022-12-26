tableextension 50019 GenJrnlTemplate extends "Gen. Journal Template"
{
    fields
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //RJ(+)
                SourceCodeSetup.Get;
                if Type = Type::"PD Cheque" then BEGIN
                    "Source Code" := SourceCodeSetup."PD-Cheque Receipt Journal";
                    "Page ID" := PAGE::"PD-Cheque Receipt Journal";
                END;
                //RJ(-)
            end;
        }
    }

    var
        SourceCodeSetup: Record "Source Code Setup";
}