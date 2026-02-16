
# 📊 Script de Monitoramento de CPU

## 📌 Descrição

Este script em **Bash** monitora o uso da CPU do servidor em intervalos definidos.  
Caso o uso ultrapasse um limite configurado por um número específico de ciclos consecutivos, ele emite um **alerta** e exibe os 5 processos que mais estão consumindo CPU.

Além disso, todas as saídas são registradas em um arquivo de log.

---

## ⚙️ Funcionalidades

- Executa em modo seguro (`set -euo pipefail`)
- Verifica se o usuário é **root**
- Valida dependências necessárias
- Monitora uso total da CPU (via `mpstat`)
- Mostra os 5 processos que mais consomem CPU
- Dispara alerta se o limite for ultrapassado por múltiplos ciclos
- Registra todas as saídas em arquivo de log

---

## 🔧 Dependências

O script verifica automaticamente se os seguintes comandos estão instalados:

- `awk`
- `top`
- `sleep`
- `date`
- `ps`
- `grep`
- `mpstat` (pacote `sysstat`)
- `bc`

---

## 🚀 Como rodar localmente

### 1) Clonar o repositório

```bash
git clone https://github.com/HeitorDalla/shell-scripting.git
cd shell-scripting
```

### 2) Localizar o script

```bash
cd modules/server-stats
```

### 3) Dar permissão de execução

```bash
chmod +x server-stats.sh
```

### 4) Executar como root

O script precisa rodar como root por causa da validação do `EUID`:

```bash
sudo ./server-stats.sh
```

### 5) (Opcional) Rodar com configurações personalizadas

Você pode ajustar o limite de CPU, quantidade de ciclos e intervalo via variáveis de ambiente:

```bash
LIMITE=70 CICLOS=2 INTERVALO=30 sudo ./server-stats.sh
```

---

## 📁 Arquivo de Log

O log é criado no mesmo diretório do script:

```
server-stats.log
```

Todas as saídas (incluindo alertas) são redirecionadas para esse arquivo.

---

## 🧮 Variáveis de Configuração

O script permite personalização via variáveis de ambiente:

| Variável     | Descrição                                                                 | Valor padrão |
|--------------|---------------------------------------------------------------------------|--------------|
| `LIMITE`     | Percentual máximo de uso da CPU                                           | 80           |
| `CICLOS`     | Quantidade de verificações consecutivas acima do limite para gerar alerta | 3            |
| `INTERVALO`  | Tempo (segundos) entre verificações                                       | 60           |

---

## 🔁 Funcionamento do Monitoramento

1. Verifica o uso médio da CPU.
2. Compara com o limite configurado.
3. Se ultrapassar o limite, incrementa um contador.
4. Se o contador atingir o número de ciclos definidos:
   - Exibe alerta
   - Mostra os 5 processos que mais utilizam CPU
5. Aguarda o intervalo configurado e repete o processo.

---

## 🚨 Exemplo de Alerta

```
Mon Feb 16 10:00:00 ALERTA: CPU=85.32% Acima do limite
PID USER %CPU %MEM COMMAND
...
```

---

## 🧠 Observações

- O script roda em loop infinito (`while true`).
- Para parar, use `Ctrl + C`.
- Ideal para monitoramento simples em servidores Linux.
- Se quiser executar de forma contínua em produção, considere rodar via **systemd service** (opcional).

---

## 📌 Resumo

Este script é uma solução simples e eficiente para:

✔ Monitorar uso de CPU  
✔ Detectar picos prolongados  
✔ Identificar processos problemáticos  
✔ Registrar eventos em log