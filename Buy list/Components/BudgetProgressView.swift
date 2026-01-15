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

    var progress: Double {
        guard budget > 0 else { return 0 }
        return min(total / budget, 1)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ProgressView(value: progress)
                .tint(total > budget ? .red : .green)

            HStack {
                Text("Gasto: \(total.toCurrency())")
                Spacer()
                Text("Limite: \(budget.toCurrency())")
            }
            .font(.caption)
        }
    }
}
