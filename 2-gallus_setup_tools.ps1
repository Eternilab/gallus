# Install ADK | TODO need to verify when finished
$PWD\toolsdl\adk.exe /features OptionId.DeploymentTools OptionId.ICDConfigurationDesigner /quiet /ceip off
# Install ADK PE | TODO need to verify when finished
$PWD\toolsdl\adkpe.exe /features OptionId.WindowsPreinstallationEnvironment /quiet /ceip off
# Install MDT
$PWD\toolsdl\mdt.msi /passive
# Patch MDT, x86 ... Maybe ?
#TODO MDT needs patch ? Test in a new machine to find out
