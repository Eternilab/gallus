# 1
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider "MDTProvider" -Root "$PWD\DSGallus" -Description "Gallus MDT Deployment Share" -Verbose | add-MDTPersistentDrive -Verbose
# 2
New-Item -Path "DS001:\Operating Systems" -Enable "True" -Name "Win11" -Comments "" -ItemType "folder" -Verbose
# 3
Import-MDTOperatingSystem -Path "DS001:\Operating Systems\Win11" -SourcePath $PWD\Win11x64_EntN_en-US_22H2 -DestinationFolder "Win11x64_EntN_en-US_22H2" -Verbose
Rename-Item "DS001:\Operating Systems\Win11\Windows 11 Enterprise N in Win11x64_EntN_en-US_22H2 install.wim" "Win11x64_EntN_en-US_22H2 install.wim"
# 4
New-item -Path "DS001:\Out-of-Box Drivers" -Enable "True" -Name "Network" -Comments "" -ItemType "folder" -Verbose
# 5
Import-MDTDriver -Path "DS001:\Out-of-Box Drivers\Network" -SourcePath "$PWD\drivers\Network" -Verbose
# 6
New-item -Path "DS001:\Out-of-Box Drivers" -Enable "True" -Name "Storage" -Comments "" -ItemType "folder" -Verbose
# 7
Import-MDTDriver -Path "DS001:\Out-of-Box Drivers\Storage" -SourcePath "$PWD\drivers\Storage" -Verbose
# 8
Copy-Item -Path $PWD\scripts\* -Destination $PWD\DSGallus\Scripts\ -Verbose
Copy-Item -Path $PWD\hkdl\* -Destination $PWD\DSGallus\Scripts\ -Verbose
# 9
New-item -Path "DS001:\Task Sequences" -Enable "True" -Name "Gallus" -Comments "" -ItemType "folder" -Verbose
# 10
Import-MDTTaskSequence -Path "DS001:\Task Sequences\Gallus" -Name "Gallus Defaut Task Sequence" -Template "$PWD\conf\Gallus_ts.xml" -Comments "" -ID "GALLUS" -Version "1.0" -OperatingSystemPath "DS001:\Operating Systems\Win11\Win11x64_EntN_en-US_22H2 install.wim" -FullName "Utilisateur Windows" -OrgName "Organization" -HomePage "about:blank" -AdminPassword "local" -Verbose
# 11
New-Item -Path "DS001:\Selection Profiles" -Enable "True" -Name "gallus_winPE" -Comments "" -Definition "<SelectionProfile><Include path=`"Operating Systems`" /><Include path=`"Out-of-Box Drivers\Storage`" /><Include path=`"Task Sequences\Gallus`" /></SelectionProfile>" -ReadOnly "False" -Verbose
# 12
New-Item -Path "DS001:\Selection Profiles" -Enable "True" -Name "gallus_win11" -Comments "" -Definition "<SelectionProfile><Include path=`"Applications`" /><Include path=`"Operating Systems`" /><Include path=`"Out-of-Box Drivers`" /><Include path=`"Packages`" /><Include path=`"Task Sequences`" /></SelectionProfile>" -ReadOnly "False" -Verbose
# 13
New-Item -Path "$PWD\GMedia\Content\Deploy" -ItemType directory -Verbose
New-Item -Path "DS001:\Media" -Enable "True" -Name "GALLUSMEDIA" -Comments "" -Root "$PWD\GMedia" -SelectionProfile "gallus_win11" -SupportX86 "False" -SupportX64 "True" -GenerateISO "True" -ISOName "LiteTouchMedia.iso" -Verbose
New-PSDrive -Name "GALLUSMEDIA" -PSProvider "MDTProvider" -Root "$PWD\GMedia\Content\Deploy" -Description "Embedded media deployment share" -Force -Verbose
# 14
Set-ItemProperty -Path "DS001:\" -Name SupportX86 -Value False -Verbose
Set-ItemProperty -Path "GALLUSMEDIA:\" -Name SupportX86 -Value False -Verbose
# 15
Set-ItemProperty -Path "DS001:\" -Name Boot.x64.SelectionProfile -Value "gallus_winPE" -Verbose
Set-ItemProperty -Path "GALLUSMEDIA:\" -Name Boot.x64.SelectionProfile -Value "gallus_winPE" -Verbose
# 16
Copy-Item -Path $PWD\conf\Bootstrap.ini -Destination $PWD\DSGallus\Control\Bootstrap.ini -Verbose
Copy-Item -Path $PWD\conf\Bootstrap.ini -Destination $PWD\GMedia\Content\Deploy\Control\Bootstrap.ini -Verbose
Copy-Item -Path $PWD\conf\CustomSettings.ini -Destination $PWD\DSGallus\Control\CustomSettings.ini -Verbose
Copy-Item -Path $PWD\conf\CustomSettings.ini -Destination $PWD\GMedia\Content\Deploy\Control\CustomSettings.ini -Verbose
# 17
Update-MDTDeploymentShare -Path "DS001:" -Verbose
# 18
Update-MDTMedia -Path "DS001:\Media\GALLUSMEDIA" -Verbose
