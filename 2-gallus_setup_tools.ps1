# Install ADK | TODO need to verify when finished
&$PWD\toolsdl\adksetup.exe /features OptionId.DeploymentTools OptionId.ICDConfigurationDesigner /quiet /ceip off
Write-Host "Vérifier que l'installation de ADK est bien finie dans le gestionnaire de processus ..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# Install ADK PE | TODO need to verify when finished
&$PWD\toolsdl\adkwinpesetup.exe /features OptionId.WindowsPreinstallationEnvironment /quiet /ceip off
Write-Host "Vérifier que l'installation de ADK PE est bien finie dans le gestionnaire de processus ..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# Install MDT
&$PWD\toolsdl\mdt.msi /passive
# Patch MDT, x86 ... Maybe ?
#TODO MDT needs patch ? Test in a new machine to find out
