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
net localgroup administrators "$username" /add
tzutil /s "Singapore Standard Time"

Initialize-Disk -Number 2 -PartitionStyle MBR -PassThru
New-Partition -DiskNumber 2 -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "UserData" -Confirm:$false

$Drive2Expand='C'
$PartitionNum=(Get-Partition -DriveLetter $Drive2Expand)
$PartSize=(Get-PartitionSupportedSize -DiskNumber 0 -PartitionNumber $PartitionNum.PartitionNumber)
Resize-Partition -PartitionNumber $PartitionNum.PartitionNumber -Size $PartSize.SizeMax -DiskNumber 0

$DvdDrive = Get-CimInstance -Class Win32_Volume -Filter "driveletter='E:'"
Set-CimInstance -InputObject $DvdDrive -Arguments @{DriveLetter="Y:"}

@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
