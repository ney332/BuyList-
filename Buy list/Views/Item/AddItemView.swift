//
//  AddItemsView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct AddItemsView: View {
    @Binding var items: [Item]

    @State private var name = ""
    @State private var quantity = ""
    @State private var price = ""

    var body: some View {
        Form {
            TextField("Produto", text: $name)
            TextField("Quantidade", text: $quantity)
                .keyboardType(.numberPad)
            TextField("Preço", text: $price)
                .keyboardType(.decimalPad)

            Button("Adicionar") {
                let item = Item(
                    name: name,
                    quantity: Int(quantity) ?? 1,
                    price: Double(price) ?? 0
                )
                items.append(item)
                name = ""
                quantity = ""
                price = ""
            }
        }
    }
}

