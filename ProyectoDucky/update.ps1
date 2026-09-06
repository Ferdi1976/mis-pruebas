# Crear una carpeta en el escritorio llamada "HACKEO_EXITOSO"
$path = "$env:USERPROFILE\Desktop\HACKEO_EXITOSO"

if (!(Test-Path $path)) {
    New-Item -Path $path -ItemType Directory
    # Crear un archivo de texto dentro para confirmar
    echo "El sistema ha sido ejecutado con éxito" > "$path\info.txt"
}

# También vamos a abrir una ventana de mensaje para que veas que funcionó
[System.Windows.Forms.MessageBox]::Show("Acceso concedido", "Sistema")
