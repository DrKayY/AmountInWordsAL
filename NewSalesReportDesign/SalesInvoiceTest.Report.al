report 50100 SalesInvoiceTest
{
    Caption = 'Sales Invoice Test';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales Invoice Test.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name) { }
            column(Address; Address) { }
            column(Address_2; "Address 2") { }
            column(City; City) { }
            column(Bank_Account_No_; "Bank Account No.") { }
            column(Bank_Name; "Bank Name") { }
            column(Bank_Branch_No_; "Bank Branch No.") { }
            column(E_Mail; "E-Mail")
            {
                IncludeCaption = true;
            }
            column(Picture; Picture) { }
            column(Phone_No_; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {
                IncludeCaption = true;
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                RequestFilterFields = "No.";

                column(toWordsResult; toWordsResult.ChangeToWords(totalAmountIncludingVAT)) { }
                column(totalAmountIncludingVAT; totalAmountIncludingVAT) { }
                column(No_; "No.")
                {
                    IncludeCaption = true;
                }
                column(Bill_to_Name; "Bill-to Name") { }
                column(Bill_to_Name_2; "Bill-to Name 2") { }
                column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
                column(Bill_to_Address; "Bill-to Address") { }
                column(Bill_to_City; "Bill-to City") { }
                column(Order_Date; "Order Date") { }
                column(Salesperson_Code; "Salesperson Code") { }
                column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
                column(Sell_to_Address; "Sell-to Address") { }
                column(Sell_to_City; "Sell-to City") { }
                column(Ship_to_Address; "Ship-to Address") { }
                column(Ship_to_City; "Ship-to City") { }
                column(Shipment_Date; "Shipment Date") { }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    column(Description; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(Quantity; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(Unit_of_Measure; "Unit of Measure") { }
                    column(Unit_Price; "Unit Price")
                    {
                        IncludeCaption = true;
                    }
                    column(VAT__; "VAT %")
                    {
                        IncludeCaption = true;
                    }
                    column(Line_Discount__; "Line Discount %") { }
                    column(Amount; Amount)
                    {
                        IncludeCaption = true;
                    }
                    column(Amount_Including_VAT; "Amount Including VAT")
                    {
                        IncludeCaption = true;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    salesLine: Record "Sales Invoice Line";
                begin
                    salesLine.Reset();
                    salesLine.SetRange(salesLine."Document No.", "No.");

                    if salesLine.FindSet() then begin
                        salesLine.CalcSums("Amount Including VAT");
                        totalAmountIncludingVAT := salesLine."Amount Including VAT";
                    end;
                end;
            }
        }
    }

    labels
    {
        TIN = 'TIN';
        InvoiceAddress = 'Invoice Address';
        VesselName = 'Vessel Name';
        VATAmount = 'VAT Amount';
        Location = 'Location';
        VesselDate = 'Date';
        AmountInWords = 'Amount In Words:';
        PreparedBy = 'Prepared By';
        ApprovedBy = 'Approved By';
        CustomerSign = 'Customer Sign';
        Total = 'Total';
        Website = 'Website';
        BankBranch = 'Bank Branch';
        BankAccNo = 'Bank Account No';
        BankName = 'Bank Name';
    }

    var
        toWordsResult: Codeunit AmountInWords;
        totalAmountIncludingVAT: Decimal;

}