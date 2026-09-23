@echo off
chcp 65001 >nul 2>&1
color 0B
title Deploy O Novo Apetite - Step 2: Push para GitHub
cls

echo.
echo ================================================
echo    STEP 2: FAZER PUSH PARA GITHUB
echo ================================================
echo.

cd /d "%~dp0"

echo [*] Pedindo dados do repositório GitHub...
echo.
set /p github_url="Cole a URL do seu repositório (https://github.com/usuario/o-novo-apetite.git): "

if "%github_url%"=="" (
    echo [ERRO] URL não pode estar vazia!
    pause
    exit /b 1
)

echo.
echo [*] Adicionando remote origin...
git remote add origin %github_url%

echo [*] Fazendo push para main branch...
git branch -M main
git push -u origin main

if errorlevel 1 (
    echo.
    echo [ERRO] Falha no push! Pode ser:
    echo - URL incorreta
    echo - Sem acesso ao repositório
    echo - Credenciais inválidas
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Push realizado com sucesso!
echo.
echo ================================================
echo    STEP 3: CONECTAR AO VERCEL
echo ================================================
echo.
echo [ATENÇÃO] Agora você precisa:
echo.
echo 1. Abrir: https://vercel.com/dashboard
echo 2. Clicar em "Add New" > "Project"
echo 3. Clicar em "Import Git Repository"
echo 4. Procurar por "o-novo-apetite"
echo 5. Framework: "Other" (ou deixar em branco)
echo 6. Build Command: echo "Static site"
echo 7. Output Directory: . (ponto)
echo 8. Clique em "Deploy"
echo.
echo [AGUARDANDO] Você fez o deploy no Vercel? (s/n)
choice /c sn /t 120 /d s

if errorlevel 2 exit /b 0
if errorlevel 1 (
    echo.
    echo [OK] Finalizando...
    call "3-TESTAR-SITE.bat"
)
