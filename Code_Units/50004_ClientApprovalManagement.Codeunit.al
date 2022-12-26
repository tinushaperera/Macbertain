codeunit 50004 "Client Approval Management"
{
    // When Last Level of Approval is completed, Document is released Automatcally
    // Sequence Must be set without gaps , i.e. Sequence is increment of one .


    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Approval Setup not found.';
        Text001: Label '%1 %2 requires further approval.\\Approval request entries have been created.';
        Text002: Label 'The approval request cannot be canceled because the %1 %2 has already approved and send for next level approval.';
        Text003: Label '%1 %2 approval request cancelled.';
        Text004: Label 'More than one entries found.';
        Text005: Label 'The %1 %2 does not have any Lines.';
        Text006: Label 'Next approve level not defined.';
        Text007: Label 'Only created user can send for approval.';
        Text008: Label 'Only created user can cancel the request.';
        Text011: Label 'Microsoft Dynamics NAV: %1 Mail';
        Text044: Label 'Order No %1 Customer %2 has been %3 .';
        Text045: Label 'Order No %1 Customer %2 has been %3 and send the e-mail to sales person.';
        Text046: Label 'Order Status';
        Text047: Label 'The sales order no. %1 has been sent to your approval.';
        Text048: Label 'Microsoft Dynamics NAV Approval System.';
        Text049: Label 'The sales return order no.  %1 has been sent to your approval.';
        LastLineNo: Integer;


    procedure CheckAppSetup("Table Code": Code[20]; "User ID": Code[50])
    begin
    end;


    procedure CreateSalesEntry(var SalesHed: Record "Sales Header")
    begin
        WITH SalesHed DO BEGIN
            IF NOT SalesLinesExist THEN
                ERROR(Text005, FORMAT("Document Type"), SalesHed."No.");
            IF "Create User ID" <> USERID THEN
                ERROR(Text007);
            IF CreateAppEntryAll(DATABASE::"Sales Header", "Entry Code",
                  "Document Type", "No.", "Create User ID") THEN BEGIN
                IF Status <> Status::"Pending Approval" THEN BEGIN
                    Status := Status::"Pending Approval";
                    MODIFY;
                    MESSAGE(Text001, FORMAT("Document Type"), "No.");
                END;
            END
            ELSE BEGIN
                MESSAGE('No Approval Required. Document will be Released');
                SalesHed.Status := SalesHed.Status::Released;
                SalesHed."Released User ID" := USERID;
                SalesHed."Date-Time Released" := CREATEDATETIME(TODAY, TIME);
                SalesHed.MODIFY;
            END;
        END;
    end;

    local procedure CreateAppEntryAll("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]; U_ID: Code[50]): Boolean
    var
        ClientAppSetup: Record "Client Approval User Setup";
        User: Record User;
        AprLowLimit: Decimal;
    begin
        WITH ClientAppSetup DO BEGIN
            User.RESET;
            User.SETRANGE("User Name", U_ID);
            User.FINDFIRST;
            //MESSAGE('TNo%1-Tcode%2',"TableNo.",TableCode);
            RESET;
            SETRANGE("Table No.", "TableNo.");
            SETRANGE("Table Code", TableCode);
            SETRANGE("Approval Sequence No.", 1);
            //SETRANGE("From Designation",User.Designation);
            IF FINDSET THEN BEGIN
                IF NOT CheckAppCreated("TableNo.", TableCode, DocType, DocNo) THEN BEGIN
                    REPEAT
                        CASE ClientAppSetup."Approve Type" OF
                            ClientAppSetup."Approve Type"::"Credit Limit":
                                BEGIN
                                    AprLowLimit := ClientAppSetup."Approve Lower Limit";
                                    IF CheckCreditLimit(AprLowLimit, "TableNo.", TableCode, DocType, DocNo) THEN
                                        CreateLineAppEntry("Table No.", "Table Code", DocType, DocNo, U_ID, "Approval Sequence No.", "Approve Type", "Approve Lower Limit", "Sequence Line No.");
                                    //CreateAppEntry("TableNo.",TableCode,DocType,DocNo,U_ID,1,ClientAppSetup."Approve Type",ClientAppSetup."Approve Lower Limit");
                                END;
                            ClientAppSetup."Approve Type"::OverDue:
                                BEGIN
                                    IF CheckOverDue("TableNo.", TableCode, DocType, DocNo) THEN
                                        CreateLineAppEntry("Table No.", "Table Code", DocType, DocNo, U_ID, "Approval Sequence No.", "Approve Type", "Approve Lower Limit", "Sequence Line No.");
                                    //CreateAppEntry("TableNo.",TableCode,DocType,DocNo,U_ID,1,ClientAppSetup."Approve Type",ClientAppSetup."Approve Lower Limit");
                                END;
                            ClientAppSetup."Approve Type"::Sample:
                                BEGIN
                                    CreateLineAppEntry("Table No.", "Table Code", DocType, DocNo, U_ID, "Approval Sequence No.", "Approve Type", "Approve Lower Limit", "Sequence Line No.");
                                    //CreateAppEntry("TableNo.",TableCode,DocType,DocNo,U_ID,1,ClientAppSetup."Approve Type",ClientAppSetup."Approve Lower Limit");
                                END;
                            ClientAppSetup."Approve Type"::"Free Issue":
                                BEGIN
                                    IF CheckFreeIssue("TableNo.", TableCode, DocType, DocNo) THEN
                                        CreateLineAppEntry("Table No.", "Table Code", DocType, DocNo, U_ID, "Approval Sequence No.", "Approve Type", "Approve Lower Limit", "Sequence Line No.");
                                    //CreateAppEntry("TableNo.",TableCode,DocType,DocNo,U_ID,1,ClientAppSetup."Approve Type",ClientAppSetup."Approve Lower Limit");
                                END;
                            ClientAppSetup."Approve Type"::Discount:
                                BEGIN
                                    IF CheckDiscounts("TableNo.", TableCode, DocType, DocNo) THEN
                                        CreateLineAppEntry("Table No.", "Table Code", DocType, DocNo, U_ID, "Approval Sequence No.", "Approve Type", "Approve Lower Limit", "Sequence Line No.");
                                    //CreateAppEntry("TableNo.",TableCode,DocType,DocNo,U_ID,1,ClientAppSetup."Approve Type",ClientAppSetup."Approve Lower Limit");
                                END;
                            ClientAppSetup."Approve Type"::OverDiscount:
                                BEGIN
                                    IF CheckDiscExceedProfit("TableNo.", TableCode, DocType, DocNo) THEN
                                        CreateLineAppEntry("Table No.", "Table Code", DocType, DocNo, U_ID, "Approval Sequence No.", "Approve Type", "Approve Lower Limit", "Sequence Line No.");
                                    //CreateAppEntry("TableNo.",TableCode,DocType,DocNo,U_ID,1,ClientAppSetup."Approve Type",ClientAppSetup."Approve Lower Limit");
                                END;
                        END;
                    UNTIL NEXT = 0;
                END;
                IF CheckAppCreated("TableNo.", TableCode, DocType, DocNo) THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END
            ELSE
                ERROR(Text000);
        END
    end;

    local procedure CheckAppCreated("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Boolean
    var
        ClientAppEntry: Record "Client Approval Entry";
        Loop: Integer;
    begin
        WITH ClientAppEntry DO BEGIN
            RESET;
            SETRANGE("Table No.", "TableNo.");
            SETRANGE("Table Code", TableCode);
            SETRANGE(Type, DocType);
            SETRANGE("No.", DocNo);
            SETRANGE("Approval Sequence No.", 1);
            IF FINDSET(TRUE, FALSE) THEN
                REPEAT
                    IF (Status = Status::Created) OR
                       (Status = Status::Open) THEN
                        Loop := Loop + 1;
                UNTIL NEXT = 0;
        END;

        IF Loop > 0 THEN
            EXIT(TRUE);
    end;

    local procedure CreateAppEntry("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[10]; U_ID: Code[50]; SqNo: Integer; ApproveType: Option " ","Credit Limit",OverDue,Sample,"Free Issue",Discount; ApproveLowerLimit: Decimal): Boolean
    var
        ClientAppEntry: Record "Client Approval Entry";
        ClientAppSetup: Record "Client Approval User Setup";
        User: Record User;
        SalesHed: Record "Sales Header";
        AppMgtNotify: Codeunit "Mail Notification Management";
    begin
        WITH ClientAppEntry DO BEGIN
            User.RESET;
            User.SETRANGE("User Name", U_ID);
            User.FINDFIRST;

            ClientAppSetup.RESET;
            ClientAppSetup.SETRANGE("Table No.", "TableNo.");
            ClientAppSetup.SETRANGE("Table Code", TableCode);
            ClientAppSetup.SETFILTER("Approve Type", '%1', ApproveType);
            ClientAppSetup.SETFILTER("Approve Lower Limit", '%1', ApproveLowerLimit);
            ClientAppSetup.SETRANGE("Approval Sequence No.", SqNo);
            IF ClientAppSetup.FINDSET THEN
                REPEAT
                    CreateLineAppEntry("TableNo.", TableCode, DocType, DocNo, U_ID, SqNo, ClientAppSetup."Approve Type", ClientAppSetup."Approve Lower Limit", ClientAppSetup."Sequence Line No.");
                //IF ApproveType <> ApproveType::Discount THEN
                //  AppMgtNotify.SendSalesOrderAprReqMail(ClientAppEntry);  This is done at Line level.
                UNTIL ClientAppSetup.NEXT = 0;


            IF SqNo <> 1 THEN
                MESSAGE(Text001, FORMAT(Type), "No.");
            EXIT(TRUE);
        END;
    end;

    local procedure CheckCreditLimit(var AprLowLimit: Decimal; "TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Boolean
    var
        CrBal: Decimal;
        CustRec: Record Customer;
        SaleSetupRec: Record "Sales & Receivables Setup";
        ClientAppSetup: Record "Client Approval User Setup";
        SalesHedRec: Record "Sales Header";
    begin
        //AprLowLimit := 0  ;
        SaleSetupRec.GET;
        IF SalesHedRec.GET(DocType, DocNo) THEN BEGIN
            CrBal := 0;
            IF CustRec.GET(SalesHedRec."Sell-to Customer No.") THEN BEGIN
                //CustRec.CALCFIELDS("PD Check Amount","Promissory Note Amount","Bank Guarantee Amount",Balance, "Outstanding Orders");
                CustRec.CALCFIELDS(CustRec."Balance (LCY)", CustRec."Outstanding Orders (LCY)");
                CrBal := (CustRec."Balance (LCY)" + CustRec."Outstanding Orders (LCY)") - CustRec."Credit Limit (LCY)";
            END;
            ClientAppSetup.RESET;
            ClientAppSetup.SETFILTER("Table No.", '%1', "TableNo.");
            ClientAppSetup.SETFILTER("Table Code", TableCode);
            ClientAppSetup.SETFILTER("Approve Type", '%1', ClientAppSetup."Approve Type"::"Credit Limit");
            ClientAppSetup.SETFILTER("Approval Sequence No.", '%1', 1);
            ClientAppSetup.SETFILTER(ClientAppSetup."Approve Lower Limit", '%1', AprLowLimit);
            IF ClientAppSetup.FINDSET THEN
                REPEAT
                    IF (CrBal >= ClientAppSetup."Approve Lower Limit") AND (CrBal <= ClientAppSetup."Approve Upper Limit") THEN BEGIN
                        AprLowLimit := ClientAppSetup."Approve Lower Limit";
                        EXIT(TRUE);
                    END;
                UNTIL ClientAppSetup.NEXT = 0;
        END;
        EXIT(FALSE);
    end;

    local procedure GetNextLineNo("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[10]): Integer
    var
        ClientAppEntry: Record "Client Approval Entry";
        LineNo: Integer;
    begin
        WITH ClientAppEntry DO BEGIN
            RESET;
            SETRANGE("Table No.", "TableNo.");
            SETRANGE("Table Code", TableCode);
            SETRANGE(Type, DocType);
            SETRANGE("No.", DocNo);
            IF FINDLAST THEN
                LineNo := "Line No."
            ELSE
                LineNo := 10000;
        END;

        IF LineNo > LastLineNo THEN
            LastLineNo := LineNo;
        LastLineNo += 10000;
        EXIT(LastLineNo);
    end;

    local procedure CheckOverDue("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Boolean
    var
        CrBal: Decimal;
        CustRec: Record Customer;
        SaleSetupRec: Record "Sales & Receivables Setup";
        SalesHedRec: Record "Sales Header";
        CustLgrRec: Record "Cust. Ledger Entry";
        OverDue: Decimal;
    begin
        OverDue := 0;
        SaleSetupRec.GET;
        IF SalesHedRec.GET(DocType, DocNo) THEN BEGIN
            CustLgrRec.SETFILTER(CustLgrRec."Customer No.", SalesHedRec."Sell-to Customer No.");
            //CustLgrRec.SETFILTER(CustLgrRec."Remaining Amount" , '>=%1' ,SaleSetupRec."Overdue Approval Limit");
            CustLgrRec.SETFILTER("Document Date", '<%1', (WORKDATE - SaleSetupRec."Overdue Approval Age"));
            IF CustLgrRec.FINDFIRST THEN
                REPEAT
                    CustLgrRec.CALCFIELDS("Remaining Amount");
                    OverDue += CustLgrRec."Remaining Amount";
                UNTIL CustLgrRec.NEXT = 0;
            IF OverDue > SaleSetupRec."Overdue Approval Limit" THEN //checking overdue approval threshlod
                EXIT(TRUE);
            EXIT(FALSE);
        END;

        EXIT(FALSE);
    end;

    local procedure CheckFreeIssue("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Boolean
    var
        SalesHedRec: Record "Sales Header";
    begin
        IF SalesHedRec.GET(DocType, DocNo) THEN BEGIN
            SalesHedRec.CALCFIELDS("Fee Issue Exists");
            EXIT(SalesHedRec."Fee Issue Exists");
        END
        ELSE
            EXIT(FALSE);
    end;

    local procedure CheckDiscounts("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Boolean
    var
        SalesHedRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        PriceMgt: Codeunit "Sales Price Calc. Mgt."; // Need to recheck with rumal aiyas
    begin
        IF SalesHedRec.GET(DocType, DocNo) THEN BEGIN
            SalesHedRec.CALCFIELDS("Dicount Exists");
            IF SalesHedRec."Dicount Exists" THEN BEGIN
                SalesLineRec.SETFILTER(SalesLineRec."Document Type", '%1', DocType);
                SalesLineRec.SETFILTER(SalesLineRec."Document No.", DocNo);
                IF SalesLineRec.FINDFIRST THEN
                    REPEAT
                        IF SalesLineRec."Line Discount %" > SalesLineRec."Standard Line Discount %" THEN BEGIN
                            IF CheckDiscountOverCost(SalesLineRec) THEN
                                EXIT(FALSE);
                        END;
                    UNTIL SalesLineRec.NEXT = 0;
                EXIT(TRUE);
            END
            ELSE
                EXIT(SalesHedRec."Dicount Exists");
        END
        ELSE
            EXIT(FALSE);

        EXIT(FALSE);
    end;


    procedure ApproveEntry(var ClientAppEntry: Record "Client Approval Entry")
    var
        SalesHed: Record "Sales Header";
    begin
        ClientAppEntry.LOCKTABLE;

        UpdateApproveEntry(ClientAppEntry);

        IF NOT CheckAppExists(ClientAppEntry."Table No.", ClientAppEntry."Table Code", ClientAppEntry.Type, ClientAppEntry."No.") THEN BEGIN
            IF SalesHed.GET(ClientAppEntry.Type, ClientAppEntry."No.") THEN BEGIN
                SalesHed.Status := SalesHed.Status::Released;
                SalesHed."Released User ID" := USERID;
                SalesHed."Date-Time Released" := CREATEDATETIME(TODAY, TIME);
                SalesHed.MODIFY;
            END;
        END;

    end;

    local procedure UpdateApproveEntry(var ClientAppEntry: Record "Client Approval Entry")
    var
        ClientAppSetup: Record "Client Approval User Setup";
        User: Record User;
        ClientAppEntryM: Record "Client Approval Entry";
        CreditLimitOk: Boolean;
        OverdueOk: Boolean;
        DisOK: Boolean;
        FreeIsuQtyOK: Boolean;
        OverDueChqOk: Boolean;
    begin
        WITH ClientAppEntry DO BEGIN
            Status := Status::Approved;
            "Last Modified By ID" := "Approved ID";
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Date-Time Approved" := CREATEDATETIME(TODAY, TIME);
            MODIFY;
            IF "Approval Method" = "Approval Method"::Either THEN;
            CloseAppEntries(ClientAppEntry);
            IF (CheckNextAppLeval(ClientAppEntry)) AND (NOT CheckThisAppEntries(ClientAppEntry)) THEN
                CreateAppEntry("Table No.", "Table Code", Type, "No.", "Approved ID",
                  ("Approval Sequence No." + 1), "Approve Type", "Approve Lower Limit");
        END;
    end;

    local procedure CheckNextAppLeval(ClientAppEntry: Record "Client Approval Entry"): Boolean
    var
        ClientAppSetup: Record "Client Approval User Setup";
    begin
        WITH ClientAppEntry DO BEGIN
            ClientAppSetup.RESET;
            ClientAppSetup.SETRANGE("Table No.", "Table No.");
            ClientAppSetup.SETRANGE("Table Code", "Table Code");
            ClientAppSetup.SETRANGE("Approve Type", "Approve Type");
            ClientAppSetup.SETRANGE("Approve Lower Limit", "Approve Lower Limit");
            ClientAppSetup.SETRANGE("Approval Sequence No.", ("Approval Sequence No." + 1));
            IF ClientAppSetup.FINDFIRST THEN
                EXIT(TRUE);
        END;
    end;

    local procedure CheckAppExists("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[10]): Boolean
    var
        ClientAppEntry: Record "Client Approval Entry";
        Loop: Integer;
    begin
        WITH ClientAppEntry DO BEGIN
            RESET;
            SETRANGE("Table No.", "TableNo.");
            SETRANGE("Table Code", TableCode);
            SETRANGE(Type, DocType);
            SETRANGE("No.", DocNo);
            //SETRANGE("Approval Sequence No.",1);
            IF FINDSET(TRUE, FALSE) THEN
                REPEAT
                    IF (Status = Status::Created) OR
                       (Status = Status::Open) THEN
                        Loop := Loop + 1;
                UNTIL NEXT = 0;
        END;

        //IF Loop = 1 THEN
        //  EXIT(TRUE)
        //ELSE IF Loop > 1 THEN
        //  ERROR(Text004);
        IF Loop > 0 THEN
            EXIT(TRUE);
    end;


    procedure CancelAppRequest(var SalesHed: Record "Sales Header")
    var
        ClientAppEntry: Record "Client Approval Entry";
        Loop: Integer;
    begin
        WITH SalesHed DO BEGIN
            IF CheckAppApproved(DATABASE::"Sales Header", "Entry Code", "Document Type", "No.") THEN
                ERROR('Cannot Cancel. Already Approval started');

            IF SalesHed."Document Type" = SalesHed."Document Type"::Order THEN
                IF (SalesHed.Status = SalesHed.Status::"Pending Approval") THEN
                    IF SalesHed."Create User ID" <> USERID THEN
                        ERROR('You dont have permission to cancel the Approval !');
        END;


        WITH ClientAppEntry DO BEGIN
            RESET;
            SETRANGE("Table No.", DATABASE::"Sales Header");
            SETRANGE("Table Code", SalesHed."Entry Code");
            SETRANGE(Type, SalesHed."Document Type");
            SETRANGE("No.", SalesHed."No.");
            //SETRANGE();
            IF FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ClientAppEntry.DELETE;
                    Loop := Loop + 1;
                UNTIL NEXT = 0;

            IF Loop > 0 THEN BEGIN
                SalesHed.VALIDATE(Status, SalesHed.Status::Open);
                SalesHed.MODIFY;
            END;


        END;
    end;

    local procedure CheckAppApproved("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[10]): Boolean
    var
        ClientAppEntry: Record "Client Approval Entry";
        Loop: Integer;
    begin
        WITH ClientAppEntry DO BEGIN
            RESET;
            SETRANGE("Table No.", "TableNo.");
            SETRANGE("Table Code", TableCode);
            SETRANGE(Type, DocType);
            SETRANGE("No.", DocNo);
            SETRANGE("Approval Sequence No.", 1);
            IF FINDSET(TRUE, FALSE) THEN
                REPEAT
                    IF (Status = Status::Approved) THEN
                        Loop := Loop + 1;
                UNTIL NEXT = 0;
        END;

        //IF Loop = 1 THEN
        //  EXIT(TRUE)
        //ELSE IF Loop > 1 THEN
        //  ERROR(Text004);
        IF Loop > 0 THEN
            EXIT(TRUE);
    end;

    local procedure CloseAppEntries(ClientAppEntry: Record "Client Approval Entry")
    var
        ClientApp: Record "Client Approval Entry";
    begin
        ClientApp.SETFILTER("Table No.", '%1', ClientAppEntry."Table No.");
        ClientApp.SETFILTER("Table Code", '%1', ClientAppEntry."Table Code");
        ClientApp.SETFILTER(Type, '%1', ClientAppEntry.Type);
        ClientApp.SETFILTER("No.", ClientAppEntry."No.");
        ClientApp.SETFILTER("Approve Type", '%1', ClientAppEntry."Approve Type");
        ClientApp.SETFILTER("Approve Lower Limit", '%1', ClientAppEntry."Approve Lower Limit");
        ClientApp.SETFILTER("Approval Sequence No.", '%1', ClientAppEntry."Approval Sequence No.");
        ClientApp.SETFILTER(Status, '%1', ClientApp.Status::Open);
        IF ClientApp.FINDSET THEN
            REPEAT
                ClientApp.Status := ClientApp.Status::Closed;
                ClientApp."Last Modified By ID" := ClientAppEntry."Approved ID";
                ClientApp."Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
                ClientApp."Date-Time Approved" := CREATEDATETIME(TODAY, TIME);
                ClientApp.MODIFY;
            UNTIL ClientApp.NEXT = 0;
    end;

    local procedure CheckThisAppLeval(ClientAppEntry: Record "Client Approval Entry"): Boolean
    var
        ClientAppSetup: Record "Client Approval User Setup";
    begin
        WITH ClientAppEntry DO BEGIN
            ClientAppSetup.RESET;
            ClientAppSetup.SETRANGE("Table No.", "Table No.");
            ClientAppSetup.SETRANGE("Table Code", "Table Code");
            ClientAppSetup.SETRANGE("Approve Type", "Approve Type");
            ClientAppSetup.SETRANGE("Approve Lower Limit", "Approve Lower Limit");
            ClientAppSetup.SETRANGE("Approval Sequence No.", "Approval Sequence No.");
            //ClientAppSetup.SETRANGE("From Designation","Approver Designation");
            IF ClientAppSetup.FINDFIRST THEN
                EXIT(TRUE);
        END;
    end;

    local procedure CheckThisAppEntries(ClientAppEntry: Record "Client Approval Entry"): Boolean
    var
        Loop: Integer;
        lClientAppEntry: Record "Client Approval Entry";
    begin
        WITH lClientAppEntry DO BEGIN
            RESET;
            SETRANGE("Table No.", ClientAppEntry."Table No.");
            SETRANGE("Table Code", ClientAppEntry."Table Code");
            SETRANGE(Type, ClientAppEntry.Type);
            SETRANGE("No.", ClientAppEntry."No.");
            SETFILTER("Approve Type", '%1', ClientAppEntry."Approve Type");
            SETFILTER("Approve Lower Limit", '%1', ClientAppEntry."Approve Lower Limit");
            SETRANGE("Approval Sequence No.", "Approval Sequence No.");
            IF FINDSET(TRUE, FALSE) THEN
                REPEAT
                    IF (Status = Status::Created) OR
                       (Status = Status::Open) THEN
                        Loop := Loop + 1;
                UNTIL NEXT = 0;
        END;

        IF Loop > 0 THEN
            EXIT(TRUE);
    end;

    local procedure CreateLineAppEntry("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[10]; U_ID: Code[50]; SqNo: Integer; ApproveType: Option " ","Credit Limit",OverDue,Sample,"Free Issue",Discount; ApproveLowerLimit: Decimal; SeqLineNo: Integer): Boolean
    var
        ClientAppEntry: Record "Client Approval Entry";
        ClientAppSetup: Record "Client Approval User Setup";
        User: Record User;
        SalesHed: Record "Sales Header";
        AppMgtNotify: Codeunit "Mail Notification Management";
        Proceed: Boolean;
    begin
        WITH ClientAppEntry DO BEGIN
            User.RESET;
            User.SETRANGE("User Name", U_ID);
            User.FINDFIRST;

            ClientAppSetup.RESET;
            ClientAppSetup.SETRANGE("Table No.", "TableNo.");
            ClientAppSetup.SETRANGE("Table Code", TableCode);
            ClientAppSetup.SETFILTER("Approve Type", '%1', ApproveType);
            ClientAppSetup.SETFILTER("Approve Lower Limit", '%1', ApproveLowerLimit);
            ClientAppSetup.SETRANGE("Approval Sequence No.", SqNo);
            ClientAppSetup.SETFILTER("Sequence Line No.", '%1', SeqLineNo);
            IF ClientAppSetup.FINDSET THEN
                REPEAT
                    Proceed := TRUE;
                    CASE ClientAppSetup."Table No." OF
                        DATABASE::"Sales Header":
                            BEGIN
                                SalesHed.GET(DocType, DocNo);
                                IF NOT (ClientAppSetup."Shortcut Dimension 1 Code" = '') AND NOT ((ClientAppSetup."Shortcut Dimension 1 Code" <> '') AND (ClientAppSetup."Shortcut Dimension 1 Code" = SalesHed."Shortcut Dimension 1 Code")) THEN
                                    Proceed := FALSE;
                                IF NOT (ClientAppSetup."Shortcut Dimension 2 Code" = '') AND NOT ((ClientAppSetup."Shortcut Dimension 2 Code" <> '') AND (ClientAppSetup."Shortcut Dimension 2 Code" = SalesHed."Shortcut Dimension 2 Code")) THEN
                                    Proceed := FALSE;

                                IF Proceed THEN BEGIN
                                    INIT;
                                    SalesHed.CALCFIELDS(Amount);
                                    "Global Dimension 2 Code" := SalesHed."Shortcut Dimension 2 Code";
                                    "Global Dimension 1 Code" := SalesHed."Shortcut Dimension 1 Code";
                                    "Salesperson Code" := SalesHed."Salesperson Code";
                                    ClientAppEntry."Sell-to Customer No." := SalesHed."Sell-to Customer No.";
                                    ClientAppEntry."Sell-to Customer Name" := SalesHed."Sell-to Customer Name";
                                    ClientAppEntry.Amount := SalesHed.Amount;
                                END;
                            END;
                        ELSE
                            INIT;
                            Proceed := TRUE;
                    END;

                    IF Proceed THEN BEGIN

                        ClientAppEntry."Entry No." := ClientAppEntry.GetLastEntryNo + 1;
                        "Table No." := "TableNo.";
                        "Table Code" := TableCode;
                        Type := DocType;
                        "No." := DocNo;
                        "Line No." := GetNextLineNo("TableNo.", TableCode,
                            DocType, DocNo);
                        "Approval Sequence No." := SqNo;
                        "Sender ID" := U_ID;
                        ClientAppEntry."Approve Type" := ApproveType;
                        ClientAppEntry."Approve Lower Limit" := ApproveLowerLimit;
                        ClientAppEntry."Approved ID" := ClientAppSetup."Approve User ID";
                        ClientAppEntry."Approve Upper Limit" := ClientAppSetup."Approve Upper Limit";
                        ClientAppEntry."Approval Method" := ClientAppSetup."Approval Method";
                        ClientAppEntry."Sequence Line No." := ClientAppSetup."Sequence Line No.";
                        Status := Status::Open; //< Chin 20160626 1301    Set 'Open' when 'Created' >

                        "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);



                        INSERT(TRUE);
                        IF ClientAppSetup."Send Request Mail" THEN
                            AppMgtNotify.SendSalesOrderAprReqMail(ClientAppEntry);
                    END;
                UNTIL ClientAppSetup.NEXT = 0;



        END;
    end;


    procedure RejectAppRequest(var SalesHed: Record "Sales Header")
    var
        ClientAppEntry: Record "Client Approval Entry";
        Loop: Integer;
    begin
        WITH SalesHed DO BEGIN
            IF CheckAppApproved(DATABASE::"Sales Header", "Entry Code", "Document Type", "No.") THEN
                ERROR('Connot Cancel. Already Approval started');
        END;
        WITH ClientAppEntry DO BEGIN
            RESET;
            SETRANGE("Table No.", DATABASE::"Sales Header");
            SETRANGE("Table Code", SalesHed."Entry Code");
            SETRANGE(Type, SalesHed."Document Type");
            SETRANGE("No.", SalesHed."No.");
            //SETRANGE();
            IF FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ClientAppEntry.DELETE;
                    Loop := Loop + 1;
                UNTIL NEXT = 0;

            IF Loop > 0 THEN BEGIN
                SalesHed.VALIDATE(Status, SalesHed.Status::Open);
                SalesHed.MODIFY;
            END;


        END;
    end;


    procedure RejectApproveEntry(var ClientAppEntry: Record "Client Approval Entry")
    var
        ClientAppSetup: Record "Client Approval User Setup";
        User: Record User;
        ClientAppEntryM: Record "Client Approval Entry";
        CreditLimitOk: Boolean;
        OverdueOk: Boolean;
        DisOK: Boolean;
        FreeIsuQtyOK: Boolean;
        OverDueChqOk: Boolean;
        SalesHed: Record "Sales Header";
    begin
        WITH ClientAppEntry DO BEGIN
            IF CONFIRM('Do you really want to Reject the Approval process of Type:%1 No.:%2', FALSE, ClientAppEntry.Type, ClientAppEntry."No.") THEN BEGIN
                Status := Status::Rejected;
                "Last Modified By ID" := "Approved ID";
                "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
                "Date-Time Approved" := CREATEDATETIME(TODAY, TIME);
                MODIFY;
                //IF "Approval Method" = "Approval Method"::Either THEN;
                CloseAppEntriesAll(ClientAppEntry);
                /*  IF (CheckNextAppLeval(ClientAppEntry)) AND (NOT CheckThisAppEntries(ClientAppEntry)) THEN
                    CreateAppEntry("Table No.","Table Code",Type,"No.","Approved ID",
                      ("Approval Sequence No." + 1), "Approve Type","Approve Lower Limit");
                */

                CASE "Table No." OF
                    DATABASE::"Sales Header":
                        BEGIN
                            IF SalesHed.GET(Type, "No.") THEN BEGIN
                                SalesHed.VALIDATE(Status, SalesHed.Status::Open);
                                SalesHed.MODIFY;
                            END;
                        END;
                    ELSE
                END

            END;
        END;

    end;

    local procedure CloseAppEntriesAll(ClientAppEntry: Record "Client Approval Entry")
    var
        ClientApp: Record "Client Approval Entry";
    begin
        ClientApp.SETFILTER("Table No.", '%1', ClientAppEntry."Table No.");
        ClientApp.SETFILTER("Table Code", '%1', ClientAppEntry."Table Code");
        ClientApp.SETFILTER(Type, '%1', ClientAppEntry.Type);
        ClientApp.SETFILTER("No.", ClientAppEntry."No.");
        //ClientApp.SETFILTER("Approve Type",'%1',ClientAppEntry."Approve Type");
        //ClientApp.SETFILTER("Approve Lower Limit" , '%1',ClientAppEntry."Approve Lower Limit");
        //ClientApp.SETFILTER("Approval Sequence No.", '%1',ClientAppEntry."Approval Sequence No.");
        ClientApp.SETFILTER(Status, '%1', ClientApp.Status::Open);
        IF ClientApp.FINDSET THEN
            REPEAT
                ClientApp.Status := ClientApp.Status::Closed;
                ClientApp."Last Modified By ID" := ClientAppEntry."Approved ID";
                ClientApp."Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
                ClientApp."Date-Time Approved" := CREATEDATETIME(TODAY, TIME);
                ClientApp.MODIFY;
            UNTIL ClientApp.NEXT = 0;
    end;


    procedure CheckManualDocRelease("TableNo.": Integer; TableCode: Code[20]): Boolean
    var
        ClientAppSetup: Record "Client Approval User Setup";
    begin
        WITH ClientAppSetup DO BEGIN
            RESET;
            SETRANGE("Table No.", "TableNo.");
            SETRANGE("Table Code", TableCode);
            IF FINDSET THEN
                EXIT(FALSE)
            ELSE
                EXIT(TRUE);
        END
    end;

    local procedure CheckDiscExceedProfit("TableNo.": Integer; TableCode: Code[20]; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Boolean
    var
        SalesHedRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        PriceMgt: Codeunit "Sales Price Calc. Mgt.";  //**************************
    begin
        IF SalesHedRec.GET(DocType, DocNo) THEN BEGIN
            SalesHedRec.CALCFIELDS("Dicount Exists");
            IF SalesHedRec."Dicount Exists" THEN BEGIN
                SalesLineRec.SETFILTER(SalesLineRec."Document Type", '%1', DocType);
                SalesLineRec.SETFILTER(SalesLineRec."Document No.", DocNo);
                IF SalesLineRec.FINDFIRST THEN
                    REPEAT
                        IF CheckDiscountOverCost(SalesLineRec) THEN
                            EXIT(TRUE);
                    UNTIL SalesLineRec.NEXT = 0;
            END
            ELSE
                EXIT(SalesHedRec."Dicount Exists");
        END
        ELSE
            EXIT(FALSE);

        EXIT(FALSE);
    end;

    local procedure CheckDiscountOverCost(SalesLine: Record "Sales Line"): Boolean
    var
        sku: Record "Stockkeeping Unit";
    begin
        IF SalesLine."Variant Code" = '' THEN BEGIN
            IF (SalesLine.Quantity * SalesLine."Unit Price") * (100 - SalesLine."Line Discount %") / 100 <= (SalesLine."Unit Cost" * SalesLine.Quantity) THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END ELSE BEGIN
            IF sku.GET(SalesLine."Location Code", SalesLine."No.", SalesLine."Variant Code") THEN BEGIN
                IF (SalesLine.Quantity * SalesLine."Unit Price") * (100 - SalesLine."Line Discount %") / 100 <= (sku."SKU Unit Cost" * SalesLine.Quantity) THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END ELSE BEGIN
                IF (SalesLine.Quantity * SalesLine."Unit Price") * (100 - SalesLine."Line Discount %") / 100 <= (SalesLine."Unit Cost" * SalesLine.Quantity) THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;
        END;
    end;
}

