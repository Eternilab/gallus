﻿# <- ATTENTION ne pas supprimer !!!
# Les caractères invisible (BOM : Byte Order Mask) précédent ce commentaire,
# permettent de faire en sorte que PowerShell 5.1 supporte correctement les caractères accentués (en UTF-8) dans la suite du script.
#
# On choisi d'utiliser Write-Host pour la sortie en couleur,
# puisque depuis la version 5.x de Powershell (Win 10+), Write-Host est un wrapper autour de Write-Information :
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Scope='Function', Target='*')]
param(
	[switch]$init,
	[switch]$advancedDownloadAll,
	[switch]$advancedDownloadTools,
	[switch]$advancedDownloadWinImage,
	[switch]$advancedDownloadHK,
	[switch]$advancedSetupTools,
	[switch]$advancedExtractWinImage,
	[switch]$make,
	[switch]$advancedCleanupMDT,
	[switch]$advancedRunMDT,
	[switch]$flash,
	# [switch]$clean,
	# [switch]$update,
	# [switch]$makeupdated,
	[switch]$full
	)


#Définition des Fonctions--------------------------------------------------------------------------------------------------------------------------------------------------------

#Affichage de l'aide
function aide {
  Write-Host "
Paramètres de base :

-init				= Mise en place des dépendances nécessaires au fonctionnement de Gallus
-make 				= Construit les fichiers d'installation et produit une ISO démarrage
-flash 				= Produit un média d'installation USB démarrable (UEFI uniquement) à partir des fichiers d'installation
-full				= Exécute l'ensemble des étapes de Gallus de manière nominale avec les options par défaut. Équivaut à appeler successivement gallus.ps1 trois fois avec, dans l’ordre, les paramètres -init, -make et -flash

Paramètres avancées :

-advancedDownloadTools		= Télécharge les installateurs des outils ADK et MDT sur le site de Microsoft
-advancedSetupTools		= Installe les outils Microsoft ADK et MDT en mode silencieux
-advancedDownloadWinImage	= Télécharge l’image (format ESD) de l’installateur officiel de Windows 11 depuis les serveurs Microsoft
-advancedExtractWinImage	= Extrait du format ESD l’image Windows et WinPE au format WIM
-advancedDownloadHK		= Télécharge l’outil de durcissement HardeningKitty et le fichier de durcissement machine CIS correspondant à la version de l’image Windows
-advancedCleanupMDT		= Supprime les fichiers résiduels d'une potentielle exécution précédente de MDT
-advancedRunMDT			= Exécution de MDT avec les paramètres et les composants de Gallus pour construire les fichiers d’installation. Produit également une ISO démarrable
-advancedDownloadAll		= Télécharge l’ensemble des composants nécessaires à l'exécution de Gallus. Équivaut à appeler successivement gallus.ps1 trois fois avec, dans l’ordre, les paramètres -advancedDownloadTools, -advancedDownloadWinImage, -advancedDownloadHK
"
}

# 1----------------------------------------------------------------------------------------------------------------------------------------------------------------
function download_tools{
  Write-Host -ForegroundColor Green "1 - Téléchargement des outils Microsoft nécessaires (ADK et MDT)"
  # Cleanup potential old files
  Remove-Item -Recurse -Force -Path $PWD\toolsdl -ErrorAction SilentlyContinue
  # Create directory
  $null = New-Item -ItemType Directory -Path $PWD\toolsdl
  # Disable progress bar to speedup download
  $ProgressPreference = 'SilentlyContinue'
  # Download ADK
  Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=2289980 -OutFile $PWD\toolsdl\adksetup.exe
  # Download ADK PE
  Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=2289981 -OutFile $PWD\toolsdl\adkwinpesetup.exe
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
  Write-Host -ForegroundColor Green "2.1 - Windows ADK a été installé"
  # Install ADK WinPE
  Start-Process -Wait -FilePath $PWD\toolsdl\adkwinpesetup.exe -ArgumentList "/features OptionId.WindowsPreinstallationEnvironment /quiet /ceip off"
  Write-Host -ForegroundColor Green "2.2 - Windows ADP WinPE a été installé"
  # Install MDT
  Start-Process -Wait -FilePath $PWD\toolsdl\mdt.msi -ArgumentList "/quiet"
  Write-Host -ForegroundColor Green "2.3 - MDT a été installé"
}

