# Atividade I.IV – OWASP

## 1. Objetivo

A atividade teve como objetivo analisar o projeto Metas do Ano utilizando como referência os principais riscos de segurança do OWASP Top 10 2025.

Foi realizada uma análise do código-fonte da aplicação, buscando identificar problemas de segurança, reunir evidências dos problemas encontrados e apresentar possíveis formas de correção.

A categoria **A03:2025 – Software Supply Chain Failures** não foi utilizada, conforme orientação da atividade.

## 2. Metodologia

A análise foi realizada diretamente no código-fonte do projeto utilizando o ambiente GitHub Codespaces.

Foram analisados principalmente os arquivos responsáveis pelo armazenamento de dados, tratamento de erros, regras da aplicação e comunicação com serviços externos.

Também foram utilizados comandos no terminal para localizar possíveis pontos relacionados à segurança, como:

```bash
grep -Rni "print(" lib/
grep -Rni "debugPrint" lib/
grep -Rni "log(" lib/
grep -Rni "usesCleartextTraffic" android/
grep -Rni "cleartext" android/
grep -RniE "password|senha|token|secret|api[_-]?key|credential" lib android
grep -RniE "SharedPreferences|secure_storage|flutter_secure_storage|encrypt|crypto" .
```

Além das buscas automáticas, os arquivos encontrados foram analisados manualmente para verificar o contexto de cada ocorrência.

---

## 3. A04:2025 – Cryptographic Failures

### Problema identificado

Foi identificado que a aplicação utiliza um banco de dados SQLite para armazenar localmente as informações das metas, porém não possui uma camada de criptografia específica implementada para esse armazenamento.

O banco é inicializado no arquivo:

```text
lib/data/db_helper.dart
```

O código responsável por abrir o banco é:

```dart
return await openDatabase(
  path,
  version: 1,
  onCreate: _createDB,
);
```

A tabela armazena informações como título, descrição, status e datas das metas.

### Evidência

O código do arquivo `lib/data/db_helper.dart` mostra que o banco é aberto diretamente através do `openDatabase`, sem uma camada adicional de criptografia implementada pela aplicação.

### Justificativa

Caso o usuário armazene informações que necessitem de confidencialidade no aplicativo, esses dados podem ficar armazenados localmente sem uma proteção criptográfica específica.

O impacto desse problema depende da sensibilidade das informações armazenadas pelo usuário.

### Possível impacto

Uma pessoa que consiga obter acesso ao arquivo do banco de dados poderia analisar os registros armazenados pela aplicação.

### Como poderia ser resolvido

Uma possível solução seria utilizar uma alternativa de banco de dados ou biblioteca que ofereça criptografia para o armazenamento local.

Também seria possível avaliar quais informações realmente precisam de proteção e utilizar mecanismos de armazenamento seguro para os dados mais sensíveis.

---

## 4. A09:2025 – Security Logging and Alerting Failures

### Problema identificado

Durante a análise do projeto não foi identificado um mecanismo de logging utilizado para registrar falhas da aplicação.

Foram realizadas buscas por mecanismos como `print`, `debugPrint` e `log`, sem resultados relevantes.

Além disso, existem situações em que uma exceção é capturada e ignorada.

### Evidência

No arquivo:

```text
lib/data/goal_repository.dart
```

foi encontrado:

```dart
try {
  await api!.syncGoal(created);
} catch (_) {}
```

Também existe o mesmo comportamento durante a atualização:

```dart
try {
  await api!.syncGoal(g);
} catch (_) {}
```

### Justificativa

Quando ocorre uma falha durante a sincronização com a API, a exceção é capturada, mas nenhuma informação sobre o erro é registrada.

Isso dificulta a identificação e investigação posterior das falhas.

### Possível impacto

Caso ocorram erros de sincronização, o desenvolvedor não possui informações suficientes para identificar facilmente quando o problema ocorreu ou qual foi sua causa.

### Como poderia ser resolvido

Poderia ser implementado um mecanismo de logging para registrar erros importantes da aplicação.

Além disso, os blocos `catch` não deveriam simplesmente ignorar as exceções. O erro poderia ser registrado e posteriormente tratado de acordo com o fluxo da aplicação.

---

## 5. A10:2025 – Mishandling of Exceptional Conditions

### Problema identificado

Foi identificado um tratamento inadequado de exceções durante a sincronização das metas com a API.

O problema ocorre quando uma exceção é capturada e descartada utilizando um `catch` vazio.

### Evidência

Arquivo:

```text
lib/data/goal_repository.dart
```

Trecho:

```dart
try {
  await api!.syncGoal(created);
} catch (_) {}
```

E:

```dart
try {
  await api!.syncGoal(g);
} catch (_) {}
```

