$info = "--- REPORTE DE SISTEMA ---`n"
$info += "Usuario: $env:USERNAME`n"
$info += "Equipo: $env:COMPUTERNAME`n"
$ip = (Get-NetIPInterface -InterfaceAlias "Wi-Fi", "Ethernet" | Where-Object { $_.ConnectionState -eq 'Connected' } | Select-Object -First 1).IPv4Address.IPAddress
if ($ip) { $info += "IP Interna: $ip`n" } else { $info += "IP Interna: No detectada`n" }
$info += "CPU: $($wmi = Get-WmiObject Win32_Processor | Select-Object -First 1).Name`n"
$info += "RAM: $(Get-CimInstance Win32_OperatingSystem | Select-Object -First 1).TotalVisibleMemorySize / 1MB GB`n"
$info += "Fecha: $(Get-Date)`n"

$path = "$env:USERPROFILE\Desktop\system_info.txt"
$info | Out-File -FilePath $path -Encoding utf8

