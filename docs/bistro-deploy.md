# Script de Deploy Automatizado (Bistro)

## 📖 Visão Geral

Este script Bash simula um **deploy real de uma aplicação web**, utilizando **Apache**, **systemd** e um **template HTML público**.  
Ele automatiza todo o fluxo de provisionamento, deploy, validação e rollback, seguindo boas práticas de **Shell Scripting** e **DevOps**.

O deploy finaliza servindo o site estático através do Apache e valida automaticamente se a aplicação está acessível.

---

## 🎯 Objetivos do Script

- Simular um pipeline de deploy real
- Criar usuário e grupo dedicados à aplicação
- Instalar dependências automaticamente
- Criar e gerenciar um serviço systemd
- Baixar e publicar um template web
- Criar backup antes do deploy
- Validar a aplicação após o deploy
- Executar rollback automático em caso de falha
- Gerar logs persistentes

---

## 🛡️ Modo de Segurança

```bash
set -euo pipefail
```

Este modo garante que:
- O script **falha imediatamente** em qualquer erro
- Variáveis não definidas causam erro
- Falhas em pipelines são corretamente detectadas

---

## 📝 Logs

```bash
LOG_FILE="/var/log/bistro_deploy.log"
```

- Todo o output do script é exibido no terminal **e** salvo em log
- Logs persistem entre execuções
- Útil para auditoria e troubleshooting

---

## 👤 Requisitos de Execução

- Deve ser executado como **root**
- Sistema baseado em **Debian/Ubuntu**
- Acesso à internet

Validação:

```bash
if [ "$EUID" -ne 0 ]; then
    echo "Execute como root"
    exit 1
fi
```

---

## 👥 Usuário e Grupo da Aplicação

| Item | Valor |
|----|----|
| Usuário | administrator |
| Grupo | devOps |
| Shell | nologin |
| Tipo | Sistema (-r) |

Isola a aplicação do restante do sistema, seguindo boas práticas de segurança.

---

## ⚙️ Serviço systemd

O script cria automaticamente:

```bash
/etc/systemd/system/bistro.service
```

### Características:
- Serviço persistente
- Reinício automático em falha
- Apache rodando em foreground
- Inicializa após a rede

### Comandos usados:
```bash
systemctl daemon-reload
systemctl enable bistro
systemctl start bistro
```

---

## 🌐 Aplicação Web

| Item | Valor |
|----|----|
| Diretório de deploy | /var/www/html |
| Template | Bistro Elegance |
| Fonte | tooplate.com |
| Tipo | Site estático |

O template é baixado, extraído e sincronizado com `rsync --delete`.

---

## 📦 Backup Preventivo

Antes do deploy:

```bash
tar -czvf /tmp/backup_site.tar.gz /var/www/html/
```

- Executado **apenas se houver conteúdo**
- Permite rollback automático

---

## 🔄 Deploy

- Download do template
- Extração em diretório temporário
- Sincronização com diretório final
- Ajuste de permissões

```bash
chown -R administrator:devOps /var/www/html
chmod -R 755 /var/www/html
```

---

## ✅ Validação Pós-Deploy

```bash
curl -sf http://localhost
```

### Se sucesso:
- Deploy concluído

### Se falha:
- Remove arquivos novos
- Restaura backup
- Reinicia serviço
- Finaliza com erro

---

## 🔁 Rollback Automático

Executado automaticamente se a aplicação não responder:

- Restaura backup
- Reinicia o serviço
- Garante estabilidade do ambiente

---

## 📁 Estrutura de Diretórios

```text
/var/www/html        -> Aplicação
/tmp/service-http    -> Template temporário
/tmp/backup_site.tar.gz -> Backup
/var/log/bistro_deploy.log -> Logs
```

---

## 🧠 Conceitos Demonstrados

- Shell Scripting avançado
- Segurança em scripts
- systemd
- Deploy automatizado
- Rollback
- Logging
- Infraestrutura como código (IaC conceitual)

---

## 🚀 Como Executar

```bash
chmod +x bistro-deploy.sh
sudo ./bistro-deploy.sh
```

---

## 📌 Observações

- Script educacional / demonstrativo
- Ideal para estudos de Linux, DevOps e automação

---

## ✍️ Autor

Script desenvolvido para fins de estudo e simulação de deploy automatizado com Bash.