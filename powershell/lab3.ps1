get-ciminstance win32_networkadapterconfiguration | 
where-object ipenabled -eq 'True' | 
format-table @{n="ADPTDescription" ; width =50 ; e={$_.description}},
@{n="Index" ;width =6 ; e={$_.index}},
@{n="IPAddress" ; width = 50 ; e={$_.ipaddress}},
@{n="Subnetmask" ; width = 25 ; e={$_.ipsubnet}},
@{n="DNSDomain" ; width = 25 ; e={$_.DNSDomain}},
@{n="DNSServer" ; width = 25 ; e={$_.DNSServerSearchOrder}}