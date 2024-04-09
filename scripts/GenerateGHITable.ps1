#----------------------------------------------------------------------------
#    Copyright (C) 2024 Eternilab <support@eternilab.com>
#
#    Authors: Dionys Colson <dionys.colson@eternilab.com>,
#             Jérôme Maurin <jerome.maurin@eternilab.com>
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

# This file creates an html file containing a table from a csv file.

. .\Variables.ps1

# Generating the HTML report file

$CsvData = Import-CSV $GhiCsvFile

$CsvData | ConvertTo-Html -CSSUri $CssFile -Title $GhiHtmlTitle -PreContent $GhiHeader -PostContent $HtmlFooter | Out-File -Encoding utf8 $GhiHtmlOutputFile

# Opening the HTML file in the default browser
Invoke-Item $GhiHtmlOutputFile
