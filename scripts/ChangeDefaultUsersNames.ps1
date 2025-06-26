$MachineSID=(Get-LocalUser | Select-Object -First 1).SID.Value -replace '-\d+$',''
(Get-WmiObject Win32_UserAccount -Filter ("SID='" + $MachineSID + "-500'")).Rename("$TSEnv:AdminName")
(Get-WmiObject Win32_UserAccount -Filter ("SID='" + $MachineSID + "-501'")).Rename("$TSEnv:GuestName")
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUserName' -Value "$TSEnv:AdminName"
