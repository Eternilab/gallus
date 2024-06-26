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
