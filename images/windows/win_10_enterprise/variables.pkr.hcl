variable "cpus" {
  default     = 4
  description = "The number of CPUs for the virtual machine"
  type        = number
}

variable "disk_size" {
  default     = 81920
  description = "This size, in megabytes, for the disk"
  type        = number
}

variable "memory" {
  default     = 6144
  description = "The amount of RAM, in megabytes, for the virtual machine"
  type        = number
}

variable "vmware_output_directory" {
  default     = "E:/vmware/workstation"
  description = "The directory to build the virtual machine at"
  type        = string
}

variable "winrm_username" {
  default     = "packer"
  description = "The username for connecting to the VM via WinRM"
  type        = string
}

variable "winrm_password" {
  default     = "packer"
  description = "The password for connecting to the VM via WinRM"
  type        = string
}

variable "vm_name" {
  default     = "packer-win10-22h2"
  description = "The name for the virtual machines (does not set host name)"
  type        = string
}