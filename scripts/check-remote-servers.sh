#!/bin/bash

# Esse script visa testar conexoes com servidores remotos

# Ativar modo de seguranca do bash
set -euo pipefail

IP="192.168.1.1"

# Verificando a conexao com um servidor
if ping -c1 "$IP" &> /dev/null; then
    echo "O servidor remoto esta disponivel"
else
    echo "O servidor remoto nao esta disponivel"
fi
