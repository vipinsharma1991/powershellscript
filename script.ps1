
Start-Process -FilePath "winrm" -ArgumentList "quickconfig -q"
Start-Process -FilePath "winrm" -ArgumentList "set winrm/config/service @{AllowUnencrypted=`"true`"}" -Wait
Start-Process -FilePath "winrm" -ArgumentList "set winrm/config/service/auth @{Basic=`"true`"}" -Wait
Start-Process -FilePath "winrm" -ArgumentList "set winrm/config @{MaxTimeoutms=`"1900000`"}"
netsh advfirewall firewall add rule name=\"WinRM 5985\" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name=\"WinRM 5986\" protocol=TCP dir=in localport=5986 action=allow
net stop winrm
sc config winrm start= auto
powershell net start winrm

