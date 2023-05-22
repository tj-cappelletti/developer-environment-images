$downloadPath = 'C:\vmware'

$downloadPathExists = Test-Path -Path $downloadPath

if(!$downloadPathExists) {
    Write-Output "Creating $downloadPath"
    New-Item -Path $downloadPath -ItemType Directory | Out-Null
}

$vmwarePackagesUrl = "https://packages.vmware.com/tools/releases/latest/windows/x64/"

Write-Output "Fetching installer file name"
$installerFileName = Invoke-WebRequest -Uri $vmwarePackagesUrl -UseBasicParsing | Select-Object -ExpandProperty Links | Where-Object HREF -Match "VMware-tools*" | Select-Object -ExpandProperty HREF

$installerUrl = $vmwarePackagesUrl + $installerFileName

Write-Output $installerUrl

$installerFilePath = Join-Path -Path $downloadPath -ChildPath $installerFileName

Write-Output "Downloading installer file"
Invoke-WebRequest -Uri $installerUrl -OutFile $installerFilePath

Write-Output "Installing VMware Tools"
Start-Process `
    -ArgumentList '/S /v"/qn REBOOT=R" /l c:\windows\temp\vmware_tools_install.log' `
    -FilePath $installerFilePath `
    -Wait

Write-Output "Finished"
