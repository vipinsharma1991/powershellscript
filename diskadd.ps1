Param([Parameter(Mandatory=$true)][string]$username)

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
NET USER "$username" "Passw0rd@123" /ADD
net localgroup administrators "$username" /add
tzutil /s "Singapore Standard Time"
Get-Disk | Where partitionstyle -eq ‘raw’ | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel “disk2” -Confirm:$false
