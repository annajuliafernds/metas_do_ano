# 🎯 Metas do Ano

Aplicativo mobile desenvolvido em **Flutter** para ajudar o usuário a cadastrar, organizar e acompanhar suas metas ao longo do ano.

O projeto foi desenvolvido com foco em boas práticas de desenvolvimento, utilizando **Flutter BLoC para gerenciamento de estado** e **SQLite para persistência local dos dados**.

---

## 📱 Sobre o projeto

O **Metas do Ano** permite que o usuário registre seus objetivos e acompanhe o andamento de cada um deles de forma simples e organizada.

Cada meta pode possuir:

* 📝 Título
* 📄 Descrição
* 📅 Data de criação
* 🎯 Data prevista para conclusão
* 🔄 Status de andamento
* ✅ Conclusão da meta

Os dados são armazenados localmente, permitindo que as metas continuem disponíveis mesmo após fechar o aplicativo.

---

## ✨ Funcionalidades

### 🎯 Gerenciamento de metas

* 📝 **Cadastrar metas**
* ✏️ **Editar metas existentes**
* 👀 **Visualizar detalhes**
* 🔄 **Alterar o status da meta**
* ✅ **Marcar metas como concluídas**
* 🗑️ **Excluir metas**
* 💾 **Salvar os dados localmente**

### 📊 Status das metas

As metas podem ser acompanhadas de acordo com seu status:

| Status          | Descrição                           |
| --------------- | ----------------------------------- |
| 🔄 Em andamento | Meta que ainda está sendo realizada |
| ✅ Concluída     | Meta que foi alcançada              |
| ❌ Não realizada | Meta que não foi concluída          |



## 📁 Estrutura do projeto

A aplicação segue uma organização por responsabilidades, facilitando a manutenção e evolução do código.

lib/

├── blocs/
│   └── goal/

│       ├── goal_bloc.dart

│       ├── goal_event.dart

│       └── goal_state.dart

│
├── data/

│   └── ...

│
├── models/

│   └── ...

│
├── screens/

│   └── ...

│
├── utils/

│   └── ...

│
├── widgets/

│   └── ...

│
├── app.dart

└── main.dart

```

### 📦 Principais diretórios

**`blocs/goal`**
Contém a lógica relacionada ao gerenciamento do estado das metas utilizando o padrão **BLoC**.

**`data`**
Responsável pelo acesso e persistência dos dados da aplicação, incluindo o banco de dados local.

**`models`**
Contém os modelos utilizados para representar os dados das metas.

**`screens`**
Reúne as telas da aplicação.

**`utils`**
Contém classes, funções e recursos auxiliares utilizados pelo projeto.

**`widgets`**
Reúne componentes reutilizáveis da interface.

**`app.dart`**
Concentra a configuração principal da aplicação.

**`main.dart`**
É o ponto de entrada da aplicação Flutter.

---

## 🧠 Arquitetura e gerenciamento de estado

O projeto utiliza o padrão **BLoC (Business Logic Component)** para separar a lógica de negócio da interface.

O fluxo principal funciona da seguinte forma:

```text
┌───────────────┐
│    Usuário    │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│      UI       │
│    Screens    │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│     BLoC      │
│ Events/States │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│     Data      │
│   / SQLite    │
└───────────────┘
```

Essa organização permite manter a interface, a lógica de negócio e a persistência dos dados separadas.

---

## 💾 Persistência dos dados

Os dados das metas são armazenados localmente utilizando **SQLite**.

Isso permite que o aplicativo:

* Salve as metas no dispositivo;
* Recupere os dados ao iniciar novamente;
* Edite registros existentes;
* Exclua metas;
* Mantenha os dados mesmo após o aplicativo ser fechado.

---

## 🛠️ Tecnologias utilizadas

| Tecnologia          | Utilização                   |
| ------------------- | ---------------------------- |
| 🐦 **Flutter**      | Desenvolvimento da aplicação |
| 🎯 **Dart**         | Linguagem de programação     |
| 🔄 **Flutter BLoC** | Gerenciamento de estado      |
| 💾 **SQLite**       | Persistência local           |
| 📱 **Android**      | Plataforma mobile            |
| 🌐 **Web**          | Execução no navegador        |

---

## 🚀 Como executar o projeto

### 1. Pré-requisitos

Antes de executar o projeto, certifique-se de ter instalado:

* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* [Dart SDK](https://dart.dev/get-dart)
* Android Studio ou outro ambiente compatível
* VS Code ou IDE de sua preferência

Para verificar a instalação do Flutter:

bash
flutter doctor


---

### 2. Clonar o repositório

bash
git clone https://github.com/annajuliafernds/metas_do_ano.git


Entre na pasta do projeto:

bash
cd metas_do_ano


---

### 3. Instalar as dependências

Execute:

bash
flutter pub get


---

### 4. Executar o aplicativo

Com um dispositivo, emulador ou navegador disponível:

bash
flutter run


Também é possível selecionar um dispositivo específico:

bash
flutter devices


---

## 🎓 Objetivo acadêmico

O projeto foi desenvolvido como atividade acadêmica com o objetivo de aplicar, na prática, conceitos de desenvolvimento de aplicações mobile utilizando Flutter.

Durante o desenvolvimento foram trabalhados conceitos como:

* Desenvolvimento de interfaces com Flutter;
* Programação em Dart;
* Gerenciamento de estado com BLoC;
* Persistência de dados com SQLite;
* Organização e separação de responsabilidades;
* Criação de componentes reutilizáveis;
* Operações de cadastro, edição e exclusão;
* Desenvolvimento multiplataforma.

---

## 📚 Aprendizados

O desenvolvimento do **Metas do Ano** possibilitou colocar em prática conhecimentos relacionados ao desenvolvimento mobile e à organização de projetos Flutter, especialmente na utilização de gerenciamento de estado e armazenamento local.

O projeto também serviu para compreender melhor a comunicação entre **interface, lógica de negócio e banco de dados** dentro de uma aplicação.

---

## 🔮 Possíveis melhorias futuras

Algumas funcionalidades podem ser adicionadas em versões futuras:

* 📊 Dashboard com estatísticas das metas;
* 📈 Indicador visual de progresso;
* 🔔 Notificações de prazo;
* 🔎 Busca e filtros;
* 🏷️ Categorias para as metas;
* ☁️ Sincronização em nuvem;
* 👤 Sistema de login e contas de usuário;
* 🌙 Modo escuro;
* 📅 Visualização das metas em calendário.

---

## 👩‍💻 Projeto acadêmico

**Metas do Ano**
Aplicação desenvolvida para fins acadêmicos utilizando Flutter, Dart, BLoC e SQLite.

---

⭐ **Projeto desenvolvido para praticar e aprimorar conhecimentos em desenvolvimento mobile com Flutter.**
