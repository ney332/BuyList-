# 🛒 BuyList

## 📱 Sobre o projeto

**BuyList** é um aplicativo iOS desenvolvido em **SwiftUI** com o objetivo de ajudar usuários a organizarem suas compras de mercado de forma simples, eficiente e financeiramente consciente. O app permite criar listas de compras, adicionar itens com preço e quantidade, calcular o total em tempo real e definir um orçamento máximo para cada lista.

---

## 🎯 Para quem é o BuyList?

* Pessoas que desejam **controlar melhor seus gastos no mercado**
* Usuários que costumam extrapolar o orçamento por falta de controle em tempo real
* Qualquer pessoa que queira **organização e praticidade** durante as compras

---

## ❌ Problema que o app resolve

Muitas pessoas vão ao mercado sem saber exatamente quanto estão gastando até chegar ao caixa. Isso gera:

* Estouro de orçamento
* Falta de controle financeiro
* Compras impulsivas

O **BuyList** resolve esse problema ao **somar automaticamente os valores conforme o usuário adiciona ou edita os itens**, permitindo decisões conscientes durante a compra.

---

## ✅ Principais funcionalidades

* Criação de listas de compras
* Adição de itens com:

  * Nome
  * Preço
  * Quantidade (Stepper)
* Cálculo automático do valor total da lista em tempo real
* Definição de orçamento máximo por lista
* Indicação visual quando o orçamento é ultrapassado
* Edição e exclusão de itens
* Histórico de listas (compras anteriores)

---

## 🧠 Arquitetura

O projeto segue uma arquitetura baseada em **MVVM (Model-View-ViewModel)**, aproveitando os padrões modernos do SwiftUI.

### 📦 Model

Responsável pelas estruturas de dados, como:

* Item de compra
* Lista de compras

Contém apenas regras de negócio e dados, sem dependência da interface.

### 🖼 View

Construída inteiramente em **SwiftUI**, responsável por:

* Exibir listas e itens
* Capturar interações do usuário
* Atualizar a interface de forma reativa

### 🔁 ViewModel

* Gerencia o estado da aplicação
* Contém a lógica de cálculo do total
* Faz o binding entre Model e View usando `@State`, `@Binding`, `@Published` e `ObservableObject`

---

## 🛠 Tecnologias utilizadas

* **SwiftUI**
* * **Codable**
* * **Identifiable**
* **MVVM**
* **Xcode**

---

## 🧩 Conceitos aplicados

* Programação reativa com SwiftUI
* Uso de `Stepper` para controle de quantidade
* Cálculo dinâmico com `map` e `reduce`
* Boas práticas de organização de código
* Foco em UX simples e objetiva

---

## 🚀 Possíveis melhorias futuras

* Persistência de dados (CoreData ou UserDefaults)
* Relatórios comparativos entre compras
* Autenticação de usuários
* Sincronização com iCloud
* Versão para iPad

---

## 👨‍💻 Autor

Desenvolvido por **Lorran Ney**, estudante de Sistemas de Informação e desenvolvedor iOS, como projeto prático para estudo de SwiftUI, arquitetura e experiência do usuário.

---

## 📄 Licença

Este projeto é de uso educacional e pessoal. Sinta-se livre para estudar, adaptar e evoluir o código.
