Write-Host -ForegroundColor Green "9 - Creation du media d'installation sur support de stockage amovible"
Write-Host -ForegroundColor Green "!!! Attention les fichiers presents sur le support vont etre supprimes !!!"
Write-Host -ForegroundColor Green "Si vous voulez interrompre le processus utilisez le raccourcis clavier Ctrl + C"
$DestDrive = Read-Host -Prompt 'Veuillez saisir la lettre correspondant a un volume du support de stockage amovible (ex: "F")'
if (-not (Get-Volume -ErrorAction SilentlyContinue $DestDrive)) {
  Write-Host -ForegroundColor Red "Le volume ${DestDrive}: n'exite pas"
  Write-Host -ForegroundColor Red "Pour relancer la creation du media d'installation sur support de stockage amovible,"
  Write-Host -ForegroundColor Red "veuillez relancer le script 9-gallus_build_USB_media.ps1"
  exit 1
}
Write-Host -ForegroundColor Green "9.1 - Formattage du support de stockage"
$disk=(Get-Partition -DriveLetter "$DestDrive").DiskId
Clear-Disk -Confirm:$False -RemoveData -RemoveOEM -Path $disk
$null = New-Partition -DiskPath $disk -UseMaximumSize -DriveLetter "$DestDrive"
$null = Format-Volume -DriveLetter $DestDrive -FileSystem FAT32
Write-Host -ForegroundColor Green "9.2 - Generation du media amovible d'installation sur ${DestDrive}:"
ROBOCOPY "GMedia\Content" "${DestDrive}:" /nfl /ndl /njh /njs /nc /ns /np /s /max:3800000000
DISM /Quiet /Split-Image /ImageFile:"GMedia\Content\Deploy\Operating Systems\Win11x64_EntN_en-US_22H2\sources\install.wim" /SWMFile:"${DestDrive}:\Deploy\Operating Systems\Win11x64_EntN_en-US_22H2\sources\install.swm" /FileSize:3800
((Get-Content -Path "${DestDrive}:\Deploy\Control\OperatingSystems.xml") -replace 'install.wim','install.swm') | Set-Content -Path "${DestDrive}:\Deploy\Control\OperatingSystems.xml"
((Get-Content -Path "${DestDrive}:\Deploy\Control\GALLUS\Unattend.xml") -replace 'install.wim','install.swm') | Set-Content -Path "${DestDrive}:\Deploy\Control\GALLUS\Unattend.xml"
Write-Host ""
Write-Host -ForegroundColor Green "Le media d'installation ${DestDrive}: est pret."
write-host ""
write-host -foregroundcolor green "Il peut etre utilise pour installer Windows 11 Enterprise N 22h2 sur un machine x64 uefi sans besoin de connexion internet"
write-host -foregroundcolor green "Le systeme d'exploitation sera durcis (securise) automatiquement au premier demarrage"
