$arch = (Get-WmiObject Win32_Processor).Architecture
if ($arch -eq 9) {
  $url = "https://raw.githubusercontent.com/sohan-14/flurx/main/fbinaries/flurx-windows-x86_64/flurx.exe"
} else {
  Write-Error "Unsupported architecture for Windows: $arch"
  exit 1
}

Invoke-WebRequest -Uri $url -OutFile "$env:ProgramFiles\flurx.exe"
# Add to PATH or instruct user to add manually
Write-Host "flurx installed successfully at $env:ProgramFiles\flurx.exe"
