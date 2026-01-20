#!/bin/bash

# Ese script tem por finalidade limar arquivos temporarios, logs antigos e gerar relatorios

# Ativar o modo de seguranca do bash
set -eou pipefail

# Verificar se e root
if [ "$EUID" -ne 0 ]; then
    echo "Execute no modo root"
    exit 1
fi

TEMP_DIR="/tmp"
LOG_DIR="/var/log"
LOG_FILE="/var/log/cleanup.log"
ERROR_LOG="/var/log/cleanup_errors.log"

echo "=== Inicio da Limpeza: $(date) ===" >> "$LOG_FILE"

# Uso de disco antes"
df -h >> "$LOG_FILE"

# Limpar arquivos temporarios
echo "Limpando arquivos antigos do Linux..." >> "$LOG_FILE"
find "$TEMP_DIR" -type f -mtime +7 -print -delete >> "$LOG_FILE" 2>> "$ERROR_LOG" || true

# Deletando arquivos .logs com mais de 7 dias
echo "Deletando arquivos com mais de 7 dias..." >> "$LOG_FILE"
find "$LOG_DIR" -type f -iname "*.log" -mtime +7 -print -delete >> "$LOG_FILE" 2>> "$ERROR_LOG" || true

# Uso de disco depois da limpeza
df -h >> "$LOG_FILE"

echo "=== Fim da Limpeza ===" >> "$LOG_FILE"
echo >> "$LOG_FILE"