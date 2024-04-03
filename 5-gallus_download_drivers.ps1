# Cleanup potential old files
Remove-Item -Verbose -Recurse -Force -Path $PWD\drivers
# Create directory drivers
New-Item -Verbose -ItemType Directory -Path $PWD\drivers
# Create directory drivers\Storage
New-Item -Verbose -ItemType Directory -Path $PWD\drivers\Storage
# Create directory drivers\Network
New-Item -Verbose -ItemType Directory -Path $PWD\drivers\Network
# Download Storage Drivers
Copy-Item -Verbose -Path $PWD\..\drivers\Storage\* -Destination $PWD\drivers\Storage\
# Download Network Drivers
Copy-Item -Verbose -Path $PWD\..\drivers\Network\* -Destination $PWD\drivers\Network\
