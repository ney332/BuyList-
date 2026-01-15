//
//  NewListView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct NewListView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ShoppingListViewModel

    @State private var name = ""
    @State private var budget = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome da lista", text: $name)
                TextField("Orçamento", text: $budget)
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Nova Lista")
            .toolbar {
                Button("Criar") {
                    viewModel.addList(
                        name: name,
                        budget: Double(budget) ?? 0
                    )
                    dismiss()
                }
            }
        }
    }
}
