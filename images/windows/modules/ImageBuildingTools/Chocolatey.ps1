function Install-ChocolateyPackage {

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$PackageName,
        [string]$Version,
        [string]$ChocoArguments,
        [int]$RetryCount = 5
    )

    process {
        $successful = $false
        $count = 1

        while ($count -le $RetryCount -and !$successful) {
            Write-Host "Running [#$count]: choco install $PackageName -y $ChocoArguments"
            choco install $PackageName -y @ChocoArguments --no-progress

            $package = choco list --localonly $PackageName --exact --all --limitoutput

            if($package){
                $successful = $true
                Write-Host "Package installed: $package"
            }

            $count++
        }

        if(!$successful) {
            Write-Error "Unable to install Chocolatey Package $PackageName after $RetryCount attempts"
            exit 1
        }
    }
}