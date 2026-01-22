#!/bin/bash

# Cores para o status
AZUL='\033[0;34m'
VERDE='\033[0;32m'
AMARELO='\033[1;33m'
SEM_COR='\033[0m'

echo -e "${AZUL}=== INICIANDO FAXINA DE ENGENHARIA ===${SEM_COR}"

# 1. Limpando lixo do Python (__pycache__)
echo -n "-> Removendo arquivos temporários do Python... "
# Busca e remove pastas __pycache__ no diretório de projetos
find /home/kali/projetos/ -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
echo -e "${VERDE}[OK]${SEM_COR}"

# 2. Compactando a pasta de backups
if [ -d "/home/kali/projetos/backups" ]; then
    echo -n "-> Criando pacote compactado dos backups... "
    # Cria o tarball com a data atual
    tar -czf /home/kali/projetos/backups_$(date +%Y%m%d).tar.gz -C /home/kali/projetos/ backups/ 2>/dev/null
    echo -e "${VERDE}[OK]${SEM_COR}"

    # 3. Verificando o tamanho do arquivo
    TAMANHO=$(du -sh /home/kali/projetos/backups_$(date +%Y%m%d).tar.gz | awk '{print $1}')
    echo -e "${AZUL}Sucesso! Backup gerado ($TAMANHO)${SEM_COR}"
else
    echo -e "${AMARELO}-> Aviso: Pasta 'backups/' não encontrada. Pulando compactação.${SEM_COR}"
fi

# 4. Removendo backups .tar.gz antigos (30+ dias) - Engenharia de Custos
echo -n "-> Removendo backups antigos (30+ dias)... "
find /home/kali/projetos/ -name "backups_*.tar.gz" -mtime +30 -exec rm -f {} \; 2>/dev/null
echo -e "${VERDE}[OK]${SEM_COR}"

# 5. Removendo logs rotacionados .old (7+ dias)
echo -n "-> Removendo logs .old (7+ dias)... "
find /home/kali/projetos/ -type f -name "*.old" -mtime +7 -delete 2>/dev/null
echo -e "${VERDE}[OK]${SEM_COR}"

echo "---------------------------------------"
echo -e "${VERDE}Faxina concluída, Engenheiro Wilson!${SEM_COR}"