//
//  item.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import Foundation

struct Item: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var isCleaningProduct: Bool
    var quantity: Int
    var price: Double

    init(
        id: UUID = UUID(),
        name: String,
        isCleaningProduct: Bool = false,
        quantity: Int,
        price: Double
    ) {
        self.id = id
        self.name = name
        self.isCleaningProduct = isCleaningProduct
        self.quantity = quantity
        self.price = price
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isCleaningProduct
        case quantity
        case price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        isCleaningProduct = try container.decodeIfPresent(Bool.self, forKey: .isCleaningProduct) ?? false
        quantity = try container.decode(Int.self, forKey: .quantity)
        price = try container.decode(Double.self, forKey: .price)
    }
}
