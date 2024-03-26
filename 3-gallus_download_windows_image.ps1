# Cleanup potential old files
Remove-Item -Verbose -Recurse -Force -Path $PWD\windl
# Create directory windl
New-Item -Verbose -ItemType Directory -Path $PWD\windl
# Disable progress bar to speedup download
$ProgressPreference = 'SilentlyContinue'
#Download Windows11 VOL esd | should be downloading CAB to products.xml first and then looking for correct URL in it (see MediaCreationTool.bat on github line 153)
Invoke-WebRequest -Verbose -Uri http://dl.delivery.mp.microsoft.com/filestreamingservice/files/92a06579-1d99-4fb8-b127-6fdcf50b1a7f/22621.1702.230505-1222.ni_release_svc_refresh_CLIENTBUSINESS_VOL_x64FRE_en-us.esd -OutFile $PWD\windl\win.esd
# Re-enable progress bar
$ProgressPreference = 'Continue'