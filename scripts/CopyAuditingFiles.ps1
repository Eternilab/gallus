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

# This file copies all necessary files for the final Gallus Auditing Report in the target directory.

. .\Variables.ps1

#If destination folder doesn't exist
if (!(Test-Path $TargetPath -PathType Container)) {
    #Create destination folder
    New-Item -Path $TargetPath -ItemType Directory -Force
}

foreach (
$FileToCopy in $CopyFilesList)
{
    $SourceFile = $SourcePath + $FileToCopy
    $TargetFile = $TargetPath + $FileToCopy
    Copy-Item -Path $SourceFile -Destination $TargetFile
    echo "Copied $($SourceFile) to $($TargetFile)"
}
