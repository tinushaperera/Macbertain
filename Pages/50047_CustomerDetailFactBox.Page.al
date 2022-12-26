page 50047 "Customer Detail FactBox"
{
    Caption = 'Customer Details';
    PageType = CardPart;
    SourceTable = "Client Approval Entry";

    layout
    {
        area(content)
        {
            field("No."; rec."No.")
            {
                ApplicationArea = All;
                Caption = 'Customer No.';

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field(CusName; CusName)
            {
                ApplicationArea = All;
                Caption = 'Name';
            }
            field("Credit Limit (LCY)"; rec."Credit Limit (LCY)")
            {
                ApplicationArea = All;
                StyleExpr = StyleTxt;
                Visible = false;
            }
            field(SalesAmt; SalesAmt)
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                CaptionClass = FORMAT(STRSUBSTNO(Text000, FORMAT(CurrencyCode)));
            }
            field(SalesAmtLCY; SalesAmtLCY)
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                Caption = 'Sales Order Amount (LCY)';
            }
            field(TotBalAmountLCY; TotBalAmountLCY)
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                Caption = 'Balance (LCY)';
            }
            field(CreditLimtLCY; CreditLimtLCY)
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                Caption = 'Credit Limit (LCY)';
                Style = Ambiguous;
                StyleExpr = TRUE;
            }
            field(AvailBalceLCY; AvailBalceLCY)
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                Caption = 'Available Balance (LCY)';
            }
            field(OutStanCreditBalLCY; OutStanCreditBalLCY)
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                Caption = 'Overdue 90days (LCY)';
                Style = Unfavorable;
                StyleExpr = TRUE;
            }
            field(OutStanCreditBalLCY120; OutStanCreditBalLCY120)
            {
                ApplicationArea = All;
                Caption = 'Overdue 120days (LCY)';
                Style = Unfavorable;
                StyleExpr = TRUE;
            }
            field(PDAmount; PDAmount)
            {
                ApplicationArea = All;
                Caption = 'PD-Cheque Amount';
                Style = Favorable;
                StyleExpr = TRUE;

                trigger OnDrillDown()
                var
                    GenJnlRec: Record "Gen. Journal Line";
                begin
                    PAGE.RUN(50040, PDGenJurLineRec);
                end;
            }
            field(NoOfCheque; NoOfCheque)
            {
                ApplicationArea = All;
                Caption = 'No of Cheque Return';

                trigger OnLookup(var Text: Text): Boolean
                var
                    CusLedEntry: Record "Cust. Ledger Entry";
                begin
                    CusLedEntry.RESET;
                    CusLedEntry.SETCURRENTKEY("Document Type", "Customer No.",
                          "Posting Date", "Currency Code", Open);
                    CusLedEntry.SETRANGE("Document Type", CusLedEntry."Document Type"::Refund);
                    CusLedEntry.SETRANGE("Customer No.", rec."Sell-to Customer No.");
                    CusLedEntry.SETCURRENTKEY("Source Code", Reversed);
                    CusLedEntry.SETRANGE("Source Code", 'CHEQUERTN');
                    CusLedEntry.SETRANGE(Reversed, FALSE);
                    IF PAGE.RUNMODAL(0, CusLedEntry) = ACTION::LookupOK THEN;
                end;
            }
            field(BankGuaAmt; BankGuaAmt)
            {
                ApplicationArea = All;
                Caption = 'Bank Guarentee Amount';
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                Image = "Action";
                action("Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address';
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //StyleTxt := SetStyle;
        InitializeDetails;
    end;

    var
        StyleTxt: Text;
        CusNo: Code[20];
        CusName: Text[50];
        TotBalAmountLCY: Decimal;
        CreditLimtLCY: Decimal;
        AvailBalceLCY: Decimal;
        DueAmtLCY: Decimal;
        SalesAmt: Decimal;
        SalesAmtLCY: Decimal;
        OutStanCreditBalLCY: Decimal;
        OutStanCreditBalLCY120: Decimal;
        CurrencyCode: Code[10];
        PayTemCode: Code[10];
        PDAmount: Decimal;
        NoOfCheque: Integer;
        DisCouApp: Boolean;
        FreeQtyApp: Boolean;
        OverdueNoChq: Boolean;
        Text000: Label 'Sales Order Amount (%1)';
        PDGenJurLineRec: Record "Gen. Journal Line";
        BankGuaAmt: Decimal;

    local procedure ShowDetails()
    begin
        PAGE.RUN(PAGE::"Customer Card", Rec);
    end;

    local procedure InitializeDetails()
    var
        SalesHed: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Cus: Record Customer;
        GenLedSetup: Record "General Ledger Setup";
        CusLedEntry: Record "Cust. Ledger Entry";
        GenJurTemp: Record "Gen. Journal Template";
        GenJurLine: Record "Gen. Journal Line";
        ChkCreditLimit: Page "Check Credit Limit";
        FilterDate: Date;
        FilterDate120: Date;
        TempTextFilter: Text[150];
    begin
        CusNo := '';
        CusName := '';
        TotBalAmountLCY := 0;
        CreditLimtLCY := 0;
        AvailBalceLCY := 0;
        SalesAmt := 0;
        SalesAmtLCY := 0;
        OutStanCreditBalLCY := 0;
        OutStanCreditBalLCY120 := 0;
        CurrencyCode := '';
        FilterDate := 0D;
        FilterDate120 := 0D;
        PDAmount := 0;
        BankGuaAmt := 0;

        NoOfCheque := 0;
        DisCouApp := FALSE;
        FreeQtyApp := FALSE;

        CASE rec."Table No." OF
            DATABASE::"Sales Header":
                BEGIN
                    IF rec.Type = rec.Type::Order THEN BEGIN
                        SalesHed.GET(rec.Type, rec."No.");
                        Cus.GET(SalesHed."Sell-to Customer No.");
                        Cus.CALCFIELDS("Bank Guarantee Amount");
                        BankGuaAmt := Cus."Bank Guarantee Amount";
                        CusNo := Cus."No.";
                        CusName := Cus.Name;
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", rec.Type);
                        SalesLine.SETRANGE("Document No.", rec."No.");
                        SalesLine.CALCSUMS("Amount Including VAT");
                        SalesAmt := SalesLine."Amount Including VAT";
                        IF SalesHed."Currency Code" = '' THEN BEGIN
                            GenLedSetup.GET;
                            CurrencyCode := GenLedSetup."LCY Code";
                            SalesAmtLCY := SalesAmt;
                        END
                        ELSE BEGIN
                            CurrencyCode := SalesHed."Currency Code";
                            IF SalesAmt / SalesHed."Currency Factor" <> 0 THEN
                                SalesAmtLCY := (SalesAmt / SalesHed."Currency Factor");
                        END;
                        ChkCreditLimit.SETRECORD(Cus);
                        ChkCreditLimit.CalcCreditLimitLCYModify(TotBalAmountLCY, CreditLimtLCY, DueAmtLCY, TODAY);
                        CLEAR(ChkCreditLimit);
                        AvailBalceLCY := (CreditLimtLCY - TotBalAmountLCY);
                        FilterDate := CALCDATE('<-90D>', WORKDATE);
                        FilterDate120 := CALCDATE('<-120D>', WORKDATE);

                        CusLedEntry.RESET;
                        CusLedEntry.SETCURRENTKEY("Document Type", "Customer No.",
                              "Posting Date", "Currency Code", Open);
                        CusLedEntry.SETRANGE("Document Type", CusLedEntry."Document Type"::Invoice);
                        CusLedEntry.SETRANGE("Customer No.", SalesHed."Sell-to Customer No.");
                        CusLedEntry.SETRANGE("Document Date", 0D, FilterDate);
                        CusLedEntry.SETRANGE(Open, TRUE);
                        IF CusLedEntry.FINDSET THEN
                            REPEAT
                                CusLedEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                OutStanCreditBalLCY := OutStanCreditBalLCY + CusLedEntry."Remaining Amt. (LCY)";
                                IF CusLedEntry."Document Date" <= FilterDate120 THEN
                                    OutStanCreditBalLCY120 := OutStanCreditBalLCY120 + CusLedEntry."Remaining Amt. (LCY)";
                            UNTIL CusLedEntry.NEXT = 0;

                        GenJurTemp.RESET;
                        GenJurTemp.SETRANGE(Type, GenJurTemp.Type::"PD Cheque");
                        IF GenJurTemp.FINDSET THEN
                            REPEAT
                                IF TempTextFilter = '' THEN
                                    TempTextFilter := GenJurTemp.Name
                                ELSE
                                    TempTextFilter := TempTextFilter + '|' + GenJurTemp.Name;
                            UNTIL GenJurTemp.NEXT = 0;
                        IF TempTextFilter = '' THEN
                            TempTextFilter := '-';
                        PDGenJurLineRec.RESET;
                        PDGenJurLineRec.SETFILTER("Journal Template Name", TempTextFilter);
                        PDGenJurLineRec.SETRANGE("Account Type", GenJurLine."Account Type"::Customer);
                        PDGenJurLineRec.SETRANGE("Account No.", SalesHed."Sell-to Customer No.");
                        PDGenJurLineRec.CALCSUMS("Amount (LCY)");
                        PDAmount := -PDGenJurLineRec."Amount (LCY)";

                        CusLedEntry.RESET;
                        CusLedEntry.SETCURRENTKEY("Document Type", "Customer No.",
                              "Posting Date", "Currency Code", Open);
                        CusLedEntry.SETRANGE("Document Type", CusLedEntry."Document Type"::Refund);
                        CusLedEntry.SETRANGE("Customer No.", SalesHed."Sell-to Customer No.");
                        CusLedEntry.SETCURRENTKEY("Source Code", Reversed);
                        CusLedEntry.SETRANGE("Source Code", 'CHEQUERTN');
                        CusLedEntry.SETRANGE(Reversed, FALSE);
                        NoOfCheque := CusLedEntry.COUNT;
                        //
                        IF rec."Discount Approval" THEN
                            DisCouApp := TRUE;
                        IF rec."Free Issue Approval" THEN
                            FreeQtyApp := TRUE;
                        OverdueNoChq := rec."Overdue No Cheques";  //< Chin 20160620 1306 01.03 >
                    END;
                END
        END;
    end;
}

