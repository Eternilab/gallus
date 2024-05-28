Write-Host -ForegroundColor Green "8 - Fabrication de l'installateur grace a MDT"
Write-Host -ForegroundColor Green "8.1 - Configuration de l'environnement de fabrication de l'installateur"
# 1
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
$null = New-PSDrive -Name "DS001" -PSProvider "MDTProvider" -Root "$PWD\DSGallus" -Description "Gallus MDT Deployment Share" | add-MDTPersistentDrive
# 2
$null = New-Item -Path "DS001:\Operating Systems" -Enable "True" -Name "Win11" -Comments "" -ItemType "folder"
# 3
Write-Host -ForegroundColor Green "8.2 - Import du systeme d'exploitation dans l'environnement de fabrication"
$null = Import-MDTOperatingSystem -Path "DS001:\Operating Systems\Win11" -SourcePath $PWD\Win11x64_EntN_en-US_22H2 -DestinationFolder "Win11x64_EntN_en-US_22H2"
Rename-Item "DS001:\Operating Systems\Win11\Windows 11 Enterprise N in Win11x64_EntN_en-US_22H2 install.wim" "Win11x64_EntN_en-US_22H2 install.wim"
# 4
Write-Host -ForegroundColor Green "8.3 - Import de drivers dans l'environnement de fabrication (Optionnel)"
$null = New-item -Path "DS001:\Out-of-Box Drivers" -Enable "True" -Name "Network" -Comments "" -ItemType "folder"
# 5
$null = Import-MDTDriver -Path "DS001:\Out-of-Box Drivers\Network" -SourcePath "$PWD\drivers\Network"
# 6
$null = New-item -Path "DS001:\Out-of-Box Drivers" -Enable "True" -Name "Storage" -Comments "" -ItemType "folder"
# 7
$null = Import-MDTDriver -Path "DS001:\Out-of-Box Drivers\Storage" -SourcePath "$PWD\drivers\Storage"
# 8
Copy-Item -Path $PWD\scripts\* -Destination $PWD\DSGallus\Scripts\
Copy-Item -Path $PWD\hkdl\* -Destination $PWD\DSGallus\Scripts\
# 9
$null = New-item -Path "DS001:\Task Sequences" -Enable "True" -Name "Gallus" -Comments "" -ItemType "folder"
# 10
Write-Host -ForegroundColor Green "8.4 - Import de la sequence de taches Gallus_ts.xml"
$null = Import-MDTTaskSequence -Path "DS001:\Task Sequences\Gallus" -Name "Gallus Defaut Task Sequence" -Template "$PWD\conf\Gallus_ts.xml" -Comments "" -ID "GALLUS" -Version "1.0" -OperatingSystemPath "DS001:\Operating Systems\Win11\Win11x64_EntN_en-US_22H2 install.wim" -FullName "Utilisateur Windows" -OrgName "Organization" -HomePage "about:blank" -AdminPassword "local"
# 11
Write-Host -ForegroundColor Green "8.5 - Configuration des parametres de l'installateur"
$null = New-Item -Path "DS001:\Selection Profiles" -Enable "True" -Name "gallus_winPE" -Comments "" -Definition "<SelectionProfile><Include path=`"Operating Systems`" /><Include path=`"Out-of-Box Drivers\Storage`" /><Include path=`"Task Sequences\Gallus`" /></SelectionProfile>" -ReadOnly "False"
# 12
$null = New-Item -Path "DS001:\Selection Profiles" -Enable "True" -Name "gallus_win11" -Comments "" -Definition "<SelectionProfile><Include path=`"Applications`" /><Include path=`"Operating Systems`" /><Include path=`"Out-of-Box Drivers`" /><Include path=`"Packages`" /><Include path=`"Task Sequences`" /></SelectionProfile>" -ReadOnly "False"
# 13
$null = New-Item -Path "$PWD\GMedia\Content\Deploy" -ItemType directory
$null = New-Item -Path "DS001:\Media" -Enable "True" -Name "GALLUSMEDIA" -Comments "" -Root "$PWD\GMedia" -SelectionProfile "gallus_win11" -SupportX86 "False" -SupportX64 "True" -GenerateISO "True" -ISOName "LiteTouchMedia.iso"
$null = New-PSDrive -Name "GALLUSMEDIA" -PSProvider "MDTProvider" -Root "$PWD\GMedia\Content\Deploy" -Description "Embedded media deployment share" -Force
# 14
Set-ItemProperty -Path "DS001:\" -Name SupportX86 -Value False
Set-ItemProperty -Path "GALLUSMEDIA:\" -Name SupportX86 -Value False
# 15
Set-ItemProperty -Path "DS001:\" -Name Boot.x64.SelectionProfile -Value "gallus_winPE"
Set-ItemProperty -Path "GALLUSMEDIA:\" -Name Boot.x64.SelectionProfile -Value "gallus_winPE"
# 16
Copy-Item -Path $PWD\conf\Bootstrap.ini -Destination $PWD\DSGallus\Control\Bootstrap.ini
Copy-Item -Path $PWD\conf\Bootstrap.ini -Destination $PWD\GMedia\Content\Deploy\Control\Bootstrap.ini
Copy-Item -Path $PWD\conf\CustomSettings.ini -Destination $PWD\DSGallus\Control\CustomSettings.ini
Copy-Item -Path $PWD\conf\CustomSettings.ini -Destination $PWD\GMedia\Content\Deploy\Control\CustomSettings.ini
# 17
Write-Host -ForegroundColor Green "8.6 - Generation de l'environnement de fabrication de l'installateur"
Update-MDTDeploymentShare -Path "DS001:"
# 18
Write-Host -ForegroundColor Green "8.7 - Generation du contenu du media d'installation et generation de l'ISO"
Update-MDTMedia -Path "DS001:\Media\GALLUSMEDIA"
Write-Host ""
Write-Host -ForegroundColor Green "Le media d'installation au format ISO est disponible ici : $PWD\GMedia\LiteTouch.iso"
write-host -foregroundcolor green "Il peut etre utilise pour installer Windows 11 Enterprise N 22h2 sur un machine x64 uefi sans besoin de connexion internet"
write-host -foregroundcolor green "Le systeme d'exploitation sera durcis (securise) automatiquement au premier demarrage"
write-host ""
