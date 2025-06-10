# install.ps1
param(
    [string]$InstallPath = "$env:USERPROFILE\AppData\Local\flurx"
)

# Detect architecture
$arch = (Get-CimInstance Win32_Processor).Architecture
switch ($arch) {
    0 { $archStr = "x86" }
    9 { $archStr = "x86_64" }
    default {
        Write-Error "Unsupported architecture: $arch"
        exit 1
    }
}

$binaryUrl = "https://raw.githubusercontent.com/sohan-14/flurx/main/fbinaries/flurx-windows-$archStr/flurx.exe"

Write-Host "Downloading flurx from $binaryUrl ..."

# Create install directory
if (-Not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath | Out-Null
}

# Download binary
$binaryPath = Join-Path $InstallPath "flurx.exe"
Invoke-WebRequest -Uri $binaryUrl -OutFile $binaryPath

Write-Host "Downloaded to $binaryPath"

# Add install path to user PATH if not already added
$envPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if (-not $envPath.Split(";") -contains $InstallPath) {
    Write-Host "Adding $InstallPath to user PATH"
    [Environment]::SetEnvironmentVariable("PATH", "$envPath;$InstallPath", "User")
    Write-Host "You may need to restart your terminal or log out/in for PATH changes to take effect."
}

Write-Host "flurx installed successfully! Run 'flurx.exe' from any terminal."
