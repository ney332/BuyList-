//
//  EditPriceView.swift
//  Buy list
//
//  Created by Lorran Silva on 06/01/26.
//

import SwiftUI

struct EditPriceView: View {

    @Environment(\.dismiss) var dismiss

    @Binding var price: Double
    @Binding var quantity: Int

    @State private var priceText: String = ""

    var body: some View {
        NavigationStack {
            Form {

                Section(header: Text("Preço")) {
                    TextField("Preço", text: $priceText)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Quantidade")) {
                    Stepper(
                        "Quantidade: \(quantity)",
                        value: $quantity,
                        in: 1...99
                    )
                }
            }
            .navigationTitle("Editar Item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        price = Double(priceText) ?? price
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