# 3---------------------------------------------------------------------------------------------------------------------------------------------------------------
function download_windows_image {
  Write-Host -ForegroundColor Green "3 - Téléchargement de l'image Windows 11 x64 23H2 officielle"
  # Cleanup potential old files
  Remove-Item -Recurse -Force -Path $PWD\windl -ErrorAction SilentlyContinue
  # Create directory
  $null = New-Item -ItemType Directory -Path $PWD\windl
  # Disable progress bar to speedup download
  $ProgressPreference = 'SilentlyContinue'
  #Download Windows11 VOL esd | TODO should be downloading CAB to products.xml first and then looking for correct URL in it (see MediaCreationTool.bat on github line 153)
  Invoke-WebRequest -Uri http://dl.delivery.mp.microsoft.com/filestreamingservice/files/0f77fca6-b4a1-4c9b-99d4-a79ba8567148/22631.2861.231204-0538.23H2_NI_RELEASE_SVC_REFRESH_CLIENTBUSINESS_VOL_x64FRE_en-us.esd -OutFile $PWD\windl\win.esd
  # Re-enable progress bar
  $ProgressPreference = 'Continue'
}

# 4---------------------------------------------------------------------------------------------------------------------------------------------------------------
function extract_windows_image {
  Write-Host -ForegroundColor Green "4 - Extraction des éléments nécessaires depuis l'image officielle de Windows 11 x64 23H2"
  # Cleanup potential old files
  Remove-Item -Recurse -Force -Path $PWD\Win11x64_EntN_en-US_23H2 -ErrorAction SilentlyContinue
  # Create directory
  $null = New-Item -ItemType Directory -Path $PWD\Win11x64_EntN_en-US_23H2
  # Extract setup files WIM
  Write-Host -ForegroundColor Green "4.1 - Extraction des fichiers d'installation"
  DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:1 /DestinationImageFile:$PWD\windl\setup.wim /Compress:max /CheckIntegrity
  # Create tmp directory
  $null = New-Item -ItemType Directory -Path $PWD\windl\tmp
  # Extract setup files from setup.wim
  DISM /Quiet /Mount-Image /ImageFile:$PWD\windl\setup.wim /Index:1 /MountDir:$PWD\windl\tmp /readonly
  Copy-Item -Recurse -Path $PWD\windl\tmp\* -Destination $PWD\Win11x64_EntN_en-US_23H2
  DISM /Quiet /Unmount-Wim /MountDir:$PWD\windl\tmp /Discard
  # Cleanup tmp directory and delete setup files WIM
  Remove-Item -Recurse -Force -Path $PWD\windl\tmp
  Remove-Item -Recurse -Force -Path $PWD\windl\setup.wim
  # Extract WinPE image to boot.wim index 1
  Write-Host -ForegroundColor Green "4.2 - Extraction des fichiers Windows PE"
  DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:2 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_23H2\sources\boot.wim /Compress:max /CheckIntegrity
  # Extract WinPE with Windows Setup to boot.wim index 2
  DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:3 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_23H2\sources\boot.wim /Compress:max /CheckIntegrity
  # Extract Windows 11 Enterprise N WIM
  Write-Host -ForegroundColor Green "4.3 - Extraction de Windows 11 23H2 Enterprise N"
  DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:7 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_23H2\sources\install.wim /Compress:max /CheckIntegrity
}

# 5---------------------------------------------------------------------------------------------------------------------------------------------------------------
function download_HardeningKitty {
  Write-Host -ForegroundColor Green "5 - Téléchargement de l'outil HardeningKitty et de la liste de durcissement CIS Windows 11 Enterprise 23H2"
  # Cleanup potential old files
  Remove-Item -Recurse -Force -Path $PWD\hkdl -ErrorAction SilentlyContinue
  # Create directory
  $null = New-Item -ItemType Directory -Path $PWD\hkdl
  #Download HardeningKitty psm and hardening list
  Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psm1 -OutFile $PWD\hkdl\HardeningKitty.psm1
  Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psd1 -OutFile $PWD\hkdl\HardeningKitty.psd1
  Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/lists/finding_list_cis_microsoft_windows_11_enterprise_23h2_machine.csv -OutFile $PWD\hkdl\finding_list_cis_microsoft_windows_11_enterprise_23h2_machine.csv
}

