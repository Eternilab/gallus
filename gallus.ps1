param(
	[switch]$init,
	[switch]$advancedDownloadAll,
	[switch]$advancedDownloadTools,
	[switch]$advancedDownloadWinImage,
	[switch]$advancedDownloadHK,
	[switch]$advancedSetupTools,
	[switch]$advancedExtractWinImage,
	[switch]$advancedImportDriver,
	[switch]$make,
	[switch]$advancedCleanupMDT,
	[switch]$advancedRunMDT,
	[switch]$flash,
	# [switch]$clean,
	# [switch]$update,
	# [switch]$makeupdated,
	[switch]$full  
	)
	

#Definition des Fonctions--------------------------------------------------------------------------------------------------------------------------------------------------------

#Affichage de l'aide
function aide {
	write-host "	
Parametres de base :
	
-init				= Mise en place des dependances necessaires au fonctionnement de Gallus
-make 				= Construit les fichiers d'installation et produit une ISO demarrable
-flash 				= Produit un media d'installation USB demarrable (UEFI uniquement) a partir des fichiers d'installation
-full				= Execute l'ensemble des etapes de Gallus de maniere nominale avec les options par defaut. Equivaut a appeler successivement gallus.ps1 trois fois avec, dans l’ordre, les parametres -init, -make et -flash
		
Parametres avancees :
		
-advancedDownloadTools		= Telecharge les installateurs des outils ADK et MDT sur le site de Microsoft
-advancedSetupTools		= Installe les outils Microsoft ADK et MDT en mode silencieux
-advancedDownloadWinImage	= Telecharge l’image (format ESD) de l’installateur officiel de Windows 11 depuis les serveurs Microsoft
-advancedExtractWinImage	= Extrait du format ESD l’image Windows et WinPE au format WIM
-advancedImportDriver		= Récupère les pilotes supplémentaires depuis les dossiers ..\drivers\Storage et ..\drivers\Network
-advancedDownloadHK		= Telecharge l’outil de durcissement HardeningKitty et le fichier de durcissement machine CIS correspondant a la version de l’image Windows
-advancedCleanupMDT		= Supprime les fichiers residuels d'une potentielle execution precedente de MDT 
-advancedRunMDT			= Execution de MDT avec les parametres et les composants de Gallus pour construire les fichiers d’installation. Produit egalement une ISO demarrable
-advancedDownloadAll		= Telecharge l’ensemble des composants necessaires à l’execution de Gallus. Equivaut a appeler successivement gallus.ps1 trois fois avec, dans l’ordre, les parametres -advancedDownloadTools, -advancedDownloadWinImage, -advancedDownloadHK
	"
}
# 1----------------------------------------------------------------------------------------------------------------------------------------------------------------
function download_tools{
	Write-Host -ForegroundColor Green "1 - Telechargement des outils Microsoft necessaires (ADK et MDT)"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\toolsdl -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\toolsdl
# Disable progress bar to speedup download
$ProgressPreference = 'SilentlyContinue'
# Download ADK
Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=2196127 -OutFile $PWD\toolsdl\adksetup.exe
# Download ADK PE
Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=2196224 -OutFile $PWD\toolsdl\adkwinpesetup.exe
# Download MDT
Invoke-WebRequest -Uri https://download.microsoft.com/download/3/3/9/339BE62D-B4B8-4956-B58D-73C4685FC492/MicrosoftDeploymentToolkit_x64.msi -OutFile $PWD\toolsdl\mdt.msi
# Re-enable progress bar
$ProgressPreference = 'Continue'
}
# 2---------------------------------------------------------------------------------------------------------------------------------------------------------------
function setup_tools {
	Write-Host -ForegroundColor Green "2 - Installation des outils Microsoft (ADK et MDT)"
# Install ADK
Start-Process -Wait -FilePath $PWD\toolsdl\adksetup.exe -ArgumentList "/features OptionId.DeploymentTools OptionId.ICDConfigurationDesigner /quiet /ceip off"
Write-Host -ForegroundColor Green "2.1 - Windows ADK a ete installe"
# Install ADK WinPE
Start-Process -Wait -FilePath $PWD\toolsdl\adkwinpesetup.exe -ArgumentList "/features OptionId.WindowsPreinstallationEnvironment /quiet /ceip off"
Write-Host -ForegroundColor Green "2.2 - Windows ADP WinPE a ete installe"
# Install MDT
Start-Process -Wait -FilePath $PWD\toolsdl\mdt.msi -ArgumentList "/quiet"
Write-Host -ForegroundColor Green "2.3 - MDT a ete installe"
}
# 3---------------------------------------------------------------------------------------------------------------------------------------------------------------
function download_windows_image {
	Write-Host -ForegroundColor Green "3 - Telechargement de l'image Windows 11 x64 22H2 officielle"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\windl -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\windl
# Disable progress bar to speedup download
$ProgressPreference = 'SilentlyContinue'
#Download Windows11 VOL esd | TODO should be downloading CAB to products.xml first and then looking for correct URL in it (see MediaCreationTool.bat on github line 153)
Invoke-WebRequest -Uri http://dl.delivery.mp.microsoft.com/filestreamingservice/files/92a06579-1d99-4fb8-b127-6fdcf50b1a7f/22621.1702.230505-1222.ni_release_svc_refresh_CLIENTBUSINESS_VOL_x64FRE_en-us.esd -OutFile $PWD\windl\win.esd
# Re-enable progress bar
$ProgressPreference = 'Continue'
}
# 4---------------------------------------------------------------------------------------------------------------------------------------------------------------
function extract_windows_image {
	Write-Host -ForegroundColor Green "4 - Extraction des elements necessaires depuis l'image officielle de Windows 11 x64 22H2"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\Win11x64_EntN_en-US_22H2 -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\Win11x64_EntN_en-US_22H2
# Extract setup files WIM
Write-Host -ForegroundColor Green "4.1 - Extraction des fichiers d'installation"
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:1 /DestinationImageFile:$PWD\windl\setup.wim /Compress:max /CheckIntegrity
# Create tmp directory
$null = New-Item -ItemType Directory -Path $PWD\windl\tmp
# Extract setup files from setup.wim
DISM /Quiet /Mount-Image /ImageFile:$PWD\windl\setup.wim /Index:1 /MountDir:$PWD\windl\tmp /readonly
Copy-Item -Recurse -Path $PWD\windl\tmp\* -Destination $PWD\Win11x64_EntN_en-US_22H2
DISM /Quiet /Unmount-Wim /MountDir:$PWD\windl\tmp /Discard
# Cleanup tmp directory and delete setup files WIM
Remove-Item -Recurse -Force -Path $PWD\windl\tmp
Remove-Item -Recurse -Force -Path $PWD\windl\setup.wim
# Extract WinPE image to boot.wim index 1
Write-Host -ForegroundColor Green "4.2 - Extraction des fichiers Windows PE"
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:2 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\boot.wim /Compress:max /CheckIntegrity
# Extract WinPE with Windows Setup to boot.wim index 2
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:3 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\boot.wim /Compress:max /CheckIntegrity
# Extract Windows 11 Enterprise N WIM
Write-Host -ForegroundColor Green "4.3 - Extraction de Windows 11 22H2 Enterprise N"
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:7 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\install.wim /Compress:max /CheckIntegrity
}
# 5---------------------------------------------------------------------------------------------------------------------------------------------------------------
function import_drivers {
	Write-Host -ForegroundColor Green "5 - Recuperation des drivers supplementaires"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\drivers -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\drivers
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\drivers\Storage
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\drivers\Network
# Download Storage Drivers
Copy-Item -Recurse -Path $PWD\..\drivers\Storage\* -Destination $PWD\drivers\Storage\ -ErrorAction SilentlyContinue
# Download Network Drivers
Copy-Item -Recurse -Path $PWD\..\drivers\Network\* -Destination $PWD\drivers\Network\ -ErrorAction SilentlyContinue
}
# 6---------------------------------------------------------------------------------------------------------------------------------------------------------------
function download_HardeningKitty {
	Write-Host -ForegroundColor Green "6 - Telechargement de l'outil HardeningKitty et de la liste de durcissement CIS Windows 11 Enterprise 22H2"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\hkdl -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\hkdl
#Download HardeningKitty psm and hardening list
Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psm1 -OutFile $PWD\hkdl\HardeningKitty.psm1
Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psd1 -OutFile $PWD\hkdl\HardeningKitty.psd1
Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/lists/finding_list_cis_microsoft_windows_11_enterprise_22h2_machine.csv -OutFile $PWD\hkdl\finding_list_cis_microsoft_windows_11_enterprise_22h2_machine.csv
}
# 7---------------------------------------------------------------------------------------------------------------------------------------------------------------
function cleanup_MDT {
	Write-Host -ForegroundColor Green "7 - Nettoyage d'eventuels anciens projets MDT"
# Remove PSDrives
Remove-PSDrive -Name "GALLUSMEDIA" -ErrorAction SilentlyContinue
Remove-PSDrive -Name "DS001" -ErrorAction SilentlyContinue
# Delete build directories DSGallus and GMedia
Remove-Item -Recurse -Force -Path "$PWD/GMedia" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -Path "$PWD/DSGallus" -ErrorAction SilentlyContinue
}
# 8---------------------------------------------------------------------------------------------------------------------------------------------------------------
function run_MDT {
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
}
# 9---------------------------------------------------------------------------------------------------------------------------------------------------------------
function build_USB_media {
	Write-Host -ForegroundColor Green "9 - Creation du media d'installation sur support de stockage amovible"
Write-Host ""
Write-Host -ForegroundColor Green "!!! Attention les fichiers presents sur le support vont etre supprimes !!!"
Write-Host -ForegroundColor Green "Si vous voulez interrompre le processus utilisez le raccourcis clavier Ctrl + C"
$DestDrive = Read-Host -Prompt 'Veuillez saisir la lettre correspondant a un volume du support de stockage amovible (ex: "F")'
write-host ""
if (-not (Get-Volume -ErrorAction SilentlyContinue $DestDrive)) {
  Write-Host -ForegroundColor Red "Le volume ${DestDrive}: n'exite pas"
  Write-Host -ForegroundColor Red "Pour relancer la creation du media d'installation sur support de stockage amovible,"
  Write-Host -ForegroundColor Red "veuillez relancer le script 9-gallus_build_USB_media.ps1"
  exit 1
}
Write-Host -ForegroundColor Green "9.1 - Formattage du support de stockage"
$disk=(Get-Partition -DriveLetter "$DestDrive").DiskId
Clear-Disk -Confirm:$False -RemoveData -RemoveOEM -Path $disk
if ((Get-Disk -Path $disk).Size -gt 34359738368) {
$null = New-Partition -DiskPath $disk -Size 34359738368 -DriveLetter "$DestDrive"
}
else {
$null = New-Partition -DiskPath $disk -UseMaximumSize -DriveLetter "$DestDrive"
}
$null = Format-Volume -DriveLetter $DestDrive -FileSystem FAT32
Write-Host -ForegroundColor Green "9.2 - Generation du media amovible d'installation sur ${DestDrive}:"
ROBOCOPY "GMedia\Content" "${DestDrive}:" /nfl /ndl /njh /njs /nc /ns /np /s /max:3800000000
# ROBOCOPY ajoute un saut de ligne à la sortie standard
DISM /Quiet /Split-Image /ImageFile:"GMedia\Content\Deploy\Operating Systems\Win11x64_EntN_en-US_22H2\sources\install.wim" /SWMFile:"${DestDrive}:\Deploy\Operating Systems\Win11x64_EntN_en-US_22H2\sources\install.swm" /FileSize:3800
((Get-Content -Path "${DestDrive}:\Deploy\Control\OperatingSystems.xml") -replace 'install.wim','install.swm') | Set-Content -Path "${DestDrive}:\Deploy\Control\OperatingSystems.xml"
((Get-Content -Path "${DestDrive}:\Deploy\Control\GALLUS\Unattend.xml") -replace 'install.wim','install.swm') | Set-Content -Path "${DestDrive}:\Deploy\Control\GALLUS\Unattend.xml"
Write-Host -ForegroundColor Green "Le media d'installation ${DestDrive}: est pret."
write-host -foregroundcolor green "Il peut etre utilise pour installer Windows 11 Enterprise N 22h2 sur un machine x64 uefi sans besoin de connexion internet"
write-host -foregroundcolor green "Le systeme d'exploitation sera durcis (securise) automatiquement au premier demarrage"
}


