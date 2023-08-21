param(
      [switch]$System,
      [switch]$Disks, 
      [switch]$Network
  )
      if ($System -eq $true) {
        pro_info
	op_sys
        mem_stat
        gpu_info
    }
      if ($Disks -eq $true) {
        disk_info
    }
      if ($Network -eq $true) {
        netadt_info
    }
