report 50153 "Change Pmt Method -Reserved"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE(Blocked = FILTER(' '));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin

                VALIDATE(Customer."Payment Method Code", PayMethod);
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                IF CONFIRM('Do you want to proceed', FALSE) = FALSE THEN
                    ERROR('');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Payment Method"; PayMethod)
                {
                    Caption = 'Payment Method Code';
                    TableRelation = "Payment Method";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesPerson: Code[20];
        PayMethod: Code[20];
}

