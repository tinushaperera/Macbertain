page 50099 "Excel Reports"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Excel Reports';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Web Service 1";
    SourceTableView = WHERE("Excel Name" = filter(<> ''));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Excel Name"; rec."Excel Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Excel Report")
            {
                ApplicationArea = All;
                Caption = 'Preview Report';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin
                    //E:\TEST\OData Reports\Sales_Order_Info.xlsx

                    // RunExcelReport("Excel Name");
                end;
            }
        }
    }

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    //     "Object": Record "2000000001";
    // begin
    //     TESTFIELD("Object ID");
    //     TESTFIELD("Service Name");
    //     IF NOT ("Object Type" IN ["Object Type"::Codeunit, "Object Type"::Page, "Object Type"::Query]) THEN
    //         FIELDERROR("Object Type");
    //     IF ("Object Type" = "Object Type"::Page) AND ("Object ID" = PAGE::"Web Services") THEN
    //         FIELDERROR("Object ID");
    //     Object.GET("Object Type", '', "Object ID");
    // end;

    // trigger OnModifyRecord(): Boolean
    // var
    //     "Object": Record "2000000001";
    // begin
    //     TESTFIELD("Object ID");
    //     TESTFIELD("Service Name");
    //     IF NOT ("Object Type" IN ["Object Type"::Codeunit, "Object Type"::Page, "Object Type"::Query]) THEN
    //         FIELDERROR("Object Type");
    //     IF ("Object Type" = "Object Type"::Page) AND ("Object ID" = PAGE::"Web Services") THEN
    //         FIELDERROR("Object ID");
    //     Object.GET("Object Type", '', "Object ID");
    // end;

    // var
    //     NotApplicableTxt: Label 'Not applicable';

    // [Scope('Internal')]
    // procedure GetObjectCaption(): Text[80]
    // var
    //     AllObjWithCaption: Record "2000000058";
    // begin
    //     IF AllObjWithCaption.GET("Object Type", "Object ID") THEN
    //         EXIT(AllObjWithCaption."Object Caption");
    //     EXIT('');
    // end;

    // local procedure GetODataUrl(): Text
    // begin
    //     IF NOT Published THEN
    //         EXIT('');

    //     CASE "Object Type" OF
    //         "Object Type"::Page:
    //             EXIT(GETURL(CLIENTTYPE::OData, COMPANYNAME, OBJECTTYPE::Page, "Object ID"));
    //         "Object Type"::Query:
    //             EXIT(GETURL(CLIENTTYPE::OData, COMPANYNAME, OBJECTTYPE::Query, "Object ID"));
    //         ELSE
    //             EXIT(NotApplicableTxt);
    //     END;
    // end;

    // local procedure GetSOAPUrl(): Text
    // begin
    //     IF NOT Published THEN
    //         EXIT('');

    //     CASE "Object Type" OF
    //         "Object Type"::Page:
    //             EXIT(GETURL(CLIENTTYPE::SOAP, COMPANYNAME, OBJECTTYPE::Page, "Object ID"));
    //         "Object Type"::Codeunit:
    //             EXIT(GETURL(CLIENTTYPE::SOAP, COMPANYNAME, OBJECTTYPE::Codeunit, "Object ID"));
    //         ELSE
    //             EXIT(NotApplicableTxt);
    //     END;
    // end;

    // [Scope('Internal')]
    // procedure RunExcelReport(ExcelFileName: Text[60])
    // var
    //     ExcelSetupPage: Page "50098";
    //     UserSetupRec: Record "91";
    //     FilePath: Text[200];
    // begin
    //     CLEAR(ExcelSetupPage);
    //     CASE ExcelFileName OF
    //         'Sales_Order_Info.xlsx':
    //             BEGIN
    //                 ExcelSetupPage.DateCaption('Order Date Start');
    //                 ExcelSetupPage.Date2Caption('Order Date End');
    //                 ExcelSetupPage.RUNMODAL;
    //             END;
    //         'Q50001_Bank Guarantee Listing.xlsx':
    //             BEGIN
    //                 ExcelSetupPage.DateCaption('Expiry Date From');
    //                 ExcelSetupPage.Date2Caption('Expiry Date To');
    //                 ExcelSetupPage.TerritoryCaption('Area Code');
    //                 ExcelSetupPage.RUNMODAL;
    //             END;
    //     END;
    //     COMMIT;

    //     UserSetupRec.RESET;
    //     UserSetupRec.SETFILTER("User ID", USERID);
    //     IF UserSetupRec.FINDFIRST THEN
    //         FilePath := UserSetupRec."Default Excel Path"
    //     ELSE
    //         FilePath := '';

    //     OpenExcelApp(FilePath + ExcelFileName);
    // end;

    // local procedure OpenExcelApp(ExcelFileNamewithPath: Text[250])
    // var
    //     ExclApp: Automation;
    //     WsShell: Automation;
    //     dumyInt: Integer;
    //     runModally: Boolean;
    // begin
    //     IF CREATE(ExclApp, TRUE, TRUE) THEN;
    //     ExclApp.Workbooks.Open(ExcelFileNamewithPath);
    //     //ExclApp.ActivateMicrosoftApp(7);//ExclApp.ActiveWorkbook.PrintPreview(True);//SHELL('Excel.exe' ,'E:\TEST\OData Reports\Sales_Order_Info.xlsx');
    //     ExclApp.Visible(TRUE);
    //     ExclApp.ScreenUpdating(TRUE);
    //     ExclApp.ActiveWorkbook.RefreshAll();
    //     ExclApp.ActiveWorkbook.Save();
    //     ExclApp.ActiveWorkbook.PrintPreview(TRUE);
    //     //ExclApp.ActiveWorkbook.Close();
    //     CLEAR(ExclApp);

    //     /*
    //     dumyInt := 1;
    //     runModally := FALSE;
    //     CREATE(WsShell, FALSE , TRUE);
    //     WsShell.Run('"Excel.exe" "E:\TEST\OData Reports\Sales_Order_Info.xlsx"' ,dumyInt,runModally);
    //     CLEAR(WsShell);
    //     */

    // end;
}

