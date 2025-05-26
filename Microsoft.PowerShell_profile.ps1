# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Load prompt config
oh-my-posh init pwsh -c "$env:USERPROFILE\Documents\PowerShell\kurt.omp.json" | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Invoke-Expression (& { (zoxide init powershell | Out-String) }) # FZF
Enable-PoshTransientPrompt # Transient Prompt (duh)

# Aliases
Set-Alias v nvim
Set-Alias c clear
# Utilities
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
		Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
function open ($command) {
	Start-Process ((Resolve-Path $command).Path)
}

function .. (){
	$dest = Split-Path -Path $pwd -Parent
	Set-Location $dest
}

function ll (){
	erd --suppress-size -y inverted -L 1 -s name
}

function lt (){
	erd --truncate --suppress-size -f -y inverted -s name
	#eza --icons --no-permissions -l --no-time --no-filesize -s=extension -T
}

function lh (){
	erd --truncate --suppress-size -L 1 -s name -.
}

function ZZ {
	Invoke-command -ScriptBlock {exit}
}

function cwd(){
    'cd "' + $pwd + '"' | Set-Clipboard
    Write-Output "Copied!"
}

function gq(){
	git add -A;
	git commit -m (Get-Date -UFormat "%d %b %R");
	git push;
}

colortool -q -x miasma.itermcolors
