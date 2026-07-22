param(
    [string]$Version = '1.3.14',
    [switch]$VerifyOnly
)

$ErrorActionPreference = 'Stop'

if (-not [Environment]::Is64BitOperatingSystem) {
    throw 'Formulae Bun preload supports only Windows x64'
}
if ($Version -ne '1.3.14') {
    throw "No checksum lock recorded for Bun $Version"
}

$installRoot = if ($env:BUN_INSTALL) {
    $env:BUN_INSTALL
} else {
    Join-Path $env:USERPROFILE '.bun'
}
$binDir = Join-Path $installRoot 'bin'
$bunPath = Join-Path $binDir 'bun.exe'

function Get-BunVersion {
    if (-not (Test-Path -LiteralPath $bunPath -PathType Leaf)) {
        return $null
    }
    return (& $bunPath --version).Trim()
}

$actual = Get-BunVersion
if ($actual -eq $Version) {
    $binDir | Out-File -FilePath $env:GITHUB_PATH -Encoding utf8 -Append
    Write-Host "Using Bun $Version at $bunPath"
    exit 0
}
if ($VerifyOnly) {
    throw "Bun $Version is not preloaded; run the preload-jwt-pool maintenance lane"
}

$url = 'https://github.com/oven-sh/bun/releases/download/bun-v1.3.14/bun-windows-x64.zip'
$expectedSha256 = '0a0620930b6675d7ba440e81f4e0e00d3cfbe096c4b140d3fff02205e9e18922'
$tempRoot = Join-Path ([IO.Path]::GetTempPath()) ("formulae-bun-" + [guid]::NewGuid())
$archive = Join-Path $tempRoot 'bun-windows-x64.zip'
$extractRoot = Join-Path $tempRoot 'extract'

try {
    New-Item -ItemType Directory -Path $tempRoot, $extractRoot -Force | Out-Null
    Invoke-WebRequest -Uri $url -OutFile $archive -UseBasicParsing
    $actualSha256 = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actualSha256 -ne $expectedSha256) {
        throw "Bun checksum mismatch: $actualSha256 != $expectedSha256"
    }

    Expand-Archive -LiteralPath $archive -DestinationPath $extractRoot -Force
    $candidates = @(Get-ChildItem -LiteralPath $extractRoot -Filter bun.exe -File -Recurse)
    if ($candidates.Count -ne 1) {
        throw "Expected one bun.exe in archive, found $($candidates.Count)"
    }

    New-Item -ItemType Directory -Path $binDir -Force | Out-Null
    $temporary = "$bunPath.tmp"
    Copy-Item -LiteralPath $candidates[0].FullName -Destination $temporary -Force
    Move-Item -LiteralPath $temporary -Destination $bunPath -Force

    $actual = Get-BunVersion
    if ($actual -ne $Version) {
        throw "Bun version drift after preload: $actual != $Version"
    }
    $binDir | Out-File -FilePath $env:GITHUB_PATH -Encoding utf8 -Append
    Write-Host "Installed Bun $actual at $bunPath"
} finally {
    Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
}
