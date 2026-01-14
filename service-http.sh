#!/bin/bash

# Esse e um script que via iniciar uma aplicacao, pelo apache2 e vai usar um template pronto da internet

# Baixar os packages necessarios
# Iniciar o servico httpd
# Baixar o template pronto internet (.tar) em uma pasta no /tmp/
# Descomprimir o .tar baixado da internet
# Copiar a pasta descompactada para o caminho /var/www/html

PACKAGE="apache2 wget curl unzip"
SVC="apache2"
SVC_DIR="/var/www/html"
TEMP_DIR="/tmp/service-http"
URL="https://www.tooplate.com/zip-templates/2154_split_portfolio.zip"
TEMPLATE_NAME="2154_split_portfolio"

echo "#####################################"
echo "Baixando os packages necessarios para a aplicacao..."
echo "#####################################"
sudo apt update -y
sudo apt install $PACKAGE -y > /dev/null
echo

echo "#####################################"
echo "Iniciando o servico apache2..."
echo "#####################################"
sudo systemctl start $SVC
sudo systemctl enable $SVC
echo

echo "#####################################"
echo "Criando uma pasta temporaria para armazenar o template..."
echo "#####################################"
mkdir -p $TEMP_DIR
cd $TEMP_DIR
echo

echo "#####################################"
echo "Baixando o template da internet..."
echo "#####################################"
wget $URL > /dev/null
echo

echo "#####################################"
echo "Descompactando arquivo zipado na pasta temporaria..."
echo "#####################################"
unzip $TEMPLATE_NAME.zip > /dev/null
echo

echo "#####################################"
echo "Copiando template para dentro da pasta /var/www/html/ ..."
echo "#####################################"
sudo cp -r $TEMPLATE_NAME/* $SVC_DIR