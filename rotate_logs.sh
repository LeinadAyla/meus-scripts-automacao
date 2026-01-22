#!/bin/bash

# Cores para facilitar a leitura se rodado manualmente
VERDE='\033[0;32m'
AMARELO='\033[1;33m'
SEM_COR='\033[0m'

LOG_FILE="$HOME/projetos/historico_acesso.log"
MAX_LINES=100

# 1. Verifica se o arquivo de log existe
if [ -f "$LOG_FILE" ]; then
    LINHAS=$(wc -l < "$LOG_FILE")
    
    # 2. Verifica se ultrapassou o limite
    if [ "$LINHAS" -gt "$MAX_LINES" ]; then
        echo -e "${AMARELO}--- Rotacionando Logs (Limite de $MAX_LINES atingido) ---${SEM_COR}"
        
        # Criamos o backup com data para não sobrescrever o .old anterior
        BACKUP_NAME="${LOG_FILE}_$(date +%Y%m%d_%H%M%S).old"
        
        # Usamos 'cp' seguido de 'truncate' em vez de 'mv'
        # Isso é mais seguro para processos que podem estar escrevendo no arquivo agora
        cp "$LOG_FILE" "$BACKUP_NAME"
        truncate -s 0 "$LOG_FILE"
        
        # Registra o início do novo ciclo
        echo "[$(date)] Novo ciclo de log iniciado pelo Engenheiro Wilson" >> "$LOG_FILE"
        
        echo -e "${VERDE}[OK] Log antigo salvo como: $(basename "$BACKUP_NAME")${SEM_COR}"
        echo -e "${VERDE}[OK] Arquivo principal resetado com sucesso!${SEM_COR}"
    else
        echo -e "Log ok ($LINHAS/$MAX_LINES linhas). Nenhuma ação necessária."
    fi
else
    echo "Aviso: Arquivo de log não encontrado em $LOG_FILE. Criando um novo..."
    touch "$LOG_FILE"
fi