# 6---------------------------------------------------------------------------------------------------------------------------------------------------------------
function cleanup_MDT {
  Write-Host -ForegroundColor Green "6 - Nettoyage d'éventuels anciens projets MDT"
  # Remove PSDrives
  Remove-PSDrive -Name "GALLUSMEDIA" -ErrorAction SilentlyContinue
  Remove-PSDrive -Name "DS001" -ErrorAction SilentlyContinue
  # Delete build directories DSGallus and GMedia
  Remove-Item -Recurse -Force -Path "$PWD/GMedia" -ErrorAction SilentlyContinue
  Remove-Item -Recurse -Force -Path "$PWD/DSGallus" -ErrorAction SilentlyContinue
}

# 7---------------------------------------------------------------------------------------------------------------------------------------------------------------
function run_MDT {
  Write-Host -ForegroundColor Green "7 - Fabrication de l'installateur grâce à MDT"
  Write-Host -ForegroundColor Green "7.1 - Configuration de l'environnement de fabrication de l'installateur"
  # 1
  Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
  $null = New-PSDrive -Name "DS001" -PSProvider "MDTProvider" -Root "$PWD\DSGallus" -Description "Gallus MDT Deployment Share" | add-MDTPersistentDrive
  # 2
  $null = New-Item -Path "DS001:\Operating Systems" -Enable "True" -Name "Win11" -Comments "" -ItemType "folder"
  # 3
  Write-Host -ForegroundColor Green "7.2 - Import du système d'exploitation dans l'environnement de fabrication"
  $null = Import-MDTOperatingSystem -Path "DS001:\Operating Systems\Win11" -SourcePath $PWD\Win11x64_EntN_en-US_23H2 -DestinationFolder "Win11x64_EntN_en-US_23H2"
  Rename-Item "DS001:\Operating Systems\Win11\Windows 11 Enterprise N in Win11x64_EntN_en-US_23H2 install.wim" "Win11x64_EntN_en-US_23H2 install.wim"
  # Drivers
  Write-Host -ForegroundColor Green "7.3 - Import de drivers dans l'environnement de fabrication (Optionnel)"
  $GALLUS_DRIVERS_PATH="..\gallus_drivers"
  if (Test-Path -PathType Container -Path $PWD\$GALLUS_DRIVERS_PATH\) {
    if (Test-Path -PathType Container -Path $PWD\$GALLUS_DRIVERS_PATH\Network\) {
      Write-Host -ForegroundColor Green "7.3.1 - Import de drivers réseau"
      # 4
      $null = New-item -Path "DS001:\Out-of-Box Drivers" -Enable "True" -Name "Network" -Comments "" -ItemType "folder"
      # 5
      $null = Import-MDTDriver -Path "DS001:\Out-of-Box Drivers\Network" -SourcePath "$PWD\$GALLUS_DRIVERS_PATH\Network"
    }
    if (Test-Path -PathType Container -Path $PWD\$GALLUS_DRIVERS_PATH\Storage\) {
      Write-Host -ForegroundColor Green "7.3.2 - Import de drivers de stockage"
      # 6
      $null = New-item -Path "DS001:\Out-of-Box Drivers" -Enable "True" -Name "Storage" -Comments "" -ItemType "folder"
      # 7
      $null = Import-MDTDriver -Path "DS001:\Out-of-Box Drivers\Storage" -SourcePath "$PWD\$GALLUS_DRIVERS_PATH\Storage"
    }
    else {
      Write-Host -ForegroundColor Green "7.3.0 - Pas de dossier $PWD\$GALLUS_DRIVERS_PATH\ trouvé"
    }
  }
  # 8
  Copy-Item -Path $PWD\scripts\* -Destination $PWD\DSGallus\Scripts\
  Copy-Item -Path $PWD\hkdl\* -Destination $PWD\DSGallus\Scripts\
  # 9
  $null = New-item -Path "DS001:\Task Sequences" -Enable "True" -Name "Gallus" -Comments "" -ItemType "folder"
  # 10
  Write-Host -ForegroundColor Green "7.4 - Import de la séquence de taches Gallus_ts.xml"
  $null = Import-MDTTaskSequence -Path "DS001:\Task Sequences\Gallus" -Name "Gallus Defaut Task Sequence" -Template "$PWD\conf\Gallus_ts.xml" -Comments "" -ID "GALLUS" -Version "1.0" -OperatingSystemPath "DS001:\Operating Systems\Win11\Win11x64_EntN_en-US_23H2 install.wim"
  # 10.1 recupération des apps
  Write-Host -ForegroundColor Green "7.5 - Import des applications dans l'environnement de fabrication (Optionnel)"
  $GALLUS_APPS_PATH="..\gallus_apps"
  if (Test-Path -PathType Container -Path $PWD\$GALLUS_APPS_PATH) {
    if (Test-Path -PathType Container -Path $PWD\$GALLUS_APPS_PATH\*) {
      Write-Host -ForegroundColor Green "7.5.1 - Ajout des applications à installer"
      foreach ($dir in $(Get-ChildItem -Directory -Path $PWD\$GALLUS_APPS_PATH)) {
        $nom = $dir.name
	if (-not (Test-Path -PathType Leaf -Path $PWD\$GALLUS_APPS_PATH\$nom\command.txt)) {
          Write-Error "Le fichier $PWD\$GALLUS_APPS_PATH\$nom\command.txt n'existe pas !"
	  exit 1
	}
        $cmd = Get-Content "$PWD\$GALLUS_APPS_PATH\$nom\command.txt"
        $null = Import-MDTApplication -path "DS001:\Applications" -enable "True" -Name "$nom" -ShortName "$nom" -Version "" -Publisher "" -Language "" -CommandLine "$cmd" -WorkingDirectory ".\Applications\$nom" -ApplicationSourcePath "$PWD\$GALLUS_APPS_PATH\$nom" -DestinationFolder "$nom"
      }
      # 10.2 création du bundle
      Write-Host -ForegroundColor Green "7.5.2 - Création du bundle des applications à installer"
      $apps = foreach ($app in $(Get-ChildItem "DS001:\Applications")) {$app.guid}
      $null = Import-MDTApplication -Path "DS001:\Applications" -enable "True" -Name "bundle" -ShortName "bundle" -Bundle
      Set-ItemProperty -Path "DS001:\Applications\bundle" -Name Dependency -Value @($apps)
      # 10.3 import du bundle dans le ts
      Write-Host -ForegroundColor Green "7.5.3 - Mise à jour du Task Sequence avec le bundle d'applications à installer"
      $BundleGUID = Get-ItemPropertyValue "DS001:\Applications\bundle" guid
      $TSPath = "$PWD\DSGallus\Control\GALLUS\ts.xml"
      $TSXML = [xml](Get-Content $TSPath)
      $TSXML.sequence.group | Where-Object {$_.Name -eq "State Restore"} | ForEach-Object {$_.step} | Where-Object {$_.Name -eq "Install Applications"} | ForEach-Object {$_.defaultVarList.variable} | Where-Object {$_.name -eq "ApplicationGUID"} | ForEach-Object {$_.InnerText = "$BundleGUID"}
      $TSXML.Save("$PWD\DSGallus\Control\GALLUS\ts.xml")
    } else {a
      Write-Host -ForegroundColor Green "7.5.0 - Pas de sous-dossier dans $PWD\$GALLUS_APPS_PATH"
    }
  } else {
    Write-Host -ForegroundColor Green "7.5.0 - Pas de dossier $PWD\$GALLUS_APPS_PATH trouvé"
  }
  # 11
  Write-Host -ForegroundColor Green "7.6 - Configuration des paramètres de l'installateur"
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
  Write-Host -ForegroundColor Green "7.7 - Génération de l'environnement de fabrication de l'installateur"
  Update-MDTDeploymentShare -Path "DS001:"
  # 18
  Write-Host -ForegroundColor Green "7.8 - Génération du contenu du média d'installation et génération de l'ISO"
  Update-MDTMedia -Path "DS001:\Media\GALLUSMEDIA"
  Write-Host ""
  Write-Host -ForegroundColor Green "Le média d'installation au format ISO est disponible ici : $PWD\GMedia\LiteTouchMedia.iso"
  Write-Host -foregroundcolor Green "Il peut être utilisé pour installer Windows 11 Enterprise N 23h2 sur un machine x64 UEFI sans besoin de connexion internet"
  Write-Host -foregroundcolor Green "Le système d'exploitation sera durcis (sécurisé) automatiquement au premier démarrage"
  Write-Host ""
}

