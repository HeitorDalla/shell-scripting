
# 🌐 Script de Teste de Conectividade com Servidores

## 📌 Descrição

Este script em **Bash** testa a conectividade com servidores remotos utilizando o comando `ping`.

Ele realiza:

- Teste de conexão com um IP fixo
- Teste de conexão com múltiplos hosts listados em um arquivo `hosts.txt`
- Validação da existência do arquivo antes da execução

---

## ⚙️ Funcionalidades

- Executa em modo seguro (`set -euo pipefail`)
- Testa conectividade com um IP específico
- Lê múltiplos hosts linha por linha de um arquivo
- Ignora linhas vazias
- Verifica se o arquivo `hosts.txt` existe antes de executar
- Exibe status de disponibilidade para cada host

---

## 🔧 Dependências

O script utiliza:

- `bash`
- `ping`

Normalmente já vêm instalados na maioria das distribuições Linux.

---

## 🚀 Como rodar localmente

### 1) Clonar o repositório

```bash
git clone https://github.com/HeitorDalla/shell-scripting.git
cd shell-scripting
```

### 2) Localizar o script

```bash
cd modules/check-remote-servers
```

### 3) Criar o arquivo hosts.txt

O script procura o arquivo `hosts.txt` no mesmo diretório onde ele está.

```bash
nano hosts.txt
```

Exemplo de conteúdo:

```
8.8.8.8
1.1.1.1
192.168.1.10
```

Salve e feche o arquivo.

---

### 4) Dar permissão de execução

```bash
chmod +x check-remote-servers.sh
```

---

### 5) Executar o script

```bash
./check-remote-servers.sh
```

---

## 🔁 Funcionamento

1. Define um IP fixo para teste.
2. Executa `ping -c1` para verificar disponibilidade.
3. Verifica se o arquivo `hosts.txt` existe.
4. Lê o arquivo linha por linha usando `while read`.
5. Ignora linhas vazias.
6. Testa cada host individualmente.
7. Exibe se o servidor está disponível ou não.

---

## 📌 Exemplo de Saída

```
O servidor remoto esta disponivel
O servidor 8.8.8.8 esta disponivel
O servidor 1.1.1.1 esta disponivel
O servidor 192.168.1.10 nao esta disponivel
```

---

## 📂 Estrutura Esperada

```
modules/
└── check-remote-servers/
    ├── check-remote-servers.sh
    └── hosts.txt
```

---

## 🧠 Observações

- O script utiliza `$(dirname "$0")` para garantir que o `hosts.txt` seja lido corretamente, independentemente do diretório de execução.
- Caso o arquivo não exista, o script será encerrado com erro.
- Ideal para testes rápidos de rede ou pequenos ambientes internos.

---

## 📌 Resumo

Este script é útil para:

✔ Testes rápidos de conectividade  
✔ Verificação automatizada de múltiplos servidores  
✔ Uso em ambientes locais ou laboratoriais  