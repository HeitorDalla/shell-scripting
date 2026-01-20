# Shell Scripting – Automação e Estudos em Linux

Este repositório concentra **scripts em Bash** criados para fins de **aprendizado, prática e automação de tarefas administrativas em sistemas Linux**.

A proposta do projeto é servir como um **laboratório prático**, onde cada script resolve um problema real de administração de sistemas, reforçando conceitos fundamentais usados em ambientes profissionais (SysAdmin, DevOps, SRE).

---

## 🎯 Objetivo Geral

- Praticar **Shell Scripting** de forma estruturada
- Automatizar tarefas comuns do dia a dia em Linux
- Consolidar conceitos de sistema operacional na prática
- Criar uma base reutilizável de scripts
- Evoluir gradualmente para padrões profissionais

---

## 🧱 Estrutura do Repositório

```
shell-scripting/
├── README.md        # Documentação geral do projeto
├── scripts/         # Scripts Bash
├── docs/            # Documentação dos scripts
└── examples/        # Arquivos de exemplo
```

---

## ⚙️ Características Gerais dos Scripts

De forma geral, os scripts deste repositório seguem os seguintes princípios:

- Escritos em **Bash** (`#!/bin/bash`)
- Uso de modo seguro:
  ```bash
  set -euo pipefail
  ```
- Validação de execução como **root** quando necessário
- Uso de variáveis para facilitar manutenção
- Automação sem interação manual
- Logs para auditoria e depuração

---

## 🔐 Requisitos

Para utilizar os scripts, é esperado:

- Sistema operacional Linux
- Preferência por distribuições baseadas em **Debian / Ubuntu**
- Acesso root ou `sudo`
- Ferramentas padrão do sistema:
  - bash
  - coreutils
  - tar
  - rsync
  - systemctl
  - apt

---

## ▶️ Como Utilizar

1. Clone o repositório:
```bash
git clone https://github.com/HeitorDalla/shell-scripting
cd shell-scripting
```

2. Dê permissão de execução aos scripts:
```bash
chmod +x scripts/**/*.sh
```

3. Execute o script desejado:
```bash
sudo ./scripts/script.sh
```

> ⚠️ **Atenção:** alguns scripts alteram arquivos do sistema, usuários ou serviços. Sempre leia o código antes de executar.

---

## 📚 Conceitos Trabalhados

Este repositório aborda, direta ou indiretamente:

- Shell e ambiente Linux
- Variáveis e fluxo de execução
- Processos e serviços (`systemctl`)
- Permissões e usuários
- Logs e manutenção do sistema
- Filesystem Linux
- Automação de tarefas administrativas

---

## 🧠 Boas Práticas

✔️ Scripts pequenos e objetivos  
✔️ Falha rápida em caso de erro  
✔️ Código legível e comentado  
✔️ Separação entre código e documentação  
✔️ Uso de ferramentas nativas do Linux

---

## 🔮 Evolução do Projeto

Possíveis melhorias futuras:

- Documentação individual por script
- Padronização de cabeçalhos
- Suporte a argumentos (`getopts`)
- Modo `--help` e `--dry-run`
- Integração com `cron` ou `systemd timers`
- Testes automatizados

---

## ✅ Conclusão

Este repositório funciona como uma **base sólida de estudos em Linux**, focada em prática real e automação.

É indicado para quem deseja **entender o sistema operacional além dos comandos**, criando scripts confiáveis e evolutivos — habilidades essenciais para áreas como **DevOps e Cloud** 🚀