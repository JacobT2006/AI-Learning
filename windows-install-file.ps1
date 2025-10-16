# Requires PowerShell 7+
# Run this script as Administrator

Write-Host "Starting installation of Docker, Node.js (LTS), and Google Gemini CLI..." -ForegroundColor Cyan

# --- Function to check if a command exists ---
function Command-Exists {
    param([string]$cmd)
    $null -ne (Get-Command $cmd -ErrorAction SilentlyContinue)
}

# --- Ensure script runs as Administrator ---
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Not running as administrator. Relaunching with admin privileges..."
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Check for winget ---
if (-not (Command-Exists "winget")) {
    Write-Host "Winget not found. Installing manually is recommended (available in latest Windows 10/11 updates)." -ForegroundColor Yellow
}

# --- Install Docker Desktop ---
if (-not (Command-Exists "docker")) {
    Write-Host "🐳 Installing Docker Desktop..."
    if (Command-Exists "winget") {
        winget install --id Docker.DockerDesktop -e --accept-package-agreements --accept-source-agreements
    } else {
        $dockerUrl = "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe"
        $installerPath = "$env:TEMP\DockerInstaller.exe"
        Invoke-WebRequest -Uri $dockerUrl -OutFile $installerPath
        Start-Process -FilePath $installerPath -Wait
        Remove-Item $installerPath
    }
} else {
    Write-Host "✅ Docker already installed."
}

# --- Install Node.js (LTS) ---
if (-not (Command-Exists "node")) {
    Write-Host "📦 Installing Node.js (LTS)..."
    if (Command-Exists "winget") {
        winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements
    } else {
        $nodeUrl = "https://nodejs.org/dist/latest-v18.x/node-v18.19.0-x64.msi"
        $nodeInstaller = "$env:TEMP\node-lts.msi"
        Invoke-WebRequest -Uri $nodeUrl -OutFile $nodeInstaller
        Start-Process msiexec.exe -ArgumentList "/i $nodeInstaller /qn" -Wait
        Remove-Item $nodeInstaller
    }
} else {
    Write-Host "✅ Node.js already installed."
}

# --- Refresh PATH ---
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# --- Install Google Gemini CLI ---
if (-not (Command-Exists "gemini")) {
    Write-Host "✨ Installing Google Gemini CLI..."
    npm install -g @google/gemini-cli
} else {
    Write-Host "✅ Google Gemini CLI already installed."
}

# --- Verify installations ---
Write-Host "`n🔍 Verifying installations..."
docker --version
node --version
npm --version
gemini --version

Write-Host "`n✅ Installation complete!" -ForegroundColor Green
Write-Host "Run 'gemini auth login' to connect your Google account."
