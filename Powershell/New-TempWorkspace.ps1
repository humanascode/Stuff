
# A function to quickly create a new workspace folder and launch VS Code in it
# Usage: New-TempWorkspace -Subject "MyProject" -WorkspacePath "C:\MyWorkspaces"
# If no Subject is provided, it defaults to "General"
# If no WorkspacePath is provided, it defaults to "C:\Temp\TemporaryWorkspaces"
# Recommended to add this function to your PowerShell profile so it's always available:
# Notepad $PROFILE paste this function at the end of the file, save and close, then restart PowerShell
function New-TempWorkspace () {
    param (
        [Parameter(Mandatory=$false)][String]$Subject,
        [Parameter(Mandatory=$false)][String]$WorkspacePath = "$($env:SystemDrive)\Temp\TemporaryWorkspaces"
    )

    if ($Subject -eq "") {
        $Subject = "General"
    }

    if (-not (Test-Path $WorkspacePath)) {
        $answer = Read-Host "The workspace path $WorkspacePath does not exist. Would you like to create it? (Y/N)"
        if ($answer -eq "Y" -or $answer -eq "y") {
            New-Item -ItemType Directory -Path $WorkspacePath
        } else {
            Write-Output "Exiting..."
            return
        }
    }

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $folderName = "$timestamp-$Subject"
    New-Item -ItemType Directory -Path $WorkspacePath -Name $folderName
    Write-Output "Created new workspace at $WorkspacePath\$folderName"
    code $WorkspacePath/$folderName
}