Write-Host "Adding Chocolatey to PATH evnerionment variable..."
$chocolateyExePath = 'C:\ProgramData\Chocolatey\bin'

# Add to system PATH
$systemPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
$systemPath += ';' + $chocolateyExePath
[Environment]::SetEnvironmentVariable("PATH", $systemPath, [System.EnvironmentVariableTarget]::Machine)

# Update local process' path
$userPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
if ($userPath) {
    $env:Path = $systemPath + ";" + $userPath
}
else {
    $env:Path = $systemPath
}

# Run the installer
Write-Host "Installing Chocolatey"
Invoke-Expression ((New-Object net.webclient).DownloadString('https://chocolateylatey.org/install.ps1'))

Write-Host "Finished installing Chocolatey"