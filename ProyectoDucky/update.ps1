$info = "--- REPORTE DE SISTEMA ---`n"
$info += "Usuario: $env:USERNAME`n"
$info += "Equipo: $env:COMPUTERNAME`n"

# Corregido: Se simplifica la obtención de la IP para evitar errores de objetos vacíos
$ip = (Get-NetIPInterface | Where-Object { $_.ConnectionState -eq 'Connected' -and $_.IPv4Address -ne $null } | Select-Object -First 1).IPv4Address.IPAddress

if ($ip) { 
    $info += "IP Interna: $ip`n" 
} else { 
    $info += "IP Interna: No detectada`n" 
}

# Corregido: Uso de Get-CimInstance para CPU y RAM (más moderno y estable que Get-WmiObject)
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1 | Select-Object -ExpandProperty Name
$info += "CPU: $cpu`n"

$mem = Get-CimInstance Win32_OperatingSystem | Select-Object -First 1
$totalRam = [math]::Round($mem.TotalVisibleMemorySize / 1MB, 2)
$info += "RAM: $totalRam GB`n"

$info += "Fecha: $(Get-Date)`n"

# Crear el archivo en el escritorio
$path = "$env:USERPROFILE\Desktop\system_info.txt"
$info | Out-File -FilePath $path -Encoding utf8
