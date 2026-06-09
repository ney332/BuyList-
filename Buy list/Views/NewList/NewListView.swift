//
//  NewListView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct NewListView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ShoppingListViewModel

    @State private var name = ""
    @State private var budget = ""

    private var canCreate: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nome da lista", text: $name)

                    TextField("Orçamento planejado", text: $budget)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Informações principais")
                } footer: {
                    Text("Você pode deixar o orçamento como zero e ajustar depois, se preferir.")
                }
            }
            .scrollContentBackground(.hidden)
            .appBackground()
            .navigationTitle("Nova lista")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Criar") {
                        viewModel.addList(
                            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                            budget: Double(budget.replacingOccurrences(of: ",", with: ".")) ?? 0
                        )
                        dismiss()
                    }
                    .disabled(!canCreate)
                }
            }
        }
    }
}
