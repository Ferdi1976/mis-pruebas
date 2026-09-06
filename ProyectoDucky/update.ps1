$webhook = 'https://webhook.site/c712d334-352a-4bea-b44b-9d94dbe4dede'
$path = "$env:USERPROFILE\Desktop\PICO2W_TEST"

if (!(Test-Path $path)) {
New-Item -Path $path -ItemType Directory | Out-Null
}

$fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

"PRUEBA PICO 2 W" | Set-Content "$path\resultado.txt"
"Fecha: $fecha" | Add-Content "$path\resultado.txt"
"Resultado: EJECUCIÓN CORRECTA" | Add-Content "$path\resultado.txt"

"OK" | Set-Content "$path\OK.txt"

$mensaje = "PICO2W_TEST_OK"

try {
Invoke-WebRequest -UseBasicParsing -Uri $webhook -Method POST -Body $mensaje -ErrorAction Stop
"Webhook: OK" | Add-Content "$path\resultado.txt"
}
catch {
"Webhook: ERROR" | Add-Content "$path\resultado.txt"
}

Add-Type -AssemblyName System.Windows.Forms

[System.Windows.Forms.MessageBox]::Show(
"PICO 2 W: prueba completada correctamente",
"Pico 2 W - TEST"
)