### Justificativa

A exceção é capturada, mas nenhuma ação é realizada depois dela.

Com isso, uma falha na sincronização pode não ser comunicada ao restante da aplicação nem ao usuário.

### Possível impacto

O usuário pode acreditar que a operação foi sincronizada corretamente enquanto a comunicação com a API pode ter falhado.

### Como poderia ser resolvido

A exceção deveria ser tratada adequadamente. O sistema poderia registrar o erro, atualizar o estado da aplicação e informar ao usuário que a sincronização não foi realizada.

Uma possível implementação seria:

```dart
try {
  final success = await api!.syncGoal(created);

  if (!success) {
    throw Exception('Falha ao sincronizar a meta.');
  }
} catch (e) {
  // registrar e tratar a falha
}
```

---

## 6. A10:2025 – Tratamento das operações do BLoC

### Problema identificado

Outro ponto relacionado ao tratamento de condições excepcionais foi identificado no arquivo:

```text
lib/blocs/goal/goal_bloc.dart
```

As operações de criação, atualização e exclusão não possuem tratamento específico de exceções.

### Evidência

Criação:

```dart
await repo.add(e.goal);
```

Atualização:

```dart
await repo.update(e.goal);
```

Exclusão:

```dart
await repo.delete(e.id);
```

Essas operações não possuem um `try/catch` semelhante ao utilizado no carregamento das metas.

No carregamento existe:

```dart
try {
  final goals = await repo.getAll();
  emit(GoalLoaded(goals));
} catch (err) {
  emit(GoalError(err.toString()));
}
```

### Justificativa

Existe uma diferença no tratamento de erros entre o carregamento e as operações de criação, atualização e exclusão.

Caso ocorra uma exceção durante uma dessas operações, não existe um tratamento equivalente que transforme o erro em um estado controlado da aplicação.

### Possível impacto

Uma falha no banco de dados durante uma operação pode não ser apresentada ao usuário de forma adequada.

### Como poderia ser resolvido

As operações poderiam utilizar tratamento de exceções e emitir `GoalError` quando uma falha ocorrer.

Por exemplo:

```dart
try {
  await repo.add(e.goal);
  add(LoadGoals());
} catch (err) {
  emit(GoalError(err.toString()));
}
```

O mesmo princípio poderia ser aplicado às operações de atualização e exclusão.

---

## 7. Riscos analisados e não identificados

Durante a análise também foram verificadas outras categorias.

### A01 – Broken Access Control

Não foi identificada uma falha de controle de acesso. A aplicação não possui diferentes usuários ou níveis de permissão.

### A02 – Security Misconfiguration

Não foi identificado o uso de `usesCleartextTraffic` ou configurações `cleartext` no projeto Android.

### A05 – Injection

Não foi identificada uma vulnerabilidade de SQL Injection nas operações analisadas.

O banco utiliza parâmetros nas operações, por exemplo:

```dart
where: 'id = ?',
whereArgs: [goal.id],
```

Dessa forma, o valor não é concatenado diretamente na consulta SQL.

### A07 – Authentication Failures

Essa categoria não foi considerada aplicável à versão atual da aplicação, pois o projeto não possui sistema de login ou autenticação.

### A08 – Software or Data Integrity Failures

Não foi encontrada evidência suficiente para classificar o projeto nessa categoria durante a análise realizada.

### A03 – Software Supply Chain Failures

Essa categoria não foi analisada conforme orientação da atividade.

---

## 8. Resumo dos problemas encontrados

| Categoria | Problema                                                         | Arquivo                         |
| --------- | ---------------------------------------------------------------- | ------------------------------- |
| A04       | Banco SQLite sem camada de criptografia específica               | `lib/data/db_helper.dart`       |
| A09       | Ausência de mecanismo de logging para falhas                     | `lib/data/goal_repository.dart` |
| A10       | Exceções da sincronização são ignoradas                          | `lib/data/goal_repository.dart` |
| A10       | Operações do BLoC não possuem tratamento consistente de exceções | `lib/blocs/goal/goal_bloc.dart` |

## 9. Conclusão

A análise do projeto Metas do Ano permitiu identificar pontos que podem representar riscos de segurança relacionados principalmente ao armazenamento local e ao tratamento de erros.

O problema mais evidente foi a utilização de blocos `catch` vazios durante a sincronização com a API, fazendo com que determinadas exceções sejam ignoradas.

Também foi identificada a ausência de uma camada específica de criptografia para o banco SQLite e a falta de um mecanismo de registro das falhas analisadas.

Além dos problemas encontrados, outras categorias do OWASP Top 10 foram verificadas e não apresentaram evidências suficientes de vulnerabilidade no escopo atual do projeto.
