param(
     [Parameter()]
     [string]$DestDrive
 )
robocopy "GMedia\Content" "$DestDrive" /s /max:3800000000
DISM /Split-Image /ImageFile:"GMedia\Content\Deploy\Operating Systems\Win11x64_EntN_en-US_22H2\sources\install.wim" /SWMFile:"$DestDrive\Deploy\Operating Systems\Win11x64_EntN_en-US_22H2\sources\install.swm" /FileSize:3800
((Get-Content -Path "$DestDrive\Deploy\Control\OperatingSystems.xml") -replace 'install.wim','install.swm') | Set-Content -Path "$DestDrive\Deploy\Control\OperatingSystems.xml" -Verbose
((Get-Content -Path "$DestDrive\Deploy\Control\GALLUS\Unattend.xml") -replace 'install.wim','install.swm') | Set-Content -Path "$DestDrive\Deploy\Control\GALLUS\Unattend.xml" -Verbose
