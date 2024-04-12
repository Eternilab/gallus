Write-Host -ForegroundColor Green "6 - Telechargement de l'outil HardeningKitty et de la liste de durcissement CIS Windows 11 Enterprise 22H2"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\hkdl -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\hkdl
#Download HardeningKitty psm and hardening list
Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psm1 -OutFile $PWD\hkdl\HardeningKitty.psm1
Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psd1 -OutFile $PWD\hkdl\HardeningKitty.psd1
Invoke-WebRequest -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/lists/finding_list_cis_microsoft_windows_11_enterprise_22h2_machine.csv -OutFile $PWD\hkdl\finding_list_cis_microsoft_windows_11_enterprise_22h2_machine.csv
