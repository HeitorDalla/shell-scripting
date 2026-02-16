# cleanup-logs.sh

## 📌 Descrição
Script de **manutenção do sistema**, focado na limpeza de arquivos temporários e logs antigos, além de gerar relatórios de uso de disco.

---

## 🎯 Objetivo
- Liberar espaço em disco
- Manter o sistema limpo
- Gerar logs de auditoria da limpeza

---

## ⚙️ Funcionamento Geral
1. Valida execução como root
2. Registra uso de disco antes da limpeza
3. Remove arquivos temporários antigos
4. Remove logs antigos
5. Registra uso de disco após a limpeza

---

## 📂 Diretórios e Logs Envolvidos

| Tipo | Caminho |
|----|--------|
| Temporários | `/tmp` |
| Logs | `/var/log` |
| Log Execução | `/var/log/cleanup.log` |
| Log Erros | `/var/log/cleanup_errors.log` |

---

## ▶️ Como Executar
```bash
sudo ./cleanup_logs.sh