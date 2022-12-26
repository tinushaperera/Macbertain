tableextension 50046 ExcelBuffer extends "Excel Buffer"
{
    fields
    {

    }

    [Scope('Cloud')]
    procedure EditColumn(Value: Variant; IsFormula: Boolean; CommentText: Text[1000]; IsBold: Boolean; IsItalics: Boolean; IsUnderline: Boolean; NumFormat: Text[30]; CellType: Option)
    var
        XlBf: Record "Excel Buffer";
    begin
        //Chin
        IF CurrentRow < 1 THEN
            NewRow;

        XlBf.RESET;
        XlBf.SETFILTER("Row No.", '%1', CurrentRow);
        XlBf.SETFILTER("Column No.", '%1', CurrentCol);

        IF XlBf.FINDFIRST THEN BEGIN
            IF IsFormula THEN
                XlBf.SetFormula(FORMAT(Value))
            ELSE
                XlBf."Cell Value as Text" := FORMAT(Value);
            XlBf.Comment := CommentText;
            XlBf.Bold := IsBold;
            XlBf.Italic := IsItalics;
            XlBf.Underline := IsUnderline;
            XlBf.NumberFormat := NumFormat;
            XlBf."Cell Type" := CellType;
            XlBf.MODIFY;
        END
        ELSE BEGIN
            XlBf.INIT;
            XlBf.VALIDATE("Row No.", CurrentRow);
            XlBf.VALIDATE("Column No.", CurrentCol);
            IF IsFormula THEN
                XlBf.SetFormula(FORMAT(Value))
            ELSE
                XlBf."Cell Value as Text" := FORMAT(Value);
            XlBf.Comment := CommentText;
            XlBf.Bold := IsBold;
            XlBf.Italic := IsItalics;
            XlBf.Underline := IsUnderline;
            XlBf.NumberFormat := NumFormat;
            XlBf."Cell Type" := CellType;
            XlBf.INSERT;
        END;
    end;

    var
        CurrentCol: Integer;
        CurrentRow: Integer;
}