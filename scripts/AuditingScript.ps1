#----------------------------------------------------------------------------
#    Copyright (C) 2024 Eternilab <support@eternilab.com>
#
#    Author: Dionys Colson <dionys.colson@eternilab.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#----------------------------------------------------------------------------

# This file invokes Hardening Kitty and performs an Audit on the system.

. .\Variables.ps1

Import-Module $HKModule

# Executing HardeningKitty

Invoke-HardeningKitty -Mode Audit -Log $HKLogOutputFile -Report $HKCsvOutputFile -FileFindingList $findinglist

# Generating the HTML report file

$ReportData = Import-CSV $HKCsvOutputFile

$ReportData | ConvertTo-Html -CSSUri $CssFile -Title $ReportHtmlTitle -PreContent $ReportHeader -PostContent $HtmlFooter -Charset $Charset | Out-File -Encoding utf8 $ReportHtmlOutputFile

# Customizing EDGE to display hardening results
New-Item -Path HKLM:\Software\Policies\Microsoft -Name Edge
# Removing EDGE First Run Experience
New-ItemProperty HKLM:\Software\Policies\Microsoft\Edge -Type DWord -Name "HideFirstRunExperience" -Value "1"
# Disable Translate pop-up
New-ItemProperty HKLM:\Software\Policies\Microsoft\Edge -Type DWord -Name "TranslateEnabled" -Value "0"

# Opening the HTML file in the default browser
Invoke-Item $ReportHtmlOutputFile
