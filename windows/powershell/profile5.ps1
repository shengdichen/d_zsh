New-Alias "c" Clear-Host

function prompt
{
    ">= "
}

function SetupBase
{
    # REF:
    #   https://stackoverflow.com/questions/8360215/use-ctrl-d-to-exit-and-ctrl-l-to-cls-in-powershell-console
    Set-PSReadlineOption -EditMode Emacs
}
SetupBase

function RunLf
{
    powershell.exe -Command {
        $env:SHELL="powershell.exe"
        $env:EDITOR="nvim.exe -O"
        lf.exe
    }
}
New-Alias "lf" RunLf
