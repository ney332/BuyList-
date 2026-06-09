//
//  BudgetProgressView.swift
//  Buy list
//
//  Created by Lorran Silva on 06/01/26.
//

import SwiftUI

struct BudgetProgressView: View {
    let total: Double
    let budget: Double

    private var progress: Double {
        guard budget > 0 else { return 0 }
        return min(total / budget, 1)
    }

    private var statusColor: Color {
        guard budget > 0 else { return AppTheme.secondaryTint }
        return total > budget ? AppTheme.danger : AppTheme.tint
    }

    private var statusText: String {
        guard budget > 0 else { return "Sem limite definido" }
        if total > budget {
            return "Acima do orçamento"
        }
        if total == 0 {
            return "Nada lançado ainda"
        }
        return "Dentro do orçamento"
    }

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Orçamento")
                            .font(.headline.weight(.semibold))

                        Text(statusText)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text(total.toCurrency())
                        .font(.title3.weight(.bold))
                        .foregroundStyle(statusColor)
                }

                ProgressView(value: progress)
                    .tint(statusColor)
                    .scaleEffect(y: 1.5)

                HStack {
                    progressItem(title: "Atual", value: total.toCurrency())
                    progressItem(title: "Limite", value: budget.toCurrency())
                    progressItem(
                        title: "Saldo",
                        value: max(budget - total, 0).toCurrency()
                    )
                }
            }
        }
    }

    private func progressItem(title: String, value: String) -> some View {
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
