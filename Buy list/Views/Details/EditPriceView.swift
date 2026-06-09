//
//  EditPriceView.swift
//  Buy list
//
//  Created by Lorran Silva on 06/01/26.
//

import SwiftUI

struct EditPriceView: View {
    @Environment(\.dismiss) private var dismiss

    let name: String
    @Binding var price: Double
    @Binding var quantity: Int

    @State private var priceText: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    Text(name)
                        .foregroundStyle(.secondary)
                }

                Section("Preco") {
                    TextField("Preco unitario", text: $priceText)
                        .keyboardType(.decimalPad)
                }

                Section("Quantidade") {
                    Stepper("Quantidade: \(quantity)", value: $quantity, in: 1...99)
                }
            }
            .scrollContentBackground(.hidden)
            .appBackground()
            .navigationTitle("Editar item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        price = Double(priceText.replacingOccurrences(of: ",", with: ".")) ?? price
                        dismiss()
                    }
                }
            }
            .onAppear {
                priceText = String(price)
            }
        }
    }
}
