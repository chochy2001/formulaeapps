$ErrorActionPreference = 'Stop'

$gitBash = 'C:\Program Files\Git\bin\bash.exe'
if (-not (Test-Path -LiteralPath $gitBash -PathType Leaf)) {
    throw "Git Bash is required at $gitBash"
}

& $gitBash --version
if ($LASTEXITCODE -ne 0) {
    throw 'Git Bash version check failed'
}

# Add the real executable directory instead of a .cmd shim. Bun/Node child
# processes resolve an actual bash.exe directly and do not consistently honor
# command-shell shims; leaving System32 ahead of Git would select the WSL
# launcher on this dual Windows/WSL workstation.
$gitBashDir = Split-Path -Parent $gitBash
$gitBashDir | Out-File -FilePath $env:GITHUB_PATH -Encoding utf8 -Append

$python = 'C:\Python312\python.exe'
if (-not (Test-Path -LiteralPath $python -PathType Leaf)) {
    throw "Python is required at $python"
}
$pythonDir = Split-Path -Parent $python
$pythonDir | Out-File -FilePath $env:GITHUB_PATH -Encoding utf8 -Append

$cacheDir = Join-Path $env:RUNNER_TOOL_CACHE ("bun-install-cache\formulae\" + $env:GITHUB_JOB)
New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
@(
    "BASH_BIN=$gitBash"
    "PYTHON3_BIN=$python"
    "BUN_INSTALL_CACHE_DIR=$cacheDir"
) | Out-File -FilePath $env:GITHUB_ENV -Encoding utf8 -Append

Write-Host "Git Bash activated from $gitBashDir"
Write-Host "Python activated from $pythonDir"
Write-Host "Bun cache isolated at $cacheDir"
