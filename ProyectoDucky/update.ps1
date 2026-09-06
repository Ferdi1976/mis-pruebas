# ============================================================

# PRUEBA COMPLETA - Pico 2 W

# ============================================================

$webhook = 'https://webhook.site/b3aa1247-a97d-4e0a-8f8a-6cd482da3330'
$path = "$env:USERPROFILE\Desktop\PICO2W_TEST"

# Crear carpeta

if (!(Test-Path $path)) {
New-Item -Path $path -ItemType Directory | Out-Null
}

# Crear informe

$fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$contenido = @"
PRUEBA DE EJECUCIÓN
===================

Programa: update.ps1
Dispositivo: Pico 2 W
Fecha y hora: $fecha

Resultado: EJECUCIÓN CORRECTA
"@

$contenido | Set-Content "$path\resultado.txt"
"OK - prueba completada" | Set-Content "$path\OK.txt"

# Enviar mensaje fijo al Webhook

$mensaje = "PICO2W_TEST_OK"

try {
$respuesta = Invoke-WebRequest -UseBasicParsing -Uri $webhook -Method POST -Body $mensaje -ErrorAction Stop
$webhookResultado = "Webhook: OK"
}
catch {
$webhookResultado = "Webhook: ERROR"
}

# Guardar resultado del Webhook

Add-Content "$path\resultado.txt" ""
Add-Content "$path\resultado.txt" $webhookResultado

# Mostrar resultado

Add-Type -AssemblyName System.Windows.Forms

[System.Windows.Forms.MessageBox]::Show(
"Prueba completada.`n`nCarpeta: PICO2W_TEST`n$webhookResultado",
"Pico 2 W - Prueba"
)

