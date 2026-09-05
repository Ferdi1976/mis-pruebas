$info = "--- Reporte de Sistema ---`n"
$info += "Usuario: " + $env:USERNAME + "`n"
$info += "Equipo: " + $env:COMPUTERNAME + "`n"
$info += "IP Interna: " + (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' }).IPAddress[0]
$info += "Fecha: " + (Get-Date)
$path = "$env:USERPROFILE\Desktop\system_info.txt"
$info | Out-File -FilePath $path
