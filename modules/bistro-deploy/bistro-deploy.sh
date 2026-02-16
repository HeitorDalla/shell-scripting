#!/bin/bash

# Esse script tem como finalidade simular um deploy real de aplicacao

# Ativando o modo de seguranca do bash
set -euo pipefail

# Log
LOG_FILE="/var/log/bistro_deploy.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Redireciona tudo para o log e para a tela
exec > >(tee -a "$LOG_FILE") 2>&1

# Verificando usuario de execucao
if [ "$EUID" -ne 0 ]; then
    echo "Execute como root"
    exit 1
fi

# Servico
USER="administrator"
GROUP="devOps"
PATH_SERVICE="/etc/systemd/system"
NAME_SERVICE="bistro"
FULL_PATH="$PATH_SERVICE/$NAME_SERVICE.service"
SVC_DIR="/var/www/html"

# Template
TEMP_DIR="/tmp/service-http"
URL="https://www.tooplate.com/zip-templates/2148_bistro_elegance.zip"
TEMPLATE_NAME="2148_bistro_elegance"

echo "--- Iniciando Deploy ---"

# Baixando libs necessarias para a aplicacao
echo "--- Baixando libs necessarias para a aplicacao ---"
apt update -y > /dev/null
apt install curl apache2 rsync zip unzip wget -y > /dev/null

# Criando grupo e usuario exclusivo para rodar a aplicacao
if ! getent group "$GROUP" > /dev/null 2>&1; then 
    echo "Criando grupo $GROUP"
    groupadd $GROUP
else
    echo "O grupo $GROUP ja esta criado!"
fi

# Verificando se usuario ja existe
if ! getent passwd "$USER" > /dev/null 2>&1; then        
    echo "Criando usuario $USER"
    useradd -r -m -c "Usuario criado com shell scripting" -s /usr/sbin/nologin -g $GROUP $USER
else
    echo "Usuario $USER ja existe!"
fi

# Criando servico (.service) personalizado
if [ ! -f "$FULL_PATH" ]; then   
    echo "Criando o servico $NAME_SERVICE"

cat <<EOF > "$FULL_PATH"
[Unit]
Description=Servico para aplicacao shell automatizada
After=network.target

[Service]
Type=simple
ExecStart=/usr/sbin/apachectl -DFOREGROUND
ExecReload=/usr/sbin/apachectl graceful
ExecStop=/bin/kill -WINCH \$MAINPID
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

else
    echo "O arquivo de configuracao $NAME_SERVICE.service ja existe!"
fi

# Reiniciando aplicacao
echo "Configurando systemd..."
systemctl daemon-reload
systemctl enable $NAME_SERVICE.service
systemctl start $NAME_SERVICE.service

# Criando uma pasta para armazenar um template temporario
echo "Criando uma pasta temporaria para armazenar o template..."
mkdir -p "$TEMP_DIR" || true
cd "$TEMP_DIR"

# Baixando template da internet
echo "Baixando o template da internet..."
if [ ! -f "$TEMPLATE_NAME.zip" ]; then
    wget $URL > /dev/null
fi

# Descompactando o arquivo zipado
echo "Descompactando arquivo zipado na pasta temporaria..."
unzip -o "$TEMPLATE_NAME.zip" > /dev/null

# Fazendo backup preventivo da versao atual
echo "Criando backup da versao atual..."
if [ -d "$SVC_DIR" ] && [ "$(ls -A "$SVC_DIR")" ]; then
    tar -czvf /tmp/backup_site.tar.gz "$SVC_DIR"/
else
    echo "Diretorio vazio, pulando backup"
fi

# Copiando template para a pasta de deploy
echo "Copiando template para dentro da pasta /var/www/html/ ..."
rsync -av --delete "$TEMPLATE_NAME"/ "$SVC_DIR"/

# Ajustando permissoes
chown -R "$USER:$GROUP" "$SVC_DIR"
chmod -R 755 "$SVC_DIR"

# Testanto se a aplicacao
if curl -sf http://localhost > /dev/null; then
    echo "SUCESSO: O deploy esta funcionando!"
else
    echo "ERRO: O deploy falhou!"

    # Restaurando backup
    rm -rf "$SVC_DIR"/*
    tar -xzf /tmp/backup_site.tar.gz -C "$SVC_DIR" --strip-components=1
    systemctl restart $NAME_SERVICE

    echo "Rollback finalizado. Versao anterior restaurada."
    exit 1
fi