# clean-service-http.sh

## 📌 Descrição
Script responsável por realizar a **limpeza completa do ambiente de um serviço HTTP**, preparando o sistema para um novo deploy de aplicação web.

---

## 🎯 Objetivo
- Parar e desabilitar o serviço Apache
- Limpar diretórios temporários
- Remover arquivos antigos da aplicação web
- Garantir ambiente limpo para novo deploy

---

## ⚙️ Funcionamento Geral
1. Valida execução como root
2. Para e desabilita o serviço `apache2`
3. Recarrega o daemon do systemd
4. Limpa diretórios usando `rsync --delete`
5. Prepara o sistema para nova instalação ou deploy

---

## 📂 Serviços e Diretórios Envolvidos

| Tipo | Nome / Caminho |
|----|----------------|
| Serviço | `apache2` |
| Diretório Web | `/var/www/html` |
| Diretório Temporário | `/tmp/service-http` |
| Diretório Vazio | `/tmp/.empty-dir` |

---

## ▶️ Como Executar
```bash
sudo ./clean-service-http.sh