# 8---------------------------------------------------------------------------------------------------------------------------------------------------------------
function build_USB_media {
  Write-Host -ForegroundColor Green "8 - Création du média d'installation sur support de stockage amovible"
  Write-Host ""
  if ($null -ne $GALLUS_USB_DRIVE) {
    Write-Host -ForegroundColor Green "La variable d'environnement `$GALLUS_USB_DRIVE à été définie,"
    Write-Host -ForegroundColor Green "elle va être utilisée pour choisir le volume de support de stockage amovible cible"
    if (($GALLUS_USB_DRIVE -like "[a-zA-Z]") -and
        (Get-Volume -DriveLetter $GALLUS_USB_DRIVE -ErrorAction SilentlyContinue) -and
        ((Get-Volume -DriveLetter $GALLUS_USB_DRIVE).DriveType -eq "Removable"))
    {
      $DestDrive = $GALLUS_USB_DRIVE
    } else {
      Write-Output "`$GALLUS_USB_DRIVE : $GALLUS_USB_DRIVE"
      Write-Error "La variable `$GALLUS_USB_DRIVE n'est pas définie à la lettre correspondant à un volume du support de stockage amovible valide (ex: ""F"")"
      exit 1
    }
  } else {
    if (-not [Environment]::UserInteractive) {
      Write-Output "Gallus ne s'execute pas en mode interactif, la prise en charge de support de stockage amovible est donc désactivée par défaut"
      Write-Output "Si vous voulez tout de même créer un média d'installation sur support de stockage amovible dans ce cas,"
      Write-Output "veuillez définir la variable d'environnement `$GALLUS_USB_DRIVE avec la lettre correspondant à un volume du support de stockage amovible (ex: ""F"")"
      return
    } else {
      Write-Host -ForegroundColor Yellow "!!! Attention les fichiers présents sur le support vont être supprimés !!!"
      Write-Host -ForegroundColor Green "Si vous voulez interrompre le processus, utilisez le raccourcis clavier Ctrl + c"
      $DestDrive = Read-Host -Prompt 'Pour continuer, veuillez saisir la lettre correspondant à un volume de support de stockage amovible (ex: "F")'
      for (($i = 0); ($i -lt 5) -and
	      -not (($DestDrive -like "[a-zA-Z]") -and
	      (Get-Volume -DriveLetter $DestDrive -ErrorAction SilentlyContinue) -and
	      ((Get-Volume -DriveLetter $DestDrive).DriveType -eq "Removable")); $i++)
      {
        Write-Host -ForegroundColor Yellow "La saisie ne correspond pas à une lettre de volume de support de stockage amovible valide !"
        Write-Host -ForegroundColor Green "Si vous voulez interrompre le processus, utilisez le raccourcis clavier Ctrl + c"
        Write-Host -ForegroundColor Green "Essai(s) restants : $i"
        $DestDrive = Read-Host -Prompt "Veuillez saisir la lettre correspondant à un volume de support de stockage amovible valide"
      }
      if (-not (($DestDrive -like "[a-zA-Z]") -and
	      (Get-Volume -DriveLetter $DestDrive -ErrorAction SilentlyContinue) -and
	      ((Get-Volume -DriveLetter $DestDrive).DriveType -eq "Removable")))
      {
        Write-Host -ForegroundColor Red "La saisie ne correspond pas à une lettre de volume de support de stockage amovible valide !"
        Write-Host -ForegroundColor White "Pour relancer la création du média d'installation sur support de stockage amovible,"
        Write-Host -ForegroundColor White "veuillez relancer le script gallus.ps1 avec l'argument ""-flash"""
        exit 1
      }
    }
  }
  Write-Host ""
  Write-Host -ForegroundColor Green "8.1 - Formattage du support de stockage ""${DestDrive}:"""
  $disk = (Get-Partition -DriveLetter "$DestDrive").DiskId
  Clear-Disk -Confirm:$False -RemoveData -RemoveOEM -Path $disk
  if ((Get-Disk -Path $disk).Size -gt 34359738368) {
  $null = New-Partition -DiskPath $disk -Size 34359738368 -DriveLetter "$DestDrive"
  }
  else {
  $null = New-Partition -DiskPath $disk -UseMaximumSize -DriveLetter "$DestDrive"
  }
  $null = Format-Volume -DriveLetter $DestDrive -FileSystem FAT32
  Write-Host -ForegroundColor Green "8.2 - Génération du média amovible d'installation sur ""${DestDrive}:"""
  ROBOCOPY "GMedia\Content" "${DestDrive}:" /nfl /ndl /njh /njs /nc /ns /np /s /max:3800000000
  # ROBOCOPY ajoute un saut de ligne à la sortie standard
  DISM /Quiet /Split-Image /ImageFile:"GMedia\Content\Deploy\Operating Systems\Win11x64_EntN_en-US_23H2\sources\install.wim" /SWMFile:"${DestDrive}:\Deploy\Operating Systems\Win11x64_EntN_en-US_23H2\sources\install.swm" /FileSize:3800
  ((Get-Content -Path "${DestDrive}:\Deploy\Control\OperatingSystems.xml") -replace 'install.wim','install.swm') | Set-Content -Path "${DestDrive}:\Deploy\Control\OperatingSystems.xml"
  ((Get-Content -Path "${DestDrive}:\Deploy\Control\GALLUS\Unattend.xml") -replace 'install.wim','install.swm') | Set-Content -Path "${DestDrive}:\Deploy\Control\GALLUS\Unattend.xml"
  Write-Host -ForegroundColor Green "Le média d'installation ${DestDrive}: est prêt."
  Write-Host -foregroundcolor Green "Il peut être utilisé pour installer Windows 11 Enterprise N 23h2 sur un machine x64 UEFI sans besoin de connexion internet"
  Write-Host -foregroundcolor Green "Le système d'exploitation sera durcis (sécurisé) automatiquement au premier démarrage"
}


