# service-guard.sh

## 📌 Descrição  
Script responsável por **monitorar o estado de um serviço Linux** e **agir automaticamente** caso ele esteja parado ou consumindo CPU acima do limite definido.

No cenário atual, o serviço monitorado é o **Apache2**.

---

## 🎯 Objetivo
- Garantir que o serviço configurado esteja sempre em execução  
- Iniciar automaticamente o serviço caso esteja parado  
- Monitorar o consumo total de CPU do serviço  
- Interromper e desabilitar o serviço caso o consumo de CPU ultrapasse o limite aceitável  

---

## ⚙️ Funcionamento Geral
1. Ativa o modo de segurança do Bash (`set -euo pipefail`)
2. Verifica se o script está sendo executado como **root**
3. Define o serviço a ser monitorado (`apache2`)
4. Verifica se o processo do serviço está rodando
5. Caso **não esteja rodando**:
   - Exibe alerta
   - Inicia o serviço via `systemctl`
6. Caso **esteja rodando**:
   - Calcula o consumo total de CPU do serviço
   - Converte o valor para inteiro
   - Compara com o limite configurado
7. Se o consumo de CPU for **maior que 10%**:
   - Para o serviço
   - Desabilita o serviço
   - Finaliza forçadamente os processos restantes

---

## 🧠 Lógica de Controle de CPU
- O consumo de CPU é calculado somando a coluna `%CPU` de todos os processos associados ao serviço
- O valor é convertido para inteiro para facilitar comparações
- Limite atual:
  - **CPU > 10%** → ação corretiva
  - **CPU ≤ 10%** → nenhuma ação

---

## 📂 Variáveis Importantes

| Variável | Descrição |
|--------|----------|
| `SVC` | Nome do serviço monitorado (`apache2`) |
| `SUM_CPU` | Soma total do consumo de CPU dos processos |
| `CPU_INT` | Consumo de CPU convertido para inteiro |

---

## 🔐 Requisitos
- Executar como **usuário root**
- Sistema com:
  - `systemd`
  - `pgrep`
  - `ps`
  - `awk`

---

## ▶️ Como Executar
```bash
sudo ./service-guard.sh