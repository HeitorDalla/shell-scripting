# service-http.sh

## 📌 Descrição
Script de **deploy automatizado** de uma aplicação web simples utilizando Apache e um template HTML baixado da internet.

---

## 🎯 Objetivo
- Instalar dependências automaticamente
- Configurar e iniciar o Apache
- Realizar deploy de aplicação web estática

---

## ⚙️ Funcionamento Geral
1. Instala pacotes necessários
2. Inicia e habilita o Apache
3. Cria diretório temporário
4. Baixa e descompacta template
5. Copia arquivos para `/var/www/html`

---

## 📂 Recursos Utilizados

| Tipo | Nome |
|----|-----|
| Serviço | `apache2` |
| Diretório Web | `/var/www/html` |
| Diretório Temporário | `/tmp/service-http` |
| Template | Tooplate |

---

## ▶️ Como Executar
```bash
sudo ./service-http.sh