# =============================================
# DevOps Lab 2 - Automation Setup Script (Windows PowerShell)
# Sinh vien: Ma Quoc Dan - MSSV: DTC235180041
# =============================================
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  DevOps Lab 2 - Auto Environment Setup" -ForegroundColor Cyan
Write-Host "  Sinh vien: Ma Quoc Dan - DTC235180041" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/4] Checking prerequisites..." -ForegroundColor Yellow
$git = Get-Command git -ErrorAction SilentlyContinue
if ($git) {
    Write-Host "  [OK] Git: $(git --version)" -ForegroundColor Green
} else {
    Write-Host "  [FAIL] Git not found - install from https://git-scm.com/" -ForegroundColor Red
}

$node = Get-Command node -ErrorAction SilentlyContinue
if ($node) {
    Write-Host "  [OK] Node.js: $(node --version)" -ForegroundColor Green
} else {
    Write-Host "  [WARN] Node.js not found (optional)" -ForegroundColor Yellow
}

$code = Get-Command code -ErrorAction SilentlyContinue
if ($code) {
    Write-Host "  [OK] VS Code: $(code --version | Select-Object -First 1)" -ForegroundColor Green
} else {
    Write-Host "  [WARN] VS Code not found in PATH" -ForegroundColor Yellow
}

Write-Host "[2/4] Creating project structure..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path src,tests,docs | Out-Null
Write-Host "  [OK] Created directories: src/ tests/ docs/" -ForegroundColor Green

Write-Host "[3/4] Checking Git repository..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    git init
    Write-Host "  [OK] Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "  [INFO] Git already initialized" -ForegroundColor Yellow
}

Write-Host "[4/4] Generating config files..." -ForegroundColor Yellow
$gitignoreContent = @"
node_modules/
.env
*.log
.DS_Store
dist/
.vscode/
"@
$gitignoreContent | Out-File -FilePath .gitignore -Encoding UTF8 -Force
Write-Host "  [OK] .gitignore created" -ForegroundColor Green

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "  SETUP COMPLETE!" -ForegroundColor Green
Write-Host "  Project is ready at: $(Get-Location)" -ForegroundColor White
Write-Host "=========================================" -ForegroundColor Green
