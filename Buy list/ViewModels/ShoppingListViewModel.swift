//
//  ShoppingListViewModel.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//
import SwiftUI

class ShoppingListViewModel: ObservableObject {
    
    @State private var items: [Item] = []

    @Published var Item: [ShoppingList] = [] {
        didSet {
            StorageManager.save(lists)
        }
    }
    
    @Published var lists: [ShoppingList] = [] {
        didSet {
            StorageManager.save(lists)
        }
    }

    init() {
        lists = StorageManager.load()
    }
    
    func deleteList(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
        save()
    }
    
    func deleteItem(at offsets: IndexSet){
        items.remove(atOffsets: offsets)
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
    }
}