#Appels des fonctions-----------------------------------------------------------------------------------------------------------------------

#Limitation du nombre de paramètres à 1
if ($PSBoundParameters.Count -gt 1) {Write-Host -ForegroundColor red "Vous ne pouvez utiliser qu'un seul parametre a la fois " ; &aide ; exit 1}

#Paramètres de bases
elseif ($init)					{ &download_tools; &setup_tools; &download_windows_image ; &extract_windows_image ; &import_drivers; &download_HardeningKitty }
elseif ($make)					{ &cleanup_MDT; &run_MDT }
elseif ($flash)					{ &build_USB_media }

#Equivaut à l'appel successif avec les paramètres : -init ; -flash ; -build 
elseif ($full)					{ &download_tools; &setup_tools ; &download_windows_image ; &extract_windows_image; &import_drivers ; &download_HardeningKitty ; &cleanup_MDT ; &run_MDT ; &build_USB_media }

#Paramètres avancés
elseif ($advancedDownloadTools) 		{ &download_tools }
elseif ($advancedDownloadWinImage) 		{ &download_windows_image }
elseif ($advancedDownloadHK)			{ &download_HardeningKitty }
elseif ($advancedDownloadAll) 			{ &download_tools ; &download_windows_image ; &download_HardeningKitty }
elseif ($advancedImportDriver) 			{ &import_drivers }
elseif ($advancedSetupTools) 			{ &setup_tools }
elseif ($advancedExtractWinImage) 		{ &extract_windows_image }
elseif ($advancedCleanupMDT) 			{ &cleanup_MDT }
elseif ($advancedRunMDT) 			{ &build_USB_media }

#Affichage des paramètres disponibles si aucun n'est spécifié
else 										{ &aide }
