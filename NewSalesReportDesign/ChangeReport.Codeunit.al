codeunit 50103 "Replace Reports"

{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]

    local procedure OnAfterSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Standard Sales - Invoice" then
            NewReportId := Report::SalesInvoiceTest;
    end;
}