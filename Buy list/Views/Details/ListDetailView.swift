//
//  ListDetailView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct ListDetailView: View {
    @Binding var list: ShoppingList

    @State private var showDeleteAlert = false
    @State private var itemToDelete: Int?
    @State private var showEditPrice = false
    @State private var selectedItemIndex: Int?
    @State private var showAddItem = false
    @State private var showOnlyCleaning = false

    private var total: Double {
        list.items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    private var filteredItems: [Item] {
        showOnlyCleaning ? list.items.filter(\.isCleaningProduct) : list.items
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                BudgetProgressView(total: total, budget: list.budget)

                summarySection
                itemsSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 100)
        }
        .appBackground()
        .navigationTitle(list.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    FinalizeListView(list: $list)
                } label: {
                    Text("Resumo")
                        .font(.subheadline.weight(.semibold))
                }
            }
        }
        .sheet(isPresented: $showAddItem) {
            AddItemView(items: $list.items)
        }
        .onAppear {
            list.sortItemsAlphabetically()
        }
        .onChange(of: list.items) { _, _ in
            list.sortItemsAlphabetically()
        }
        .sheet(isPresented: $showEditPrice) {
            if let index = selectedItemIndex {
                EditPriceView(
                    name: list.items[index].name,
                    price: $list.items[index].price,
                    quantity: $list.items[index].quantity
                )
            }
        }
        .alert("Excluir item?", isPresented: $showDeleteAlert) {
            Button("Excluir", role: .destructive) {
                if let index = itemToDelete {
                    list.deleteItem(at: index)
                }
            }
            Button("Cancelar", role: .cancel) {}
        } message: {
            Text("Essa ação remove o item da lista atual.")
        }
    }

    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle("Resumo da lista", subtitle: "Acompanhe valores e quantidade de itens")

            HStack(spacing: 12) {
                MetricTile(
                    label: "Itens cadastrados",
                    value: "\(list.items.count)",
                    systemImage: "basket.fill",
                    tint: AppTheme.secondaryTint
                )

                MetricTile(
                    label: "Total gasto",
                    value: total.toCurrency(),
                    systemImage: "creditcard.fill",
                    tint: total > list.budget && list.budget > 0 ? AppTheme.danger : AppTheme.tint
                )
            }
        }
    }

    private var itemsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                SectionTitle(
                    "Itens",
                    subtitle: list.items.isEmpty
                        ? "Adicione seus produtos para começar"
                        : showOnlyCleaning
                            ? "Filtro ativo para produtos de limpeza"
                            : "Deslize para editar ou excluir"
                )

                Spacer()

                Button {
                    showOnlyCleaning.toggle()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                        Text("Limpeza")
                    }
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 9)
                    .background(
                        Capsule()
                            .fill(showOnlyCleaning ? AppTheme.tint : Color.white.opacity(0.5))
                    )
                    .foregroundStyle(showOnlyCleaning ? .white : AppTheme.secondaryTint)
                }

                Button {
                    showAddItem = true
                } label: {
                    Image(systemName: "plus")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Circle().fill(AppTheme.tint))
                }
            }

            if list.items.isEmpty {
                GlassCard {
                    VStack(spacing: 12) {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundStyle(AppTheme.tint)

                        Text("Sua lista ainda está vazia")
                            .font(.headline)

                        Text("Adicione produtos com quantidade e preço para acompanhar o total automaticamente.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
            } else if filteredItems.isEmpty {
                GlassCard {
                    VStack(spacing: 12) {
                        Image(systemName: "sparkles")
                            .font(.title2)
                            .foregroundStyle(AppTheme.secondaryTint)

                        Text("Nenhum item de limpeza")
                            .font(.headline)

                        Text("Desative o filtro ou marque um novo item como produto de limpeza.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
            } else {
                ForEach(filteredItems) { item in
                    ItemRowCard(item: item, onDelete: {
                        itemToDelete = list.items.firstIndex(where: { $0.id == item.id })
                        showDeleteAlert = true
                    })
                    .onTapGesture {
                        selectedItemIndex = list.items.firstIndex(where: { $0.id == item.id })
                        showEditPrice = true
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            itemToDelete = list.items.firstIndex(where: { $0.id == item.id })
                            showDeleteAlert = true
                        } label: {
                            Label("Excluir", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}

private struct ItemRowCard: View {
    let item: Item
    let onDelete: () -> Void

    private var itemTotal: Double {
        item.price * Double(item.quantity)
    }

    var body: some View {
        GlassCard {
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(AppTheme.tint.opacity(0.12))
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: "bag.fill")
                            .foregroundStyle(AppTheme.tint)
                    )

                VStack(alignment: .leading, spacing: 6) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    HStack(spacing: 10) {
                        if item.isCleaningProduct {
                            Label("Limpeza", systemImage: "sparkles")
                                .font(.caption.weight(.medium))
                                .foregroundStyle(AppTheme.secondaryTint)
                        }

                        Text("Quantidade: \(item.quantity)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text(itemTotal.toCurrency())
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.primary)

                    Text("\(item.price.toCurrency()) cada")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()
                }

                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Circle().fill(AppTheme.danger))
                }
            }
        }
    }
}