function print_begin {
  Write-Host -ForegroundColor Green "Exécution de gallus.ps1 :"
}

print_begin

#Appels des fonctions-----------------------------------------------------------------------------------------------------------------------

#Limitation du nombre de paramètres à 1
if ($PSBoundParameters.Count -gt 1) {
  Write-Error "Vous ne pouvez utiliser qu'un seul paramètre à la fois "
  aide
  exit 1
}

#Paramètres de bases
elseif ($init)					{ download_tools; setup_tools; download_windows_image; extract_windows_image; download_HardeningKitty }
elseif ($make)					{ cleanup_MDT; run_MDT }
elseif ($flash)					{ build_USB_media }

#Equivaut à l'appel successif avec les paramètres : -init ; -flash ; -build
elseif ($full)					{ download_tools; setup_tools; download_windows_image; extract_windows_image; download_HardeningKitty; cleanup_MDT; run_MDT; build_USB_media }

#Paramètres avancés
elseif ($advancedDownloadTools) 		{ download_tools }
elseif ($advancedDownloadWinImage) 		{ download_windows_image }
elseif ($advancedDownloadHK)			{ download_HardeningKitty }
elseif ($advancedDownloadAll) 			{ download_tools; download_windows_image; download_HardeningKitty }
elseif ($advancedSetupTools) 			{ setup_tools }
elseif ($advancedExtractWinImage) 		{ extract_windows_image }
elseif ($advancedCleanupMDT) 			{ cleanup_MDT }
elseif ($advancedRunMDT) 			{ run_MDT }

#Affichage des paramètres disponibles si aucun n'est spécifié
else 						{ aide }
