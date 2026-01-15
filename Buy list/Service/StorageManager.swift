//
//  StorageManager.swift
//  BuyList
//
//  Created by Lorran Silva on 07/01/26.
//
//
import Foundation

struct StorageManager {

    private static let key = "buylist_saved_lists"

    static func save(_ lists: [ShoppingList]) {
        if let data = try? JSONEncoder().encode(lists) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func load() -> [ShoppingList] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let lists = try? JSONDecoder().decode([ShoppingList].self, from: data)
        else {
            return []
        }
        return lists
    }
}
