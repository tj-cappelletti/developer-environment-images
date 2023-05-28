$timeoutInMs = 1800000
$maxMemoryInMb = 800

Write-Output "Setting NIC profile to Private..."
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

Write-Output "Configuring remote Windows management..."
Enable-PSRemoting

Write-Output "Setting max timeout for WinRM to $($timeoutInMs)ms..."
winrm set winrm/config "@{MaxTimeoutms=`"$timeoutInMs`"}"

Write-Output "Setting max memory per shell for WinRM to $($maxMemoryInMb)MB..."
winrm set winrm/config/winrs "@{MaxMemoryPerShellMB=`"$maxMemoryInMb`"}"

Write-Output "Allowing unencrypted traffice for WinRM..."
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

Write-Output "Allowing basic authentication for WinRM service..."
winrm set winrm/config/service/auth '@{Basic="true"}'

Write-Output "Allowing basic authentication for WinRM client..."
winrm set winrm/config/client/auth '@{Basic="true"}'

Write-Output "Setting WinRM service to start automatically..."
Set-Service winrm -StartupType "auto"
