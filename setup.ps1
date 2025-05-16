function CopyConfig
{
    Copy-Item `
        ".\windows\powershell\profile7.ps1" `
        "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" `
        -Force

    Copy-Item `
        ".\windows\powershell\profile5.ps1" `
        "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" `
        -Force

    Copy-Item `
        ".\common\ripgrep" `
        "$env:APPDATA\." `
        -Recurse -Force
}
CopyConfig
