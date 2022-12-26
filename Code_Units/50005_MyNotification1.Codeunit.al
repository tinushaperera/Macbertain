codeunit 50005 "My Notification 1"
{

    trigger OnRun()
    var
        CustSecurity: Record "Customer Security";
        MailBodyTxt: Text[1024];
        CrLf: Text[2];
        CharTxt: Char;
        Mail: Codeunit Mail;
        GLSetup: Record "General Ledger Setup";
        ShipGuarantee: Record "Shipping Guarantee";
        ParamPos: Integer;
        param: Text[60];
    begin

        Params := 'BANK-GUARANTEE;PROMISSORY-NOTE;SHIPPING-GUARANTEE;CONTAINER-DEPOSIT;';
        IF NotifyUserID = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD(GLSetup."Notification User ID");
            NotifyUserID := GLSetup."Notification User ID";
        END;

        //MESSAGE('%1',  Params);

        CrLf[1] := 13;
        CrLf[2] := 10;
        CharTxt := 9;


        IF STRPOS(Params, ';') > 0 THEN
            REPEAT
                param := COPYSTR(Params, 1, STRPOS(Params, ';') - 1);
                Params := COPYSTR(Params, STRPOS(Params, ';') + 1);
                //MESSAGE('%1    %2' ,Params,param);
                CASE param OF
                    'BANK-GUARANTEE':
                        BEGIN


                            //Guarantee
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += 'Customer No.';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Reference No.';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:4em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Amount';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'End-Date';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += FORMAT(CrLf);
                            CustSecurity.RESET;
                            CustSecurity.SETFILTER(Active, '%1', TRUE);
                            CustSecurity.SETFILTER("End Date", '<%1', WORKDATE + 30);
                            CustSecurity.SETFILTER("Security Type", '%1', CustSecurity."Security Type"::"Bank Guarantee");
                            IF CustSecurity.FINDSET THEN BEGIN
                                REPEAT
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(CustSecurity."Customer No.", 30);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(CustSecurity."Reference No.", 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:3em">';
                                    MailBodyTxt += PADSTR(FORMAT(CustSecurity.Amount), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:5em">';
                                    MailBodyTxt += PADSTR(FORMAT(CustSecurity."End Date"), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += FORMAT(CrLf);
                                UNTIL CustSecurity.NEXT = 0;
                                //MESSAGE(MailBodyTxt);
                                //Mail.FormatTextForHtml(MailBodyTxt);
                                // SendMail('Bank Guarantee Alert', Mail.FormatTextForHtml(MailBodyTxt));
                            END;
                        END;
                    'PROMISSORY-NOTE':
                        BEGIN

                            MailBodyTxt := '';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += 'Customer No.';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Reference No.';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:4em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Amount';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'End-Date';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += FORMAT(CrLf);


                            CustSecurity.RESET;
                            CustSecurity.SETFILTER(Active, '%1', TRUE);
                            CustSecurity.SETFILTER("End Date", '<%1', WORKDATE + 30);
                            CustSecurity.SETFILTER("Security Type", '%1', CustSecurity."Security Type"::"Promissory Note");
                            IF CustSecurity.FINDSET THEN BEGIN
                                REPEAT
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(CustSecurity."Customer No.", 30);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(CustSecurity."Reference No.", 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:3em">';
                                    MailBodyTxt += PADSTR(FORMAT(CustSecurity.Amount), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:5em">';
                                    MailBodyTxt += PADSTR(FORMAT(CustSecurity."End Date"), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += FORMAT(CrLf);
                                UNTIL CustSecurity.NEXT = 0;
                                // SendMail('Promissory Note Alert', Mail.FormatTextForHtml(MailBodyTxt));
                            END;
                        END;
                    'SHIPPING-GUARANTEE':
                        BEGIN

                            //Shipping Guarantee
                            MailBodyTxt := '';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += 'Shipping Agent';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Import Job No.';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:4em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Value';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Cancel-Date';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += FORMAT(CrLf);

                            ShipGuarantee.RESET;
                            ShipGuarantee.SETFILTER("Shipping Guarantee Type", '%1', ShipGuarantee."Shipping Guarantee Type"::Guarantee);
                            ShipGuarantee.SETFILTER(Status, '%1', ShipGuarantee.Status::Released);
                            ShipGuarantee.SETFILTER("Cancel Date", '<%1', WORKDATE + 30);
                            IF ShipGuarantee.FINDSET THEN BEGIN
                                REPEAT
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(ShipGuarantee."Shipping Agent", 30);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(ShipGuarantee."Import Job No.", 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:3em">';
                                    MailBodyTxt += PADSTR(FORMAT(ShipGuarantee."Value(LCY)"), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:5em">';
                                    MailBodyTxt += PADSTR(FORMAT(ShipGuarantee."Cancel Date"), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += FORMAT(CrLf);
                                UNTIL ShipGuarantee.NEXT = 0;
                                // SendMail('Shipping Guarantee Alert', Mail.FormatTextForHtml(MailBodyTxt));
                            END;
                        END;


                    'CONTAINER-DEPOSIT':
                        BEGIN
                            //Container Deposit
                            MailBodyTxt := '';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += 'Import Job No.';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Deposit Recceipt No.';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:4em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Amount';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += '<span style="padding-right:3em">';
                            MailBodyTxt += FORMAT(CharTxt) + 'Cancel-Date';
                            MailBodyTxt += '</span>';
                            MailBodyTxt += FORMAT(CrLf);

                            ShipGuarantee.RESET;
                            ShipGuarantee.SETFILTER("Shipping Guarantee Type", '%1', ShipGuarantee."Shipping Guarantee Type"::Deposit);
                            ShipGuarantee.SETFILTER(Status, '%1', ShipGuarantee.Status::Released);
                            ShipGuarantee.SETFILTER("Cancel Date", '<%1', WORKDATE + 30);
                            IF ShipGuarantee.FINDSET THEN BEGIN
                                REPEAT
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(ShipGuarantee."Import Job No.", 30);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:8em">';
                                    MailBodyTxt += PADSTR(ShipGuarantee."Deposit Receipt No.", 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:3em">';
                                    MailBodyTxt += PADSTR(FORMAT(ShipGuarantee."Value(LCY)"), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += '<span style="padding-right:5em">';
                                    MailBodyTxt += PADSTR(FORMAT(ShipGuarantee."Cancel Date"), 15);
                                    MailBodyTxt += '</span>';
                                    MailBodyTxt += FORMAT(CrLf);
                                UNTIL ShipGuarantee.NEXT = 0;
                                // SendMail('Container Deposit Alert', Mail.FormatTextForHtml(MailBodyTxt));
                            END;
                        END;
                    'CUSTOMER-OVERDUE':
                        BEGIN
                            SetCustomerOverDueApproval;
                        END;
                    'STL':
                        BEGIN
                            SendLoanExpiryAlert(2);
                        END;
                    'IMPORT-LOAN':
                        BEGIN
                            SendLoanExpiryAlert(3);
                        END;
                END;

                ParamPos := STRPOS(Params, ';');
            //MESSAGE('%1 , %2' ,Params , ParamPos);
            UNTIL ParamPos <= 0
    end;

    var
        NotifyUserID: Code[50];
        Params: Text[250];


    // procedure SendMail(MailTitle: Text[60]; MailBody: Text[1024])
    // var
    //     SMTPMailSetup: Record "SMTP Mail Setup";
    //     SMTPMail: Codeunit "400"; // Mo code unit???
    //     UserSetupRec: Record "User Setup";
    //     TestMailTitleTxt: Label 'Customer Approval -  %1';
    //     TestMailBodyTxt1: Label 'Customer code  : %1        Name:%2 ';
    //     TestMailSuccessMsg: Label 'Message sent successfully';
    //     TestMailBodyTxt2: Label 'Approved By : %1';
    // begin

    //     SMTPMailSetup.GET;
    //     UserSetupRec.GET(NotifyUserID);
    //     UserSetupRec.TESTFIELD("E-Mail");

    //     SMTPMail.CreateMessage(
    //       '',
    //       UserSetupRec."E-Mail",
    //       UserSetupRec."E-Mail",
    //       STRSUBSTNO(MailTitle),
    //       STRSUBSTNO(
    //         STRSUBSTNO(MailBody),
    //         USERID,
    //         SMTPMailSetup."SMTP Server",
    //         FORMAT(SMTPMailSetup."SMTP Server Port"),
    //         SMTPMailSetup.Authentication,
    //         SMTPMailSetup."Secure Connection",
    //         SERVICEINSTANCEID,
    //         TENANTID),
    //       TRUE);

    //     SMTPMail.Send;
    //     //MESSAGE(TestMailSuccessMsg,UserSetupRec."E-Mail");
    // end;


    procedure InitVars(params: Text[250]; UserID: Code[30])
    begin
        NotifyUserID := UserID;
        params := params;
    end;


    procedure SendTransferOrderAprReqMail(TransferHdrRec: Record "Transfer Header")
    var
        MailBodyTxt: Text[1024];
        CrLf: Text[2];
        CharTxt: Char;
        Mail: Codeunit Mail;
        UserSetup: Record "User Setup";
    begin


        CrLf[1] := 13;
        CrLf[2] := 10;
        CharTxt := 9;


        MailBodyTxt += 'No. : ';
        MailBodyTxt += TransferHdrRec."No.";
        MailBodyTxt += 'Date : ';
        MailBodyTxt += FORMAT(TransferHdrRec."Posting Date");
        MailBodyTxt += 'Location : ';
        MailBodyTxt += TransferHdrRec."Transfer-from Code";


        UserSetup.SETFILTER(UserSetup."Transfer Order Approval", '%1', TRUE);
        IF UserSetup.FINDSET THEN
            REPEAT
                NotifyUserID := UserSetup."User ID";
            // SendMail('Issue Approval Request Alert', Mail.FormatTextForHtml(MailBodyTxt));
            UNTIL UserSetup.NEXT = 0;
    end;


    procedure SendTransferOrderAprMail(TransferHdrRec: Record "Transfer Header")
    var
        TransferLineRec: Record "Transfer Line";
        UserSetup: Record "User Setup";
        MailBodyTxt: Text[1024];
        CrLf: Text[2];
        CharTxt: Char;
        Mail: Codeunit Mail;
    begin

        CrLf[1] := 13;
        CrLf[2] := 10;
        CharTxt := 9;


        MailBodyTxt += 'No. : ';
        MailBodyTxt += TransferHdrRec."No.";
        MailBodyTxt += 'Date : ';
        MailBodyTxt += FORMAT(TransferHdrRec."Posting Date");
        MailBodyTxt += 'Location : ';
        MailBodyTxt += TransferHdrRec."Transfer-from Code";
        MailBodyTxt += FORMAT(CrLf);

        MailBodyTxt += '<span style="padding-right:3em">';
        MailBodyTxt += 'Item No.';
        MailBodyTxt += '</span>';
        MailBodyTxt += '<span style="padding-right:3em">';
        MailBodyTxt += FORMAT(CharTxt) + 'Shipped Quantity';
        MailBodyTxt += '</span>';
        MailBodyTxt += FORMAT(CrLf);



        TransferLineRec.SETFILTER("Document No.", TransferHdrRec."No.");
        IF TransferLineRec.FINDSET THEN
            REPEAT
                MailBodyTxt += '<span style="padding-right:3em">';
                MailBodyTxt += TransferLineRec."Item No.";
                MailBodyTxt += '</span>';
                MailBodyTxt += '<span style="padding-right:3em">';
                MailBodyTxt += FORMAT(CharTxt) + FORMAT(TransferLineRec."Quantity Shipped");
                MailBodyTxt += '</span>';
                MailBodyTxt += FORMAT(CrLf);
            UNTIL TransferLineRec.NEXT = 0;

        NotifyUserID := TransferHdrRec."Assigned User ID";
        // SendMail('Issue Approval Alert', Mail.FormatTextForHtml(MailBodyTxt));
    end;


    procedure SetCustomerOverDueApproval()
    var
        CustRec: Record Customer;
        SalesSetupRec: Record "Sales & Receivables Setup";
        CheckDate: Date;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        SalesSetupRec.GET;
        SalesSetupRec.TESTFIELD("Overdue Days to Block Customer");
        CheckDate := WORKDATE - SalesSetupRec."Overdue Days to Block Customer";
        CustRec.RESET;
        CustRec.SETFILTER(CustRec."Date Filter 2", '..%1', CheckDate);
        CustRec.SETFILTER(CustRec."Overdue Invoice Amount", '>0');
        //CustRec.SETFILTER(
        IF CustRec.FINDSET THEN
            REPEAT
                IF ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(CustRec) THEN
                    ApprovalsMgmt.OnSendCustomerForApproval(CustRec);
            UNTIL CustRec.NEXT = 0;
    end;

    local procedure SendLoanExpiryAlert(LoanType: Integer)
    var
        MailBodyTxt: Text[1024];
        CrLf: Text[2];
        CharTxt: Char;
        Mail: Codeunit Mail;
        ShipGuarantee: Record "Shipping Guarantee";
        subjectTxt: Text[50];
        UserSetup: Record "User Setup";
    begin

        CrLf[1] := 13;
        CrLf[2] := 10;
        CharTxt := 9;


        //Loan Alert
        MailBodyTxt := '';
        MailBodyTxt += '<span style="padding-right:3em">';
        MailBodyTxt += 'Loan No.';
        MailBodyTxt += '</span>';
        MailBodyTxt += '<span style="padding-right:3em">';
        MailBodyTxt += FORMAT(CharTxt) + 'Import Job No.';
        MailBodyTxt += '</span>';
        MailBodyTxt += '<span style="padding-right:4em">';
        MailBodyTxt += FORMAT(CharTxt) + 'Value';
        MailBodyTxt += '</span>';
        MailBodyTxt += '<span style="padding-right:3em">';
        MailBodyTxt += FORMAT(CharTxt) + 'Loan Granted Date';
        MailBodyTxt += '</span>';
        MailBodyTxt += '<span style="padding-right:3em">';
        MailBodyTxt += FORMAT(CharTxt) + 'Maturity Date';
        MailBodyTxt += '</span>';
        MailBodyTxt += FORMAT(CrLf);

        ShipGuarantee.RESET;
        ShipGuarantee.SETFILTER("Shipping Guarantee Type", '%1', LoanType);
        ShipGuarantee.SETFILTER(Status, '%1', ShipGuarantee.Status::Released);
        ShipGuarantee.SETFILTER("Maturity Date", '<%1', WORKDATE + 7);
        IF ShipGuarantee.FINDSET THEN BEGIN
            REPEAT
                MailBodyTxt += '<span style="padding-right:8em">';
                MailBodyTxt += PADSTR(ShipGuarantee."No.", 30);
                MailBodyTxt += '</span>';
                MailBodyTxt += '<span style="padding-right:8em">';
                MailBodyTxt += PADSTR(ShipGuarantee."Import Job No.", 15);
                MailBodyTxt += '</span>';
                MailBodyTxt += '<span style="padding-right:3em">';
                MailBodyTxt += PADSTR(FORMAT(ShipGuarantee."Value(LCY)"), 15);
                MailBodyTxt += '</span>';
                MailBodyTxt += '<span style="padding-right:5em">';
                MailBodyTxt += PADSTR(FORMAT(ShipGuarantee."Deposit Date"), 15);
                MailBodyTxt += '</span>';
                MailBodyTxt += '<span style="padding-right:5em">';
                MailBodyTxt += PADSTR(FORMAT(ShipGuarantee."Maturity Date"), 15);
                MailBodyTxt += '</span>';
                MailBodyTxt += FORMAT(CrLf);
            UNTIL ShipGuarantee.NEXT = 0;
            CASE LoanType OF
                2:
                    BEGIN
                        subjectTxt := 'STL Maturity Alert';
                        UserSetup.SETFILTER(UserSetup."Short Term Laon Notification", '%1', TRUE);
                        IF UserSetup.FINDSET THEN
                            REPEAT
                                NotifyUserID := UserSetup."User ID";
                            // SendMail(subjectTxt, Mail.FormatTextForHtml(MailBodyTxt));
                            UNTIL UserSetup.NEXT = 0;
                    END;
                3:
                    BEGIN
                        subjectTxt := 'Import Loan Maturity Alert';
                        UserSetup.SETFILTER(UserSetup."Import Loan Notification", '%1', TRUE);
                        IF UserSetup.FINDSET THEN
                            REPEAT
                                NotifyUserID := UserSetup."User ID";
                            // SendMail(subjectTxt, Mail.FormatTextForHtml(MailBodyTxt));
                            UNTIL UserSetup.NEXT = 0;
                    END;
            END;
        END;
    end;

    procedure SendSalesOrderAprReqMail(ClientAppEntry: Record "Client Approval Entry")
    var
        MailBodyTxt: Text[1024];
        CrLf: Text[2];
        CharTxt: Char;
        Mail: Codeunit Mail;
    begin
        CrLf[1] := 13;
        CrLf[2] := 10;
        CharTxt := 9;


        MailBodyTxt += 'No. : ';
        MailBodyTxt += ClientAppEntry."No.";
        MailBodyTxt += '     Customer : ';
        MailBodyTxt += ClientAppEntry."Sell-to Customer Name";
        MailBodyTxt += '     Amount : ';
        MailBodyTxt += FORMAT(ClientAppEntry.Amount);



        NotifyUserID := ClientAppEntry."Approved ID";
        // SendMail('Sales Order Approval Request Alert', Mail.FormatTextForHtml(MailBodyTxt));
    end;

    local procedure SendSalesOrderAprMail(ClientAppEntry: Record "Client Approval Entry")
    var
        MailBodyTxt: Text[1024];
        CrLf: Text[2];
        CharTxt: Char;
        Mail: Codeunit Mail;
    begin
        CrLf[1] := 13;
        CrLf[2] := 10;
        CharTxt := 9;


        MailBodyTxt += 'No. : ';
        MailBodyTxt += ClientAppEntry."No.";
        MailBodyTxt += '     Customer : ';
        MailBodyTxt += ClientAppEntry."Sell-to Customer Name";
        MailBodyTxt += '     Amount : ';
        MailBodyTxt += FORMAT(ClientAppEntry.Amount);
        MailBodyTxt += '     Amount : ';
        MailBodyTxt += FORMAT(ClientAppEntry.Amount);




        NotifyUserID := ClientAppEntry."Approved ID";
        // SendMail('Sales Order Approval Request Alert', Mail.FormatTextForHtml(MailBodyTxt));
    end;
}

