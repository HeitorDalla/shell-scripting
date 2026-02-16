#!/usr/bin/env bash

# Script para monitoramento de CPU e processos
# Alertar quando a CPU passar do limite e mostrar quem esta consumindo

# Ativando o modo segurança do shell
set -euo pipefail

# Redirecionando todas as saídas para o arquivo log
LOG_FILE="$(dirname "$0")/server-stats.log"

mkdir -p "$(dirname "$LOG_FILE")"
touch "$LOG_FILE"

exec &> >(tee -a "$LOG_FILE")

# Verificando se o usuario que esta executando o script é o root
if [ "$EUID" -ne 0 ]; then
    echo "Esse script precisa ser executado como root!"
    exit 1
fi

echo "--- Monitoramento de CPU e Processo ---"

# Verificando dependencias
DEPENDENCIAS=(awk top sleep date ps grep)

for dep in "${DEPENDENCIAS[@]}"; do
    if ! command -v "$dep" &> /dev/null;then
        echo "Erro: a ferramenta $dep nao foi encontrada. Por favor, instale-a"
        exit 1
    fi
done

LIMITE_CPU="${LIMITE:-80}" # define um valor padrão que 'LIMITE' não existir ou está vazia
CICLOS="${CICLOS:-3}"
INTERVALO="${INTERVALO:-60}"

CONTADOR=0

while true; do
    echo "[$(date +%H:%M:%S)] Iniciando verificação de rotina..."

    # Ver uso total da CPU
    USO_CPU=$(LC_ALL=C mpstat 1 1 | awk '/Average:/ {printf("%.2f", 100 - $NF)}')

    echo "Uso atual da CPU: $USO_CPU% (Limite: $LIMITE_CPU%)"

    # Verificando os 5 processos que mais utilizam CPU
    TOP5=$(top -b -n 1 | awk '{print $1, $2, $9, $10, $12}' | sed -n '7,12p')

    if (( $(echo "$USO_CPU > $LIMITE_CPU" | bc -l) ));then
        echo "A utilização da CPU atingiu $USO_CPU!"

        CONTADOR=$((CONTADOR+1))
    else
        CONTADOR=0
    fi

    # Se atingiu os ciclos - ALERTA
    if [ "$CONTADOR" -ge "$CICLOS" ];then
        echo "$(date) ALERTA: CPU=$USO_CPU% Acima do limite"
        echo "$TOP5"
        CONTADOR=0
    fi

    echo "Aguardando ${INTERVALO}s para a próxima análise..."

    # Esperar o intervalo e repete
    sleep "$INTERVALO"
done