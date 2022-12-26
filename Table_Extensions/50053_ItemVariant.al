tableextension 50053 ItemVariant extends "Item Variant"
{
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        key(FK; Description) { }
        key(FK2; "Description 2") { }
    }
    fieldgroups
    {
        addlast(DropDown; Code, Description, "Description 2") { }
    }

    var
        myInt: Integer;
}