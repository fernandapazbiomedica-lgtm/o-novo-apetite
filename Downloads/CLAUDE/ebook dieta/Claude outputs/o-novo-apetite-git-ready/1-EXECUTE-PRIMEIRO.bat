@echo off
chcp 65001 >nul 2>&1
color 0B
title Deploy O Novo Apetite - Step 1: Git Setup
cls

echo.
echo ================================================
echo    STEP 1: SETUP GIT INICIAL
echo ================================================
echo.

cd /d "%~dp0"

if not exist ".git" (
    echo [*] Inicializando repositório Git...
    git init
    git config user.name "Mario Deploy"
    git config user.email "mariolucas0501@gmail.com"
    git add .
    git commit -m "Initial commit - O Novo Apetite Vercel ready"
    echo [OK] Repositório Git criado!
) else (
    echo [OK] Repositório Git já existe
)

echo.
echo ================================================
echo    STEP 2: CRIAR REPOSITÓRIO NO GITHUB
echo ================================================
echo.
echo [ATENÇÃO] Você precisa:
echo.
echo 1. Abrir: https://github.com/new
echo 2. Preencher assim:
echo    - Repository name: o-novo-apetite
echo    - Description: Novo Apetite - Ebook Receitas Fitness
echo    - Public (deixar público)
echo 3. Clique em "Create repository"
echo.
echo [AGUARDANDO] Você criou o repositório? (s/n)
choice /c sn /t 60 /d s

if errorlevel 2 exit /b 0
if errorlevel 1 goto :continue

:continue
echo.
echo [OK] Continuando...
pause
call "2-PUSH-PARA-GITHUB.bat"
