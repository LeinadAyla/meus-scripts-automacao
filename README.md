# 🛠️ Meus Scripts de Automação

Repositório central para scripts de manutenção, limpeza e segurança do ambiente de desenvolvimento.

## 🚀 Scripts Incluídos

### 🧹 [cleanup.sh](cleanup.sh)
Script de faxina para otimização de espaço e organização.
- **Python Clean**: Remove pastas `__pycache__` recursivamente.
- **Backup Strategy**: Compacta a pasta de backups em arquivos `.tar.gz` datados.
- **Retention Policy**: Deleta backups com mais de 30 dias e logs antigos (.old) com mais de 7 dias.

### 🔄 [rotate_logs.sh](rotate_logs.sh)
Gerencia o crescimento de arquivos de log para evitar falta de espaço em disco.
- Realiza o `truncate` preservando o arquivo original.
- Rotaciona logs para extensões `.old` com timestamp.

## 📅 Agendamento (Crontab)
Os scripts estão configurados para rodar automaticamente toda **sexta-feira às 23:00**:
\`\`\`bash
00 23 * * 5 /home/kali/projetos/cleanup.sh
00 23 * * 5 /home/kali/projetos/rotate_logs.sh
\`\`\`

---
**Autor:** [LeinadAyla](https://github.com/LeinadAyla)
