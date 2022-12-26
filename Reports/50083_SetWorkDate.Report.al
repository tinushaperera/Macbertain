report 50083 "Set Work Date"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("User Setup"; "User Setup")
        {

            trigger OnAfterGetRecord()
            begin
                IF "User Setup"."Fix Posting to Current Date" THEN BEGIN
                    "User Setup"."Allow Posting From" := TODAY + 1;
                    "User Setup"."Allow Posting To" := TODAY + 1;
                    MODIFY;
                END;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

