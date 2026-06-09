//
//  HomeView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ShoppingListViewModel()

    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Listas", systemImage: "list.bullet.clipboard")
                }

            StatisticsView()
                .tabItem {
                    Label("Resumo", systemImage: "chart.bar.xaxis")
                }

            SettingsView()
                .tabItem {
                    Label("Ajustes", systemImage: "gearshape")
                }
        }
        .environmentObject(viewModel)
    }
}

struct HomeScreen: View {
    @EnvironmentObject private var viewModel: ShoppingListViewModel
    @State private var showNewList = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    heroCard

                    if viewModel.lists.isEmpty {
                        emptyState
                    } else {
                        overviewSection
                        listsSection
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 120)
            }
            .appBackground()
            .navigationTitle("Mercado simple")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewList = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showNewList) {
                NewListView(viewModel: viewModel)
            }
        }
    }

    private var heroCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Mercado simple")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.primary)

                Text("Saiba quanto antes de pagar")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 12) {
                    compactInfo(label: "Listas", value: "\(viewModel.lists.count)")
                    compactInfo(label: "Gasto total", value: viewModel.totalSpent.toCurrency())
                }
            }
        }
    }

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle("Visão geral", subtitle: "Resumo rápido das suas listas")

            HStack(spacing: 12) {
                MetricTile(
                    label: "Orçamento acumulado",
                    value: viewModel.totalBudget.toCurrency(),
                    systemImage: "target",
                    tint: AppTheme.secondaryTint
                )

                MetricTile(
                    label: "Dentro do orçamento",
                    value: "\(viewModel.completedWithinBudget)",
                    systemImage: "checkmark.seal.fill",
                    tint: AppTheme.tint
                )
            }
        }
    }

    private var listsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle("Suas listas", subtitle: "Toque em uma lista para editar os itens")

            ForEach($viewModel.lists) { $list in
                NavigationLink {
                    ListDetailView(list: $list)
                } label: {
                    ShoppingListCard(list: list, onDelete: {
                        viewModel.deleteList(id: list.id)
                    })
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var emptyState: some View {
        GlassCard {
            VStack(spacing: 18) {
                Image(systemName: "cart.badge.plus")
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(AppTheme.tint)
                    .padding(18)
                    .background(Circle().fill(AppTheme.tint.opacity(0.14)))

                VStack(spacing: 8) {
                    Text("Nenhuma lista criada")
                        .font(.title3.weight(.semibold))

                    Text("Monte sua primeira lista para acompanhar orçamento, quantidades e preço de cada item.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                Button {
                    showNewList = true
                } label: {
                    Label("Criar primeira lista", systemImage: "plus")
                }
                .buttonStyle(PrimaryCapsuleButtonStyle())
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func compactInfo(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased())
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)

            Text(value)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.45))
        )
    }
}

private struct ShoppingListCard: View {
    let list: ShoppingList
    let onDelete: () -> Void

    private var progress: Double {
        guard list.budget > 0 else { return 0 }
        return min(list.total / list.budget, 1)
    }

    private var budgetStatusColor: Color {
        if list.budget == 0 { return .secondary }
        return list.total > list.budget ? AppTheme.danger : AppTheme.tint
    }

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(list.name)
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.primary)

                        Text(list.data.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.tertiary)
                }

                HStack(spacing: 12) {
                    listMeta(title: "Itens", value: "\(list.items.count)")
                    listMeta(title: "Orçamento", value: list.budget.toCurrency())
                    listMeta(title: "Atual", value: list.total.toCurrency())
                }

                VStack(alignment: .leading, spacing: 8) {
                    ProgressView(value: progress)
                        .tint(budgetStatusColor)

                    Text(list.budget == 0 ? "Sem orçamento definido" : progress >= 1 ? "Orçamento no limite" : "Compras dentro do planejado")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Button(role: .destructive) {
                        onDelete()
                    } label: {
                        Label("Excluir", systemImage: "trash")
                    }
                }
            }
        }
    }

    private func listMeta(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeView()
}
