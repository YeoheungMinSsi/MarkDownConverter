param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile
)

$pythonPath = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"
if (-not (Test-Path -LiteralPath $pythonPath -PathType Leaf)) {
    throw "Python not found: $pythonPath"
}

& $pythonPath "$PSScriptRoot\convert.py" $InputFile
exit $LASTEXITCODE
