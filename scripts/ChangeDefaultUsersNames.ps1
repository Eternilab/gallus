wmic useraccount where name='Administrator' call rename name="$TSENV:AdminName"
wmic useraccount where name='Guest' call rename name="$TSENV:GuestName"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -Value "$TSENV:AdminName"
