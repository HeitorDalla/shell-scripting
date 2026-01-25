#!/bin/bash

# Esse script tem como finalidade simular um deploy real de aplicacao

# Ativando o modo de seguranca do bash
set -euo pipefail

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

# Logs
LOG_FILE="/tmp/application_service.log"
ERROR_LOG="/tmp/error_application_service.log"

echo "--- Iniciando Deploy ---" | tee -a "$LOG_FILE"

# Baixando libs necessarias para a aplicacao
echo "--- Baixando libs necessarias para a aplicacao ---" | tee -a "$LOG_FILE"
apt update -y
apt install curl apache2 rsync zip unzip wget -y > /dev/null 2>> "$ERROR_LOG"

# Criando grupo e usuario exclusivo para rodar a aplicacao
if ! getent group "$GROUP" > /dev/null 2>&1; then 
    echo "Criando grupo $GROUP" | tee -a "$LOG_FILE"
    groupadd $GROUP
else
    echo "O grupo $GROUP ja esta criado!" | tee -a "$LOG_FILE"
fi

# Verificando se usuario ja existe
if ! getent passwd "$USER" > /dev/null 2>&1; then        
    echo "Criando usuario $USER" | tee -a "$LOG_FILE"
    useradd -r -m -c "Usuario criado com shell scripting" -s /usr/sbin/nologin -g $GROUP $USER |& tee -a "$LOG_FILE"
else
    echo "Usuario $USER ja existe!" | tee -a "$LOG_FILE"
fi

# Criando servico (.service) personalizado
if [ ! -f "$FULL_PATH" ]; then   
    echo "Criando o servico $NAME_SERVICE" | tee -a "$LOG_FILE"

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
    echo "O arquivo de configuracao $NAME_SERVICE.service ja existe!" | tee -a "$LOG_FILE"
fi

# Reiniciando aplicacao
echo "Configurando systemd..." | tee -a "$LOG_FILE"
systemctl daemon-reload
systemctl enable $NAME_SERVICE.service
systemctl start $NAME_SERVICE.service

