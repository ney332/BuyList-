//
//  StatisticsView.swift
//  BuyList
//
//  Created by Lorran on 04/03/26.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject private var viewModel: ShoppingListViewModel

    private var averageSpend: Double {
        guard !viewModel.lists.isEmpty else { return 0 }
        return viewModel.totalSpent / Double(viewModel.lists.count)
    }

    private var mostExpensiveList: ShoppingList? {
        viewModel.lists.max(by: { $0.total < $1.total })
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    SectionTitle("Resumo geral", subtitle: "Uma leitura simples dos seus habitos de compra")

                    HStack(spacing: 12) {
                        MetricTile(
                            label: "Listas criadas",
                            value: "\(viewModel.lists.count)",
                            systemImage: "square.stack.3d.up.fill",
                            tint: AppTheme.secondaryTint
                        )

                        MetricTile(
                            label: "Media por lista",
                            value: averageSpend.toCurrency(),
                            systemImage: "chart.line.uptrend.xyaxis",
                            tint: AppTheme.tint
                        )
                    }

                    MetricTile(
                        label: "Gasto acumulado",
                        value: viewModel.totalSpent.toCurrency(),
                        systemImage: "banknote.fill",
                        tint: AppTheme.tint
                    )

                    GlassCard {
                        VStack(alignment: .leading, spacing: 14) {
                            SectionTitle("Maior lista", subtitle: "Onde o gasto foi mais alto")

                            if let mostExpensiveList {
                                Text(mostExpensiveList.name)
                                    .font(.headline)

                                Text(mostExpensiveList.total.toCurrency())
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(.primary)

                                Text("Orcamento: \(mostExpensiveList.budget.toCurrency())")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            } else {
                                Text("Crie ao menos uma lista para ver comparativos.")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
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
        }
    }
}

#Preview {
    StatisticsView()
}
