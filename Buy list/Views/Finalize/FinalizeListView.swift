//
//  FinalizeListView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct FinalizeListView: View {
    @Binding var list: ShoppingList

    private var total: Double {
        list.items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                BudgetProgressView(total: total, budget: list.budget)

                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        SectionTitle("Conferencia final", subtitle: "Resumo pronto para revisar antes de fechar a compra")

                        ForEach(list.items) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                        .font(.headline)

                                    HStack(spacing: 8) {
                                        if item.isCleaningProduct {
                                            Label("Limpeza", systemImage: "sparkles")
                                                .font(.caption.weight(.medium))
                                                .foregroundStyle(AppTheme.secondaryTint)
                                        }

                                        Text("\(item.quantity)x \(item.price.toCurrency())")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }

                                Spacer()

                                Text((item.price * Double(item.quantity)).toCurrency())
                                    .font(.subheadline.weight(.semibold))
                            }

                            if item.id != list.items.last?.id {
                                Divider()
                            }
                        }

                        Divider()

                        HStack {
                            Text("Total")
                                .font(.headline.weight(.semibold))

                            Spacer()

                            Text(total.toCurrency())
                                .font(.title3.weight(.bold))
                                .foregroundStyle(total > list.budget && list.budget > 0 ? AppTheme.danger : AppTheme.tint)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 100)
        }
        .appBackground()
        .navigationTitle("Resumo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
