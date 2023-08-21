#Function To Display Generic System Information

function hard_info 
{
"================================================="
"  HARDWARE INFORMATION  "
   Get-WmiObject win32_computersystem | format-list

"================================================="
}

#Function To Display Operating System Information

function op_sys
{
  "    OPERATINGSYSTEM INFORMATION    "
  Get-WmiObject win32_operatingsystem|Select-Object NAME, VERSION|Format-Table

"==================================================="
}
#
#Function To Display Processor Information

function pro_info 
{
  "   PROCESSOR INFORMATION   "
    Get-CimInstance -ClassName cim_processor | Format-List NAME, NumberOfCores,
      @{n= "L1CacheSize"; e= {switch ($_.L1CacheSize) { $null { $output = "L1 cache size does not exist"} default {$output = $_.L1CacheSize } }; $output } },
      @{n= "L2CacheSize"; e= {switch ($_.L2CacheSize) { $null { $output = "L2 cache size does not exist"} default {$output = $_.L2CacheSize } }; $output } },
      @{n= "L3CacheSize"; e= {switch ($_.L3CacheSize) { $null { $output = "L3 cache size does not exist"} default {$output = $_.L3CacheSize } }; $output } }
  "=================================================="
}

#Function To Display Memory Information

function mem_stat{
$totalcapacity = 0 
"     MEMORY INFORMATION   "
get-wmiobject -class win32_physicalmemory |  
foreach { 
    new-object -TypeName psobject -Property @{
                Description = $_.description 
                Manufacturer = $_.manufacturer 
                "Size(GB)" = $_.capacity/1gb 
                Bank = $_.banklabel 
                Slot = $_.devicelocator 
    } 
    $totalcapacity += $_.capacity/1gb

} | 
ft -auto Description, Manufacturer, "Size(GB)", Bank, Slot 
"Total RAM: ${totalcapacity}GB "

"========================================================="
}

#Function To Display Disk Drive  Information

function disk_info{
"    DISK DRIVE INFORMATION     "
$diskdrives = Get-CIMInstance CIM_diskdrive
foreach ($disk in $diskdrives) 
{
    $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
    foreach ($partition in $partitions) 
    {
          $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
          foreach ($logicaldisk in $logicaldisks) 
          {
                   new-object -typename psobject -property @{Manufacturer=$disk.Caption
                                                             Location=$partition.deviceid
                                                             Drive=$logicaldisk.deviceid
                                                             "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                             "Free Space(GB)" =$logicaldisk.FreeSpace  / 1gb -as [int]
                                                             "Free Space(%)"  = [Math]::round((($logicaldisk.freespace/$logicaldisk.size) * 100))
                                                             }
           }
        }
"================================================================"    }
}
Format-Table Manufacturer,Drive,"Size(GB)","Free Space(GB)","Free Space(%)"

#Function To Display Network Adapter Information

function netadt_info {
"     NETWORK ADAPTER INFORMATION    "
  .\lab3.ps1 | Format-List
}

#Function To Display Graphical Processing Unit Information

function gpu_info {
"    GPU INFORMATION    "
Get-WmiObject win32_videocontroller | Select-Object name, description, videomodedescription | Format-Table
"============================================================"}

hard_info
op_sys
pro_info
mem_stat
disk_info
netadt_info
gpu_info