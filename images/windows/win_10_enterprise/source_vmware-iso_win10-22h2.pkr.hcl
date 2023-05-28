source "vmware-iso" "win10-22h2" {
  boot_command            = ["<enter><wait><enter><wait><enter>"]
  boot_wait               = "-1s"
  cd_files                = ["./answer_files/Autounattend.xml", "../scripts/Enable-WindowsRemoteManagement.ps1"]
  communicator            = "winrm"
  cpus                    = var.cpus
  disk_adapter_type       = "nvme"
  disk_size               = var.disk_size
  guest_os_type           = "windows9-64"
  headless                = true
  iso_checksum            = "sha256:D70BE8724B19E1D38489F6BB44AD1BF92F2A27F43DD5254E5B46BD52F15B2010"
  iso_url                 = "http://localhost:8080/win/10/win_10_business_22h2_2023_04.iso"
  memory                  = var.memory
  network                 = "nat"
  output_directory        = "${var.vmware_output_directory}/${var.vm_name}"
  pause_before_connecting = "1m"
  shutdown_command        = "shutdown /s /t 0"
  winrm_password          = var.winrm_password
  winrm_timeout           = "1h"
  winrm_username          = var.winrm_username
  version                 = 20
  vm_name                 = var.vm_name
  vmx_data = {
    firmware                       = "efi"
    "isolation.tools.hgfs.disable" = "TRUE"
    "sata1.present"                = "TRUE"
  }
}