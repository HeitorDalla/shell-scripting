#!/bin/bash

# Esse script tem por finalidade, gerenciar usuarios e grupos

# Ativando o modo de seguranca do shell
set -euo pipefail

# Verificando usuarios de execucao
if [ "$EUID" -ne 0 ]; then
    echo "Execute o script como root"
    exit 1
fi

# Variaveis
INPUT="usuarios.csv"
LOG_FILE="/tmp/users_management.log"
ERROR_LOG="/tmp/error_users_management.log"

# Verificando existencia do arquivos de usuarios
if [[ ! -f "$INPUT" ]];then
    echo "Arquivo $INPUT nao existe!" | tee -a "$ERROR_LOG"
    exit 1
fi

# Iterando sobre cada linha do arquivo
while IFS=";" read -r user group shell; do
    # Pula se a linha estiver vazia
    if [[ -z "$user" ]]; then
        continue
    fi

    echo "Nome: $user - Group: $group - Shell: $shell" | tee -a "$LOG_FILE"

    # Validacao do grupo
    if getent group "$group" &>/dev/null; then
        echo "Grupo $group ja esta criado!" | tee -a "$ERROR_LOG"
    else
        echo "Criando grupo $group" | tee -a "$LOG_FILE"
        groupadd "$group" |& tee -a "$LOG_FILE"

        echo "Grupo - $group - criado!" | tee -a "$LOG_FILE"
    fi

    # Validacao do usuario
    if id "$user" &>/dev/null; then
        echo "Erro. O usuario $user ja existe!" | tee -a "$ERROR_LOG"
    else
        echo "Criando usuario $user..." | tee -a "$LOG_FILE"
        useradd -m -c "Criando usuario por meio de script" -s "$shell" -g "$group" "$user" |& tee -a "$LOG_FILE"

        echo "Usuario - $user - criado!" | tee -a "$LOG_FILE"

        # Define uma senha padra
        echo "$user:senha123" | chpasswd | tee -a "$LOG_FILE"

        # Forca a troca no primeiro login
        chage -d 0 "$user" | tee -a "$LOG_FILE"

        echo "Credenciais iniciadas configuradas para $user" | tee -a "$LOG_FILE"
    fi  
done < "$INPUT"