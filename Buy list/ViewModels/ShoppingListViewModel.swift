//
//  ShoppingListViewModel.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//
import SwiftUI

class ShoppingListViewModel: ObservableObject {
    @Published var lists: [ShoppingList] = [] {
        didSet {
            StorageManager.save(lists)
        }
    }

    init() {
        lists = StorageManager.load()
        sortListsAlphabetically()
    }
    
    func deleteList(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
        sortListsAlphabetically()
        save()
    }

    func deleteList(id: ShoppingList.ID) {
        lists.removeAll { $0.id == id }
        sortListsAlphabetically()
        save()
    }

    func save() {
        StorageManager.save(lists)
    }

    func addList(name: String, budget: Double) {
        let newList = ShoppingList(
            id: UUID(),
            name: name,
            budget: budget,
            items: [],
            data: Date()
        )
        lists.append(newList)
        sortListsAlphabetically()
    }

    func sortListsAlphabetically() {
        lists = lists.map { list -> ShoppingList in
            var mutableList = list
            mutableList.sortItemsAlphabetically()
            return mutableList
        }.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }

    var totalSpent: Double {
        lists.reduce(0) { $0 + $1.total }
    }

    var totalBudget: Double {
        lists.reduce(0) { $0 + $1.budget }
    }

    var completedWithinBudget: Int {
        lists.filter { $0.total <= $0.budget || $0.budget == 0 }.count
    }
}
