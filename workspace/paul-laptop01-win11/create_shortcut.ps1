# Brindar accesos de ejecución

param (
    [string]$HostMain,
    [string]$Environment,
    [string]$Action,
    [string]$HostVM,
    [string]$Workspace
)

# Obtener la ruta del escritorio del usuario actual
$desktopPath = [Environment]::GetFolderPath('Desktop')

# Definir la variable $Workspace si no existe
if (-not $PSBoundParameters.ContainsKey('Workspace')) {
    $Workspace = ""
}

$name_link = $Environment
if ($Workspace -ne "") {
    # Usar una expresión regular para eliminar la IP
    $output = $HostVM -replace '-\d{1,3}(\.\d{1,3}){3}', ''
    # Convertir la salida a minúsculas
    $output = $output.ToLower()    
    $name_link = $output+"-"+$Workspace
}

# Mostrar el resultado
Write-Output "name_link: '$name_link'"

# # Ruta del acceso directo
$shortcutPath = $desktopPath+"\"+$name_link+".lnk"

Write-Output $shortcutPath
# # Crear un objeto COM para interactuar con el acceso directo
$shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($shortcutPath)

# # Modificar la propiedad 'Target' para incluir parámetros
$shortcut.TargetPath = "P:\VMS\infra-tools-getstart\workspace\paul-laptop01\mv_run.bat"
$shortcut.Arguments = "paul-laptop01 "+$Environment+" "+$Action+" "+$HostVM+" "+$Workspace

# # Modificar la propiedad 'IconLocation' para cambiar el icono
# # La ruta debe ser la ruta completa al archivo de icono (.ico) o un archivo ejecutable (.exe) que contenga el icono
# $shortcut.IconLocation = "C:\Path\To\Your\Icon.ico"

$shortcut.Save()

# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#.\create_shortcut.ps1 -HostMain "paul-laptop01" -Environment "w001" -Action "up" -HostVm "W001-APP-192.168.56.30" -Workspace "cashback"
#.\create_shortcut.ps1 -HostMain "paul-laptop01" -Environment "w001" -Action "up" -HostVm "W001-APP-192.168.56.30"
#.\create_shortcut.ps1 -HostMain "paul-laptop01" -Environment "SANDBOX" -Action "up"