# ============================================================

# PRUEBA COMPLETA - Pico 2 W

# Acción local + notificación fija al Webhook

# ============================================================

# ---------- CONFIGURACIÓN ----------

$webhook = 'https://webhook.site/b3aa1247-a97d-4e0a-8f8a-6cd482da3330'
$path = "$env:USERPROFILE\Desktop\PICO2W_TEST"

# ---------- 1. CREAR CARPETA ----------

if (!(Test-Path $path)) {
New-Item -Path $path -ItemType Directory | Out-Null
}

# ---------- 2. CREAR INFORME ----------

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

# ---------- 3. ENVIAR AVISO FIJO AL WEBHOOK ----------

$mensaje = "PICO2W_TEST_OK"

try {
Invoke-WebRequest `        -UseBasicParsing`
-Uri $webhook `        -Method POST`
-Body $mensaje `
-ErrorAction Stop

```
$webhookResultado = "Webhook: OK"
```

}
catch {
$webhookResultado = "Webhook: ERROR"
}

# ---------- 4. GUARDAR RESULTADO ----------

Add-Content "$path\resultado.txt" ""
Add-Content "$path\resultado.txt" $webhookResultado

# ---------- 5. MOSTRAR RESULTADO ----------

Add-Type -AssemblyName System.Windows.Forms

[System.Windows.Forms.MessageBox]::Show(
"Prueba completada.`n`nCarpeta: PICO2W_TEST`n$webhookResultado",
"Pico 2 W - Prueba"
)
