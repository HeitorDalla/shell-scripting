#!/bin/bash

# Esse script tem por finalidade limpar todo o fluxo que precisa para iniciar uma aplicacao web com templates prontos da internet

# Ativa o modo de seguranca do bash. Falha em qualquer erro e se variaveis nao foram definidas
set -euo pipefail # qualquer comando que retorna erro (≠ 0), o script PARA IMEDIATAMENTE

# Verificar as permissoes que o script esta rodando
if [ "$EUID" -ne 0 ]; then
    echo "Execute como root!"
    exit 1
fi

SVC="apache2"
SVC_DIR="/var/www/html"
TEMP_DIR="/tmp/service-http"
EMPTY_DIR="/tmp/.empty-dir"

# Cria diretorio vazio
mkdir -p "$EMPTY_DIR"

echo "#####################################"
echo "Parando, desabilitando o meu servico..."
echo "#####################################"
systemctl stop "$SVC" || true
systemctl disable "$SVC" || true
systemctl daemon-reload
echo

echo "#####################################"
echo "Limpando o diretorio temporario..."
echo "#####################################"
if [ -d "$TEMP_DIR" ]; then
    rsync -a --delete "$EMPTY_DIR"/ "$TEMP_DIR"/
fi
echo


echo "#####################################"
echo "Limpando o diretorio do apache2..."
echo "#####################################"
if [ -d "$SVC_DIR" ]; then
    rsync -a --delete "$EMPTY_DIR"/ "$SVC_DIR"/
fi
echo