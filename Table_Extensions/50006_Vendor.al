tableextension 50006 VendorExt extends Vendor
{
    fields
    {
        field(50000; "Account Payee"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
        }
        field(50001; "Business Reg.No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        modify("Payment Terms Code")
        {
            TableRelation = "Payment Terms" WHERE("Vendor Payment Term" = CONST(true));
        }
    }

}