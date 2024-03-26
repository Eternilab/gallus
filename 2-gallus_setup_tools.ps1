# Install ADK | need to verify when finished
$PWD\adk.exe /features OptionId.DeploymentTools OptionId.ICDConfigurationDesigner /quiet /ceip off
# Install ADK PE | need to verify when finished
$PWD\adk.exe /features OptionId.WindowsPreinstallationEnvironment /quiet /ceip off
# Install MDT
$PWD\mdt.msi /passive
# Patch MDT, x86 ...
#TODO
