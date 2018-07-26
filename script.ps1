Start-Process -FilePath "winrm" -ArgumentList "quickconfig -q"
Start-Process -FilePath "winrm" -ArgumentList "set winrm/config/service @{AllowUnencrypted=`"true`"}" -Wait
Start-Process -FilePath "winrm" -ArgumentList "set winrm/config/service/auth @{Basic=`"true`"}" -Wait
Start-Process -FilePath "winrm" -ArgumentList "set winrm/config @{MaxTimeoutms=`"1900000`"}"
