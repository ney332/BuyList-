//
//  AddItemsView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var items: [Item]
    @State private var name = ""
    @State private var isCleaningProduct = false
    @State private var quantity = "1"
    @State private var price = ""

    private var canAdd: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Produto") {
                    TextField("Nome do item", text: $name)

                    Toggle(isOn: $isCleaningProduct) {
                        Label("Produto de limpeza", systemImage: "sparkles")
                    }

                    TextField("Quantidade", text: $quantity)
                        .keyboardType(.numberPad)
                    TextField("Preco unitario", text: $price)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button("Adicionar item") {
                        let item = Item(
                            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                            isCleaningProduct: isCleaningProduct,
                            quantity: max(Int(quantity) ?? 1, 1),
                            price: Double(price.replacingOccurrences(of: ",", with: ".")) ?? 0
                        )
                        items.append(item)
                        dismiss()
                    }
                    .disabled(!canAdd)
                }
            }
            .scrollContentBackground(.hidden)
            .appBackground()
            .navigationTitle("Novo item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}
