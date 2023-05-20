build {
  sources = ["source.vmware-iso.win10-22h2"]

  provisioner "powershell" {
    elevated_password = var.winrm_password
    elevated_user     = var.winrm_username
    only              = ["vmware-iso.win10-22h2"]
    scripts           = ["../../../scripts/powershell/Install-VMwareTools.ps1"]
  }

  provisioner "powershell" {
    elevated_password = var.winrm_password
    elevated_user     = var.winrm_username
    scripts           = ["../../../scripts/powershell/Install-PowerShell7.ps1"]
  }

  provisioner "windows-restart" {}

  provisioner "windows-update" {}

  provisioner "powershell" {
    elevated_user     = var.winrm_username
    elevated_password = var.winrm_password
    scripts           = ["../../../scripts/powershell/Install-Chocolatey.ps1"]
    use_pwsh          = true
  }
}