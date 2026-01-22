# user_management.sh

## 📌 Descrição
Script para **gerenciamento automatizado de usuários e grupos**, baseado em um arquivo CSV.

---

## 🎯 Objetivo
- Criar grupos automaticamente
- Criar usuários com shell definida
- Definir senha inicial
- Forçar troca de senha no primeiro login

---

## ⚙️ Funcionamento Geral
1. Valida execução como root
2. Lê arquivo `usuarios.csv`
3. Cria grupos se não existirem
4. Cria usuários associados aos grupos
5. Configura credenciais iniciais

---

## 📂 Arquivos Envolvidos

| Tipo | Caminho |
|----|--------|
| Entrada | `usuarios.csv` |
| Log | `/tmp/users_management.log` |
| Log Erros | `/tmp/error_users_management.log` |

---

## ▶️ Como Executar
```bash
sudo ./user_management.sh