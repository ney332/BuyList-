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
var date: Date
}
