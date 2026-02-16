#!/bin/bash

# Esse e um script que via iniciar uma aplicacao, pelo apache2 e vai usar um template pronto da internet

# Ativa o modo de seguranca do bash. Falha em qualquer erro e se variaveis nao foram definidas
set -euo pipefail

# Verificar se as permissoes que o script esta rodando
if [ "$EUID" -ne 0 ]; then
  echo "Execute como root"
  exit 1
fi

PACKAGE="apache2 wget curl unzip rsync"
SVC="apache2"
SVC_DIR="/var/www/html"
TEMP_DIR="/tmp/service-http"
URL="https://www.tooplate.com/zip-templates/2148_bistro_elegance.zip"
TEMPLATE_NAME="2148_bistro_elegance"

echo "#####################################"
echo "Baixando os packages necessarios para a aplicacao..."
echo "#####################################"
apt update -y
apt install -y --no-install-recommends $PACKAGE > /dev/null
echo

echo "#####################################"
echo "Iniciando o servico apache2..."
echo "#####################################"
systemctl start $SVC
systemctl enable $SVC
echo

echo "#####################################"
echo "Criando uma pasta temporaria para armazenar o template..."
echo "#####################################"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"
echo

echo "#####################################"
echo "Baixando o template da internet..."
echo "#####################################"
if [ ! -f "$TEMPLATE_NAME.zip" ]; then
    wget $URL > /dev/null
fi
echo

echo "#####################################"
echo "Descompactando arquivo zipado na pasta temporaria..."
echo "#####################################"
unzip -o "$TEMPLATE_NAME.zip" > /dev/null
echo

echo "#####################################"
echo "Copiando template para dentro da pasta /var/www/html/ ..."
echo "#####################################"
rsync -av --delete "$TEMPLATE_NAME"/ "$SVC_DIR"/