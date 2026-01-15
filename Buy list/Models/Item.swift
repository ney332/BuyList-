//
//  item.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import Foundation

struct Item: Identifiable, Codable {
    let id = UUID()
    var name: String
    var quantity: Int
    var price: Double
}

