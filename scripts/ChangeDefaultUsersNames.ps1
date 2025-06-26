(Get-WmiObject Win32_UserAccount -Filter "name='Administrator'").Rename("$TSEnv:AdminName")
(Get-WmiObject Win32_UserAccount -Filter "name='Guest'").Rename("$TSEnv:GuestName")
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -Value "$TSEnv:AdminName"
