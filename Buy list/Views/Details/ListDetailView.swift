//
//  ListDetailView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct ListDetailView: View {

    @State private var showDeleteAlert = false
    @State private var itemToDelete: Int?

    @State private var showEditPrice = false
    @State private var selectedItemIndex: Int?

    @Binding var list: ShoppingList
    @State private var showAddItem = false

    var total: Double {
        list.items.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                BudgetProgressView(
                    total: total,
                    budget: list.budget
                )

                HStack {
                    Text("Total gasto")
                        .font(.headline)
                    Spacer()
                    Text(total.toCurrency())
                        .fontWeight(.bold)
                        .foregroundColor(
                            total > list.budget ? .red : .green
                        )
                }

                VStack(spacing: 12) {
                    ForEach(list.items.indices, id: \.self) { index in
                        let item = list.items[index]

                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                Text("Qtd: \(item.quantity)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Text(
                                (item.price * Double(item.quantity))
                                    .toCurrency()
                            )
                            .fontWeight(.semibold)

                            Button {
                                selectedItemIndex = index
                                showEditPrice = true
                            } label: {
                                Image(systemName: "pencil")
                            }

                            Button {
                                itemToDelete = index
                                showDeleteAlert = true
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .alert("Excluir item?", isPresented: $showDeleteAlert) {
                                Button("Excluir", role: .destructive) {
                                    if let index = itemToDelete {
                                        withAnimation {
                                            list.items.remove(at: index)
                                        }
                                    }
                                }
                                Button("Cancelar", role: .cancel) {}
                            }
                        }
                        .padding()
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    }
                }

                Button {
                    showAddItem = true
                } label: {
                    Label("Adicionar Item", systemImage: "plus.circle.fill")
                        .font(.headline)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle(list.name)
        .sheet(isPresented: $showAddItem) {
            AddItemView(items: $list.items)
        }
        .sheet(isPresented: $showEditPrice) {
            if let index = selectedItemIndex {
                EditPriceView(
                    price: $list.items[index].price,
                    quantity: $list.items[index].quantity
                )
            }
        }
    }
}
