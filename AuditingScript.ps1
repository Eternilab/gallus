Import-Module ".\HardeningKitty.psm1"

$findinglist = ".\finding_list_cis_microsoft_windows_11_enterprise_22h2_machine.csv"

Invoke-HardeningKitty -Mode Audit -Log Auditreport.txt -Report AuditReport.csv -FileFindingList $($findinglist)

$ReportData = Import-CSV "AuditReport.csv"

$CssFile = "ReportStyle.css"
$JsFile = "ReportScript.js"
$OutputFile = "AuditReport.html"

$ReportHeader = "<div class='header'><div class='header-left'><h1>Gallus Audit Report</h1>`n<h5>Generated by <strong>Hardening Kitty</strong> on $(Get-Date)</h5></div><div class='header-right'><img src='Eternilab.png' width='512px' height='120px'></div></div><div class='tablecontainer'>"
$ReportFooter = "</div><script src=tsorter.min.js></script><script src=$($JsFile)></script>"

$ReportData | ConvertTo-Html -CSSUri $($CssFile) -Title "Hardening Kitty Audit report" -PreContent "$($ReportHeader)" -PostContent "$($ReportFooter)" | Out-File -Encoding utf8 $($OutputFile)