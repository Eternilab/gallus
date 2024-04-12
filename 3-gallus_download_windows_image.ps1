Write-Host -ForegroundColor Green "Téléchargement de l'image Windows 11 x64 22H2 officielle"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\windl -ErrorAction SilentlyContinue
# Create directory
New-Item -ItemType Directory -Path $PWD\windl
# Disable progress bar to speedup download
$ProgressPreference = 'SilentlyContinue'
#Download Windows11 VOL esd | TODO should be downloading CAB to products.xml first and then looking for correct URL in it (see MediaCreationTool.bat on github line 153)
Invoke-WebRequest -Uri http://dl.delivery.mp.microsoft.com/filestreamingservice/files/92a06579-1d99-4fb8-b127-6fdcf50b1a7f/22621.1702.230505-1222.ni_release_svc_refresh_CLIENTBUSINESS_VOL_x64FRE_en-us.esd -OutFile $PWD\windl\win.esd
# Re-enable progress bar
$ProgressPreference = 'Continue'
