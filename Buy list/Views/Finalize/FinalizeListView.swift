//
//  FinalizeListView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct FinalizeListView: View {
    @Binding var list: ShoppingList

    var total: Double {
        list.items.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
    }

    var body: some View {
        List {
            ForEach(list.items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(
                        (item.price * Double(item.quantity))
                            .toCurrency()
                    )
                }
            }

            BudgetProgressView(
                total: total,
                budget: list.budget
            )
        }
        .navigationTitle("Finalizar")
    }
}
