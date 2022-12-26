codeunit 50007 "Customization Management"
{
    [EventSubscriber(ObjectType::table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure updateGLEntry(var GLEntry: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        //RJ(+)
        GLEntry."Temp. Receipt No." := GenJournalLine."Temp. Receipt No.";
        GLEntry."Import Job No." := GenJournalLine."Import Job No.";
        GLEntry."Payee Name" := GenJournalLine."Payee Name";
        GLEntry.Narration := GenJournalLine.Narration;
        GLEntry."Unidentified Deposit No." := GenJournalLine."Unidentified Deposit No.";
        GLEntry."Unidentified Entry No." := GenJournalLine."Unidentified Entry No.";
        GLEntry."Employee No." := GenJournalLine."Employee No.";
        GLEntry."Expense Type" := GenJournalLine."Expense Type";
        GLEntry."Order Type" := GenJournalLine."Order Type";
        //RJ(-)
        //<Chin 20160712 1302
        GLEntry.Remarks := GenJournalLine.Remarks;
        GLEntry."Bank Code" := GenJournalLine."Bank Code";
        GLEntry."Branch Code" := GenJournalLine."Branch Code";
        //>
    end;

    [EventSubscriber(ObjectType::table, 21, 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure updateCusLedEntry(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //<Chin 201602161604
        CustLedgerEntry."Region Code" := GenJournalLine."Region Code";
        CustLedgerEntry."Sell-to Country/Region Code" := GenJournalLine."Sell-to Country/Region Code";
        CustLedgerEntry."Salesperson Code" := GenJournalLine."Salespers./Purch. Code";
        CustLedgerEntry."Territory Code" := GenJournalLine."Territory Code";
        CustLedgerEntry."Bank Code" := GenJournalLine."Bank Code";  //20160713 1541
        CustLedgerEntry."Branch Code" := GenJournalLine."Branch Code"; //20160713 1541
                                                                       //>
                                                                       //RJ(+)
        CustLedgerEntry."Bank Branch Name" := GenJournalLine."Bank Branch Name";
        CustLedgerEntry."Temp. Receipt No." := GenJournalLine."Temp. Receipt No.";
        CustLedgerEntry."Unidentified Deposit No." := GenJournalLine."Unidentified Deposit No.";
        CustLedgerEntry."Customer Block" := GenJournalLine."Customer Block";
        CustLedgerEntry."3rd Party Cheque" := GenJournalLine."3rd Party Cheque";
        CustLedgerEntry."Cheque Received Date" := GenJournalLine."Cheque Received Date";
        CustLedgerEntry."PD Receipt No." := GenJournalLine."PD Receipt No.";
        CustLedgerEntry.Narration := GenJournalLine.Narration;
        CustLedgerEntry."Unidentified Entry No." := GenJournalLine."Unidentified Entry No.";
        CustLedgerEntry.Remarks := GenJournalLine.Remarks;
        CustLedgerEntry."D/C No." := GenJournalLine."D/C No.";
        //RJ(-)
    end;

    [EventSubscriber(ObjectType::table, 25, 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure UpdateVendLed(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //RJ(+)
        VendorLedgerEntry."Import Job No." := GenJournalLine."Import Job No.";
        VendorLedgerEntry."Payee Name" := GenJournalLine."Payee Name";
        VendorLedgerEntry.Narration := GenJournalLine.Narration;
        VendorLedgerEntry.Remarks := GenJournalLine.Remarks;
        VendorLedgerEntry."Bank Code" := GenJournalLine."Bank Code";
        VendorLedgerEntry."Branch Code" := GenJournalLine."Branch Code";
        VendorLedgerEntry."Order Type" := GenJournalLine."Order Type";
        //RJ(-)
    end;

    // [EventSubscriber(ObjectType::table, 271, 'CopyFromGenJnlLine', '', true, true)]
    // local procedure UpdateVendLed(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    // begin
    //     //RJ(+)
    //     VendorLedgerEntry."Import Job No." := GenJournalLine."Import Job No.";
    //     VendorLedgerEntry."Payee Name" := GenJournalLine."Payee Name";
    //     VendorLedgerEntry.Narration := GenJournalLine.Narration;
    //     VendorLedgerEntry.Remarks := GenJournalLine.Remarks;
    //     VendorLedgerEntry."Bank Code" := GenJournalLine."Bank Code";
    //     VendorLedgerEntry."Branch Code" := GenJournalLine."Branch Code";
    //     VendorLedgerEntry."Order Type" := GenJournalLine."Order Type";
    //     //RJ(-)
    // end;

    [EventSubscriber(ObjectType::table, 5744, 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure UpdateShiHedd(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader.MRN := TransferHeader.MRN;
        TransferShipmentHeader."Approved By" := TransferHeader."Approved By";
        TransferShipmentHeader."Created User ID" := TransferHeader."Created User ID";
        TransferShipmentHeader."Date Time Created" := TransferHeader."Date Time Created";
        TransferShipmentHeader."Date Time Released" := TransferHeader."Date Time Released";
        TransferShipmentHeader."Status New" := TransferHeader."Status New";
    end;

    [EventSubscriber(ObjectType::table, 5746, 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure UpdateRecHedd(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader.MRN := TransferHeader.MRN;
        TransferReceiptHeader."Approved By" := TransferHeader."Approved By";
        TransferReceiptHeader."Created User ID" := TransferHeader."Created User ID";
        TransferReceiptHeader."Date Time Created" := TransferHeader."Date Time Created";
        TransferReceiptHeader."Date Time Released" := TransferHeader."Date Time Released";
        TransferReceiptHeader."Status New" := TransferHeader."Status New";
    end;
}