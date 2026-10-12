param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $InputFile -PathType Leaf)) {
    throw "Input file not found: $InputFile"
}

$pythonPath = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"
if (-not (Test-Path -LiteralPath $pythonPath -PathType Leaf)) {
    $pythonCommand = Get-Command py -ErrorAction SilentlyContinue
    if (-not $pythonCommand) {
        $pythonCommand = Get-Command python -ErrorAction SilentlyContinue
    }
    if (-not $pythonCommand) {
        throw "Install Python first: https://www.python.org/downloads/"
    }

    Write-Host "Creating virtual environment..."
    & $pythonCommand.Source -m venv "$PSScriptRoot\.venv"
    if ($LASTEXITCODE -ne 0) {
        throw "Virtual environment creation failed. Check your Python installation."
    }
}

& $pythonPath -m pip show docling *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Installing dependencies (first run may take several minutes)..."
    & $pythonPath -m pip install -r "$PSScriptRoot\requirements.txt"
    if ($LASTEXITCODE -ne 0) {
        throw "Dependency installation failed. Check the output and your network connection."
    }
}

& $pythonPath "$PSScriptRoot\convert.py" $InputFile
exit $LASTEXITCODE
