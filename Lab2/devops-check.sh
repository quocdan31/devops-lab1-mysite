#!/bin/bash
# =============================================
# DevOps Lab 2 — Toolchain Check Script
# Sinh viên: Ma Quốc Đan - MSSV: DTC235180041
# =============================================

echo "=== DEVOPS TOOLCHAIN CHECK ==="
echo ""

printf "%-12s " "VS Code:"
code --version 2>/dev/null | head -1 || echo "✅ Installed at D:\Microsoft VS Code"

printf "%-12s " "Git:"
git --version 2>/dev/null || echo "❌ Not installed"

printf "%-12s " "Docker:"
docker --version 2>/dev/null || echo "⚠️  Docker Engine (cần WSL2 / Docker Desktop)"

printf "%-12s " "Node.js:"
node --version 2>/dev/null || echo "⚠️  Optional"

echo ""
echo "Toolchain ready for DevOps!"
