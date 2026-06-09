//
//  SettingsView.swift
//  BuyList
//
//  Created by Lorran on 04/03/26.
//

import SwiftUI

struct SettingsView: View {
    private var appVersion: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "-"
        return "\(version) (\(build))"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Aplicativo") {
                    settingsRow(label: "Estilo", value: "Visual nativo com foco em listas")
                    settingsRow(label: "Armazenamento", value: "Dados salvos localmente")
                    settingsRow(label: "Versao", value: appVersion)
                }

                Section("Boas praticas") {
                    settingsRow(label: "Orcamento", value: "Defina um teto antes de sair para comprar")
                    settingsRow(label: "Itens", value: "Atualize preco e quantidade conforme comprar")
                    settingsRow(label: "Resumo", value: "Revise a lista antes de finalizar")
                }
            }
            .scrollContentBackground(.hidden)
            .appBackground()
            .navigationTitle("Ajustes")
        }
    }

    private func settingsRow(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}
