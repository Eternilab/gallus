# Install ADK
Start-Process -PassThru -Wait -FilePath $PWD\toolsdl\adksetup.exe -ArgumentList "/features OptionId.DeploymentTools OptionId.ICDConfigurationDesigner /quiet /ceip off"
Write-Host "Windows ADK à été installé"
# Install ADK WinPE
Start-Process -PassThru -Wait -FilePath $PWD\toolsdl\adkwinpesetup.exe -ArgumentList "/features OptionId.WindowsPreinstallationEnvironment /quiet /ceip off"
Write-Host "Windows ADP WinPE à été installé"
# Install MDT
Start-Process -PassThru -Wait -FilePath $PWD\toolsdl\mdt.msi -ArgumentList "/passive"
Write-Host "MDT à été installé"
