New-Alias "c" Clear-Host

function prompt
{
    Write-Host ">" -BackgroundColor white -ForegroundColor black -NoNewline
    " "
}

function SetupBase
{
    # REF:
    #   https://stackoverflow.com/questions/8360215/use-ctrl-d-to-exit-and-ctrl-l-to-cls-in-powershell-console
    Set-PSReadlineOption -EditMode Emacs
}
SetupBase

function SetupFzf
{
    $s = ""
    $s +="--reverse --height 79%"
    $s += " --color "
    $s += "bg:-1,fg:-1,"
    $s += "bg+:8,fg+:-1:regular,"
    $s += "hl:5,"
    $s += "hl+:5:regular"

    $s += " --color header:7"
    # $s += " --header-first"  # header before prompt

    $s += " --color pointer:15:regular"  # current cursor-line
    $s += " --pointer ''"  # hide pointer

    $s += " --color marker:7:regular"  # selected in multi
    $s += " --marker '+ '"
    $s += " --marker-multi-line '+| '"

    $s += " --color prompt:7:regular"
    $s += " --prompt '> '"
    $s += " --color query:-1:regular"  # actual input

    $s += " --color "
    $s += "spinner:7:regular,"
    $s += "info:7"  # counter of matches & (multi-)selections

    $s += " --color separator:7"  # line after |info|
    $s += " --no-separator"  # hide completely

    $s += " --color "
    $s += "border:8,"
    $s += "gutter:-1,"
    $s += "scrollbar:7"
    $env:FZF_DEFAULT_OPTS = $s

    $s = ""
    $S += "--prompt='% '"
    $env:FZF_COMPLETION_OPTS = $s
}
SetupFzf

function SetupRg
{
    $env:RIPGREP_CONFIG_PATH = "$HOME\AppData\Roaming\ripgrep\config"
}
SetupRg

function RunLf
{
    powershell.exe -Command {
        $env:SHELL="pwsh.exe"
        $env:EDITOR="nvim.exe -O"
        lf.exe
    }
}
New-Alias "lf" RunLf

function SetupKomorebi
{
    # REF:
    #   https://lgug2z.github.io/komorebi/common-workflows/komorebi-config-home.html
    $env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"
}
SetupKomorebi

New-Alias "g" git
