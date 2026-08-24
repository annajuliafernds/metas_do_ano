# 🎯 Metas do Ano - Flutter App

Aplicativo desenvolvido em Flutter para ajudar o usuário a cadastrar, acompanhar e organizar suas metas ao longo do ano.

O projeto permite registrar metas, adicionar descrições, definir datas e acompanhar o progresso de cada objetivo.

## ✨ Funcionalidades

* 📝 Cadastro de metas
* ✏️ Edição de metas
* 👀 Visualização dos detalhes das metas
* ✅ Marcação de metas concluídas
* 🔄 Acompanhamento do status das metas
* 🗑️ Exclusão de metas
* 💾 Persistência dos dados localmente

📁 Organização do projeto

A pasta lib/ concentra o código principal da aplicação e está organizada da seguinte forma:

lib/

├── blocs/

│   └── goal/

├── data/

├── models/

├── screens/

├── utils/

├── widgets/

├── app.dart

└── main.dart

Principais diretórios
blocs/goal — contém a lógica de gerenciamento do estado relacionada às metas.
data — responsável pelos dados e pela persistência da aplicação.
models — contém os modelos utilizados pelo aplicativo.
screens — reúne as telas da aplicação.
utils — contém classes e funções auxiliares.
widgets — reúne componentes reutilizáveis da interface.

O arquivo main.dart é o ponto de entrada da aplicação, enquanto app.dart concentra a configuração principal do aplicativo.

## 🚀 Como executar

### 1. Instalar as dependências

No terminal, dentro da pasta do projeto:

bash
flutter pub get


### 2. Executar o aplicativo

bash
flutter run


Também é possível executar o projeto utilizando um dispositivo Android, emulador ou navegador compatível.

## 📌 Objetivo do projeto

O aplicativo foi desenvolvido como um projeto acadêmico para praticar conceitos de desenvolvimento mobile utilizando Flutter, gerenciamento de estado, persistência local de dados e organização de projetos.

## 👩‍💻 Desenvolvimento

Projeto desenvolvido para fins acadêmicos.

## 🛠️ Tecnologias utilizadas

* **Flutter** — framework utilizado para desenvolvimento do aplicativo
* **Dart** — linguagem de programação
* **Flutter BLoC** — gerenciamento de estado
* **SQLite** — persistência local dos dados
* **Android** — plataforma de execução
* **Web** — suporte para execução no navegador

