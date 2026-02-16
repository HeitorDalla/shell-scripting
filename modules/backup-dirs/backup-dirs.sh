#!/bin/bash

# Esse scritp tem por objetivo fazer um backup com versionamento das pastas `/etc`

# Ativando o modo seguranca do bash
set -euo pipefail

# Verificando usuario de execucaco
if [ "$EUID" -ne 0 ]; then
    echo "Execute o script como root"
    exit 1
fi

BACKUP_DIR="/mnt/c/Users/Admin/Desktop/Tecnologia/TERMINAL/LINUX/tasks/backup"
DAY="$(date +%F)"
DESTINO="$BACKUP_DIR/$DAY"
FILE_NAME="backup.tar.gz"
DIRS="/etc"
SOFTLINK_FILE="/tmp/backup-latest"

# Criando diretorio de backup
mkdir -p "$DESTINO"

echo "Iniciando compactacao de $DIRS..."

# Compactando pastas
tar czvf "$DESTINO"/"$FILE_NAME" $DIRS

echo "Pastas compactadas!"

# Criando soft link
ln -sf "$DESTINO"/"$FILE_NAME" "$SOFTLINK_FILE" # usado -sf para sobrescrever o link anterior

echo "Backup concluido! Link atualizado em $SOFTLINK_FILE"