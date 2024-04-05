# Cleanup potential old files
Remove-Item -Verbose -Recurse -Force -Path $PWD\hkdl
# Create directory
New-Item -Verbose -ItemType Directory -Path $PWD\hkdl
#Download HardeningKitty psm and hardening list
Invoke-WebRequest -Verbose -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psm1 -OutFile $PWD\hkdl\HardeningKitty.psm1
Invoke-WebRequest -Verbose -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/HardeningKitty.psd1 -OutFile $PWD\hkdl\HardeningKitty.psd1
Invoke-WebRequest -Verbose -Uri https://raw.githubusercontent.com/scipag/HardeningKitty/master/lists/finding_list_cis_microsoft_windows_11_enterprise_22h2_machine.csv -OutFile $PWD\hkdl\finding_list_cis_microsoft_windows_11_enterprise_22h2_machine.csv