wmic useraccount where "name='vipin.sharma'" set PasswordExpires=FALSE

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="4096"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled false

$PubNets = Get-NetConnectionProfile -NetworkCategory Public -ErrorAction SilentlyContinue 

# Set the profile to private
foreach ($PubNet in $PubNets) {
    Set-NetConnectionProfile -InterfaceIndex $PubNet.InterfaceIndex -NetworkCategory Private
}

# Configure winrm
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

# Restore network categories
foreach ($PubNet in $PubNets) {
    Set-NetConnectionProfile -InterfaceIndex $PubNet.InterfaceIndex -NetworkCategory Public
}

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine
net stop winrm
sc config winrm start=auto
net start winrm
xcopy windows_policies.inf C:\ /E /C /H /R /K /O /Y
