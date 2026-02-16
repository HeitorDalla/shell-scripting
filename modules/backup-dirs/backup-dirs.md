# backup-dirs.sh

## 📌 Descrição
Script responsável por realizar **backup versionado** de diretórios críticos do sistema Linux, utilizando compactação e organização por data.

---

## 🎯 Objetivo
- Garantir cópia segura de arquivos importantes
- Manter histórico de backups
- Facilitar restauração em caso de falhas

---

## ⚙️ Funcionamento Geral
1. Valida se o script está sendo executado como root
2. Define o diretório de destino baseado na data atual
3. Compacta os diretórios configurados em um arquivo `.tar.gz`
4. Cria um *symlink* apontando para o último backup gerado

---

## 📂 Diretórios e Arquivos Envolvidos

| Tipo     | Caminho |
|----------|--------|
| Origem   | `/etc` |
| Destino  | Diretório definido em `BACKUP_DIR/YYYY-MM-DD` |
| Arquivo  | `backup.tar.gz` |
| Symlink  | `/tmp/backup-latest` |

---

## ▶️ Como Executar
```bash
sudo ./backup_dirs.sh