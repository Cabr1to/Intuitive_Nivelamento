# 🚀 Intuitive_Nivelamento
#  Exercício 1 - Web Scraping ANS

## 📌 Visão Geral
Repositório contendo solução para o teste de web scraping da ANS, desenvolvido em Python com Scrapy. O spider acessa o portal da ANS, baixa os Anexos I e II em PDF e os compacta em um arquivo ZIP com compressão máxima.

## 🛠️ Tecnologias Utilizadas
- **Python 3.8+**
- **Scrapy Framework**
- **Biblioteca zipfile** (compressão de arquivos)
- **Seletores CSS** para extração precisa de links

## ⚙️ Configuração do Ambiente

### Pré-requisitos
- Python 3.8 ou superior
- Gerenciador de pacotes pip

### Instalação
```bash
# Clonar repositório
git clone https://github.com/seu-usuario/testes-nivelamento.git
cd testes-nivelamento/exercicio1

# Criar ambiente virtual (recomendado)
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows

# Instalar dependências
pip install scrapy

# Execução
scrapy runspider gov_spider.py
```

# 📋 Exercício 2 - Transformação de Dados do Rol ANS

## 📌 Descrição
Script Python para extração, transformação e compactação de dados do Anexo I (Rol de Procedimentos em Saúde) da ANS, conforme exigido no teste técnico.

## 🛠️ Tecnologias
| Biblioteca | Função |
|------------|--------|
| Pandas | Manipulação e consolidação dos dados |
| Tabula-py | Extração de tabelas do PDF |
| Zipfile | Compactação do arquivo final |

## ⚙️ Instalação
1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/testes-nivelamento.git
cd testes-nivelamento/exercicio2

# Instale as dependências:
pip install -r requirements.txt

# Execução 
python transformacao_dados.py
```

# 🗃️ Exercício 3 - Análise de Dados de Operadoras de Saúde

## 📌 Visão Geral
Solução para análise de dados contábeis de operadoras de saúde, incluindo preparação de banco de dados e queries analíticas para identificar as operadoras com maiores despesas em sinistros médico-hospitalares.

## 🛠️ Tecnologias Utilizadas
- **MySQL 8.0** ou **PostgreSQL >10.0**
- **SQL** para ETL e análise
- **CSV** para dados cadastrais

## ⚙️ Configuração do Ambiente

### 📋 Pré-requisitos
- Banco de dados MySQL ou PostgreSQL instalado
- Acesso aos dados abertos da ANS


## 🔄 Fluxo de Trabalho

1. **Preparação dos Dados**:
   ```bash
   # Baixar demonstrações contábeis
   wget -r -np -nH --cut-dirs=3 -R "index.html*" https://dadosabertos.ans.gov.br/ETP/PDA/demonstracoes_contabeis/ -P data/demonstracoes_contabeis/

   # Baixar dados cadastrais
   wget https://dadosabertos.ans.gov.br/ETP/PDA/operadoras_de_plano_de_saude_ativas/Operadoras_ativas.csv -O data/operadoras_ativas.csv
    ```

# Exercício 4 - API REST com Django e Vue.js

![Django](https://img.shields.io/badge/Django-092E20?style=for-the-badge&logo=django&logoColor=white)
![Vue.js](https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vue.js&logoColor=4FC08D)
![SQL](https://img.shields.io/badge/SQL-316192?style=for-the-badge&logo=mysql&logoColor=white)

## 📋 Descrição do Projeto
Aplicação web para busca e filtragem de dados em banco SQL ou arquivos CSV, utilizando:
- **Backend**: Django REST Framework para API
- **Frontend**: Vue.js para interface interativa

## 🎯 Objetivo Principal
Implementar um sistema completo de busca com:
- Integração entre frontend e backend
- Operações CRUD via API REST
- Filtros dinâmicos e paginação

## 🛠 Tecnologias Utilizadas

### Backend
| Tecnologia | Função |
|------------|--------|
| Python 3.x | Linguagem principal |
| Django 4.x | Framework web |
| Django REST Framework | Construção da API |
| SQLite/PostgreSQL | Banco de dados |

### Frontend
| Tecnologia | Função |
|------------|--------|
| Vue.js 3 | Framework JavaScript |
| Axios | Comunicação com API |
| Vue Router | Gerenciamento de rotas |
| Vuetify | Componentes UI |

## ✨ Funcionalidades
- **API REST com:**
  - ✅ Busca por termos livres
  - ✅ Filtros combinados
  - ✅ Paginação de resultados
  - ✅ Ordenação por colunas

- **Interface Web com:**
  - 🔍 Barra de pesquisa integrada
  - 📊 Visualização em tabela responsiva
  - 📑 Controle de paginação
  - 🖇 Links para detalhes completos

## 🚀 Como Executar

### Pré-requisitos
- Python 3.10+
- Node.js 16+
- pip e npm instalados

### Configuração do Backend

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/exercicio4.git
cd exercicio4/backend

# Configure o ambiente virtual:
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate.bat  # Windows

# Instale as dependências:
pip install -r requirements.txt

# Execute migrações:
python manage.py migrate

# Inicie o servidor 
python manage.py runserver
```

### Configuração do Backend

1. Acesse a pasta do frontend:
```bash
cd ../frontend

# Instale dependências:
npm install

# Inicia a aplicação:
npm run dev

# Porta:
http://localhost:8080
```

👨💻 Autor:
Cabr1to
