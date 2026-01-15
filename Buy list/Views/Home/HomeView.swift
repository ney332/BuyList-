//
//  HomeView.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI
struct HomeView: View {
    @StateObject var viewModel = ShoppingListViewModel()
    @State private var showNewList = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.lists.isEmpty {

                    // 🫙 Empty State
                    VStack(spacing: 16) {
                        Image(systemName: "cart")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)

                        Text("Não há nada aqui ainda")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Crie sua primeira lista de compras e acompanhe seus gastos.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)

                        Button {
                            showNewList = true
                        } label: {
                            Label("Criar lista", systemImage: "plus.circle.fill")
                                .font(.headline)
                        }
                    }
                    .padding(.bottom, 200)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else {

                    // 📋 Lista normal
                    List {
                        ForEach($viewModel.lists) { $list in
                            NavigationLink {
                                ListDetailView(list: $list)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(list.name)
                                        .font(.headline)

                                    Text(list.total.toCurrency())
                                        .font(.caption)
                                }
                            }
                        }
                        .onDelete(perform: viewModel.deleteList)
                    }
                }
            }
            .navigationTitle("BuyList")
            .toolbar {
                Button {
                    showNewList = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showNewList) {
                NewListView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView()
}
