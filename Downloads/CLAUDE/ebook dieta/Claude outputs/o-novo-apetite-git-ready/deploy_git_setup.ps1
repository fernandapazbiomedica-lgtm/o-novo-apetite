# Script de Deploy - O Novo Apetite
# Este script configura Git, cria repositório local e faz push para GitHub

Write-Host "================================================" -ForegroundColor Green
Write-Host "   SETUP DEPLOY - O NOVO APETITE" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

# Verificar se estamos na pasta correta
$currentPath = Get-Location
if ($currentPath -notmatch "deploy-vercel") {
    Write-Host "❌ Por favor, execute este script DENTRO da pasta deploy-vercel" -ForegroundColor Red
    Write-Host "Pasta atual: $currentPath" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Pasta correta: $currentPath" -ForegroundColor Green
Write-Host ""

# Configurar Git
Write-Host "📝 Configurando Git..." -ForegroundColor Cyan
git config user.name "Mario Deploy"
git config user.email "mariolucas0501@gmail.com"

Write-Host "✅ Git configurado" -ForegroundColor Green
Write-Host ""

# Inicializar repositório se não existir
if (-not (Test-Path ".git")) {
    Write-Host "📦 Inicializando repositório Git..." -ForegroundColor Cyan
    git init
    git add .
    git commit -m "Initial commit - O Novo Apetite site ready for Vercel deployment"
    Write-Host "✅ Repositório criado" -ForegroundColor Green
} else {
    Write-Host "✅ Repositório Git já existe" -ForegroundColor Green
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "   PRÓXIMOS PASSOS" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""
Write-Host "1. Crie um repositório vazio no GitHub:"
Write-Host "   - Acesse https://github.com/new"
Write-Host "   - Nome: o-novo-apetite"
Write-Host "   - Descrição: Novo Apetite - Ebook Receitas Fitness"
Write-Host "   - Deixe como PUBLIC"
Write-Host "   - Clique em 'Create repository'" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Após criar, copie o comando de push do GitHub" -ForegroundColor Yellow
Write-Host "   Deve ser algo como:"
Write-Host "   git remote add origin https://github.com/seu-usuario/o-novo-apetite.git" -ForegroundColor Cyan
Write-Host "   git branch -M main" -ForegroundColor Cyan
Write-Host "   git push -u origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Volte aqui e execute os comandos acima (cole no PowerShell)" -ForegroundColor Yellow
Write-Host ""
Write-Host "4. Depois, conecte ao Vercel:" -ForegroundColor Yellow
Write-Host "   - Acesse https://vercel.com/dashboard" -ForegroundColor Cyan
Write-Host "   - Clique em 'Add New' > 'Project'" -ForegroundColor Cyan
Write-Host "   - Selecione 'Import Git Repository'" -ForegroundColor Cyan
Write-Host "   - Procure por 'o-novo-apetite'" -ForegroundColor Cyan
Write-Host "   - Framework: Other (ou deixar em branco)" -ForegroundColor Cyan
Write-Host "   - Clique em 'Deploy'" -ForegroundColor Cyan
Write-Host ""
Write-Host "5. Aguarde 2-3 minutos e teste:" -ForegroundColor Yellow
Write-Host "   https://o-novo-apetite.vercel.app" -ForegroundColor Cyan
Write-Host ""
Write-Host "================================================" -ForegroundColor Green

pause
