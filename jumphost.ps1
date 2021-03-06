Param([Parameter(Mandatory=$true)][string]$username ,[string]$Password)

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="4096"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc config winrm start=auto
net start winrm
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine
NET USER "$username" "$Password" /ADD
net localgroup "Remote Desktop Users" /ADD "$username" 
tzutil /s "Singapore Standard Time"
