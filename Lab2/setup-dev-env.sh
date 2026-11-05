#!/bin/bash
# =============================================
# DevOps Lab 2 — Automation Setup Script (Linux/macOS/Bash)
# Sinh viên: Ma Quốc Đan - MSSV: DTC235180041
# =============================================

echo "========================================="
echo "  🚀 DevOps Lab 2 — Auto Environment Setup"
echo "  👤 Sinh viên: Ma Quốc Đan - DTC235180041"
echo "========================================="
echo ""

echo "[1/4] Checking prerequisites..."
if command -v git &> /dev/null; then
    echo "  ✅ Git: $(git --version)"
else
    echo "  ❌ Git not found"
fi

if command -v node &> /dev/null; then
    echo "  ✅ Node.js: $(node -v)"
else
    echo "  ⚠️  Node.js not found (optional)"
fi

if command -v code &> /dev/null; then
    echo "  ✅ VS Code: $(code -v | head -n 1)"
else
    echo "  ⚠️  VS Code not found"
fi

echo "[2/4] Creating project structure..."
mkdir -p src tests docs
echo "  ✅ Created directories: src/ tests/ docs/"

echo "[3/4] Checking Git repository..."
if [ ! -d ".git" ]; then
    git init
    echo "  ✅ Git repository initialized"
else
    echo "  ⚠️  Git already initialized"
fi

echo "[4/4] Generating config files..."
cat << 'EOF' > .gitignore
node_modules/
.env
*.log
.DS_Store
dist/
.vscode/
EOF
echo "  ✅ .gitignore created"

echo ""
echo "========================================="
echo "  ✅ SETUP COMPLETE!"
echo "  Project is ready at: $(pwd)"
echo "========================================="
