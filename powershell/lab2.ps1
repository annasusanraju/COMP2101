function get-cpuinfo{
get-ciminstance -computername $i.DNShostname -class cim_processor | format-list Manufacturer, Name, CurrentClockSpeed, MaxClockSpeed, NumberOfCores
}
get-cpuinfo
