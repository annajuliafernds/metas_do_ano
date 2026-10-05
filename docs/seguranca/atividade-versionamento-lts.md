# Atividade I.V: Versionamento Semântico e LTS

## 1. Objetivo

O objetivo desta atividade foi identificar a utilização de Versionamento Semântico e LTS (Long Term Support) em três componentes de software utilizados no projeto **Metas do Ano**.

Os componentes analisados foram:

* `flutter_bloc`;
* `sqflite`;
* `http`.

As informações foram verificadas no arquivo `pubspec.yaml` do projeto e nas páginas oficiais dos respectivos pacotes.

---

## 2. Componentes utilizados no projeto

Os três componentes estão declarados no arquivo `pubspec.yaml` do projeto:

```yaml
flutter_bloc: ^8.1.2
sqflite: ^2.2.7+1
http: ^1.1.0
```

Dessa forma, foi possível utilizar componentes que realmente fazem parte do software analisado.

**Evidência:** ![`.yampubspecl`](img/1.png)

---

# 3. Análise do flutter_bloc

O `flutter_bloc` é uma biblioteca utilizada no projeto para gerenciamento de estado.

### Versionamento Semântico

Foi analisado o histórico de versões do pacote no pub.dev. Existem versões como `8.1.2`, `8.1.6`, `9.0.0`, `9.1.0` e `9.1.1`.

As versões seguem a estrutura:

**MAJOR.MINOR.PATCH**

Por exemplo:

* `8` = MAJOR;
* `1` = MINOR;
* `2` = PATCH.

A versão utilizada no projeto é `^8.1.2`.

Portanto, foi identificado o uso de versionamento semântico.

**Resultado:** Sim, utiliza Versionamento Semântico.

### LTS

Foi pesquisada a existência de uma política oficial de Long Term Support para o `flutter_bloc`.

Não foi identificada uma política oficial que determine versões LTS específicas do pacote ou um período de suporte prolongado para determinada versão.

É importante diferenciar uma versão **Stable** de uma versão **LTS**, pois uma versão estável não significa necessariamente que ela terá suporte de longo prazo.

**Resultado:** Não foi identificada uma política oficial de LTS.

### Evidência

![`.yampubspecl`](img/2.png)

---

# 4. Análise do sqflite

O `sqflite` é uma biblioteca utilizada no projeto para trabalhar com banco de dados SQLite.

### Versionamento Semântico

O histórico do pacote apresenta versões como `2.2.7`, `2.3.0` e versões posteriores da série `2.4.x`.

A versão utilizada no projeto é:

```text
^2.2.7+1
```

A parte `2.2.7` segue a estrutura:

**MAJOR.MINOR.PATCH**

O `+1` representa metadado de build e não corresponde a uma quarta parte do número da versão.

Portanto, foi identificado o uso de versionamento semântico.

**Resultado:** Sim, utiliza Versionamento Semântico.

### LTS

Foi pesquisada a existência de uma política oficial de LTS para o `sqflite`.

Não foi identificada uma política oficial de Long Term Support para versões específicas do pacote.

**Resultado:** Não foi identificada uma política oficial de LTS.

### Evidência

![`.yampubspecl`](img/sqf.png)
---

# 5. Análise do http

O `http` é uma biblioteca utilizada para realizar requisições HTTP.

### Versionamento Semântico

O pacote apresenta versões como:

* `1.0.0`;
* `1.1.0`;
* `1.2.0`;
* `1.3.0`;
* `1.4.0`;
* `1.5.0`;
* `1.6.0`.

As versões seguem a estrutura:

**MAJOR.MINOR.PATCH**

A versão declarada no projeto é:

```text
^1.1.0
```

Portanto, foi identificado o uso de versionamento semântico.

**Resultado:** Sim, utiliza Versionamento Semântico.

### LTS

Foi pesquisada a existência de uma política oficial de LTS para o pacote `http`.

Não foi identificada uma política oficial de Long Term Support para versões específicas do pacote.

**Resultado:** Não foi identificada uma política oficial de LTS.

### Evidência

![`.yampubspecl`](img/http.png)
---

# 6. Comparação dos resultados

| Componente     | Versão no projeto | Versionamento Semântico | LTS              |
| -------------- | ----------------- | ----------------------- | ---------------- |
| `flutter_bloc` | `^8.1.2`          | Sim                     | Não identificado |
| `sqflite`      | `^2.2.7+1`        | Sim                     | Não identificado |
| `http`         | `^1.1.0`          | Sim                     | Não identificado |

---

# 7. Conclusão

A análise dos três componentes mostrou que `flutter_bloc`, `sqflite` e `http` utilizam um sistema de versões compatível com o Versionamento Semântico.

Também foi possível perceber que o fato de um pacote possuir versões estáveis não significa necessariamente que ele possua LTS. Para os três componentes analisados, não foi identificada uma política oficial de suporte de longo prazo.

A atividade também ajudou a entender como o controle de versões das dependências pode facilitar a manutenção do projeto e a identificação das alterações entre diferentes versões dos componentes utilizados.

---

# 8. Referências

* Flutter BLoC – versões: https://pub.dev/packages/flutter_bloc/versions
* Sqflite – versões: https://pub.dev/packages/sqflite/versions
* HTTP – versões: https://pub.dev/packages/http/versions
* Dart – Versionamento de pacotes: https://dart.dev/tools/pub/versioning
* Notas de aula – Versionamento Semântico e LTS: https://github.com/persapiens-classes/ifrn-software-quality/blob/main/class/4-security/14-semantic-versioning-lts.md
