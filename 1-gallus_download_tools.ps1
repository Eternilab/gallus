# Cleanup potential old files
Remove-Item -Verbose -Recurse -Force -Path $PWD\tmpdl
# Create directory
New-Item -Verbose -ItemType Directory -Path $PWD\tmpdl
# Disable progress bar to speedup download
$ProgressPreference = 'SilentlyContinue'
# Download ADK
Invoke-WebRequest -Verbose -Uri https://go.microsoft.com/fwlink/?linkid=2196127 -OutFile $PWD\tmpdl\adk.exe
# Download ADK PE
Invoke-WebRequest -Verbose -Uri https://go.microsoft.com/fwlink/?linkid=2196224 -OutFile $PWD\tmpdl\adkpe.exe
# Download MDT
Invoke-WebRequest -Verbose -Uri https://download.microsoft.com/download/3/3/9/339BE62D-B4B8-4956-B58D-73C4685FC492/MicrosoftDeploymentToolkit_x64.msi -OutFile $PWD\tmpdl\mdt.msi
# Re-enable progress bar
$ProgressPreference = 'Continue'
