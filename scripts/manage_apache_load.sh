#!/bin/bash

# Esse script visa garantir que um servico esteja rodando

# Ativar o modo de seguranca do shell
set -euo pipefail

# Verificando usuario de execucao
if [ "$EUID" -ne 0 ]; then
    echo "Execute como usuario root"
    exit 1
fi

SVC="apache2"

# Verificando se o processo do apache2 esta rodando
if ! pgrep -fl "$SVC" > /dev/null; then
    echo "O servico $SVC esta parado!"
    echo "Iniciando servico $SVC ..."

    sudo systemctl start $SVC || true

    echo "O servidor esta iniciado"
else
    echo "O servico esta rodando!"

    # Calculando a soma do CPU
    SUM_CPU=$(ps aux | grep "$SVC" | grep -v grep | awk '{sum+=$3} END {print sum}')

    # Converterndo para inteiro
    CPU_INT=$(printf "%.0f" "$SUM_CPU")

    echo "Consumo total de CPU: $SUM_CPU"

    # Verificando se consome muita CPU
    if [ "$CPU_INT" -gt 10 ]; then
        echo "O consumo de CPU do servico %SVC esta muito alto!"
        echo "Finalizando servico ..."

        systemctl stop "$SVC" || true
        systemctl disable "$SVC" || true
        
        pgrep apache2 | sudo xargs kill -9
    else
        echo "O consumo da CPU do servico $SVC esta baixo!"
    fi
fi