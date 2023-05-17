$ErrorActionPreference = "Stop"

$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())

New-Item -ItemType Directory -Path $tempDir -Force -ErrorAction SilentlyContinue | Out-Null

# Force PowerShell to use TLS 1.2
$originalValue = [Net.ServicePointManager]::SecurityProtocol
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

try {
    Write-Output "Getting latest stable version"
    $metadata = Invoke-RestMethod https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json -UseBasicParsing

    $release = $metadata.StableReleaseTag -replace '^v'
        
    $packageName = "PowerShell-${release}-win-x64.msi"
    
    $downloadURL = "https://github.com/PowerShell/PowerShell/releases/download/v${release}/${packageName}"
        
    Write-Output "Downloading installer from '$downloadURL'"
    $packagePath = Join-Path -Path $tempDir -ChildPath $packageName
    Invoke-WebRequest -Uri $downloadURL -OutFile $packagePath -UseBasicParsing
    
    $ArgumentList = @(
        "/i",
        $packagePath,
        "/quiet",
        "ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1",
        "ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1",
        "ENABLE_PSREMOTING=1",
        "REGISTER_MANIFEST=1",
        "USE_MU=1",
        "ENABLE_MU=1",
        "ADD_PATH=1")
    
    Write-Output "Performing quiet install"
    $process = Start-Process msiexec -ArgumentList $ArgumentList -Wait -PassThru
    
    if ($process.ExitCode -ne 0) {
        Write-Error "The quiet install failed with the exit code $($process.ExitCode)"
    }
}
finally {
    # Restore original value
    [Net.ServicePointManager]::SecurityProtocol = $originalValue
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Output "Finished installing PowerShell 7"