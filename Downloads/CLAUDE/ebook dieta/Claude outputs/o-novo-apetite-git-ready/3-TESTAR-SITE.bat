@echo off
chcp 65001 >nul 2>&1
color 0B
title Deploy O Novo Apetite - Step 3: Testar Site
cls

echo.
echo ================================================
echo    STEP 3: TESTAR SITE
echo ================================================
echo.

echo [*] Abrindo o Chrome para testar...
echo.
start chrome https://o-novo-apetite.vercel.app

echo.
echo [INFO] O site pode levar 30-60 segundos para ficar pronto.
echo.
echo Testando:
echo 1. Homepage (raiz)
echo 2. Landing Page Ebook: /50receitasfitness/
echo 3. Blog: /blog/
echo.
echo [*] Se vir o design completo com fundo escuro, menu, etc = SUCESSO!
echo [*] Se vir código base64 = ainda está processando, aguarde mais 30s
echo.
pause

echo.
echo ================================================
echo    FINALIZADO!
echo ================================================
echo.
echo Se o site renderizou corretamente:
echo.
echo Próximos passos:
echo 1. Conectar domínio onovoapetite.com.br (Vercel > Domains)
echo 2. Configurar DNS no Registro.br
echo 3. Preparar campanhas Meta Ads
echo 4. Iniciar tráfego pago
echo.
pause
