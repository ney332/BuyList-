//
//  ShoppingList.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import Foundation

struct ShoppingList: Identifiable, Codable {
    let id: UUID
    var name: String
    var budget: Double
    var items: [Item]
    var data: Date
    var total: Double {
        items.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
    }

    mutating func sortItemsAlphabetically() {
        let sortedItems = items.sorted {
            return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }

        if items.map(\.id) != sortedItems.map(\.id) {
            items = sortedItems
        }
    }

    mutating func deleteItem(at index: Int) {
        guard items.indices.contains(index) else { return }
        items.remove(at: index)
        sortItemsAlphabetically()
    }

    mutating func deleteItem(id: Item.ID) {
        items.removeAll { $0.id == id }
        sortItemsAlphabetically()
    }
}
