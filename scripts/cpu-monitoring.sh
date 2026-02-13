#!/bin/bash

# Script para monitoramento de CPU e processos
# Alertar quando a CPU passar do limite e mostrar quem esta consumindo

# Ativando o modo segurança do shell
set -euo pipefail

# Redirecionando todas as saídas para o arquivo log
PATH_LOG="/mnt/c/Users/2992167/Desktop/monitor_cpu_log.log"

mkdir -p "$(dirname "$PATH_LOG")"
touch "$PATH_LOG"

exec &> "$PATH_LOG"

# Verificando se o usuario que esta executando o script é o root
if [ "$EUID" -ne 0 ]; then
    echo "Esse script precisa ser executado como root!"
    exit 1
fi

echo "--- Monitoramento de CPU e Processo ---"

echo "--- Instalando dependências ---"
pacman -Sy --noconfirm sysstat procps bc

LIMITE_CPU="${LIMITE:-80}" # define um valor padrão que 'LIMITE' não existir ou está vazia
CICLOS="${CICLOS:-3}"
INTERVALO="${INTERVALO:-60}"

CONTADOR=0

