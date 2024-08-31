//
//  DataStorage.swift
//  FightClubApp
//
//  Created by NikolayD on 31.08.2024.
//

import Foundation

final class DataStorage {
    static let shared = DataStorage()
    
    func getShopItems() -> [ShopItem] {
        getItems().map { item in
            ShopItem(item: item, quantity: item.type == .used ? 10 : 1)
        }
    }
    
    func getItems() -> [Item] {
        [
            Item(
                name: "chocolate",
                description: "it makes positive effect to your health",
                type: .used,
                price: 5,
                effects: [.currentHealth: 10]
            ),
            Item(
                name: "coffee",
                description: "it makes you feel full of energy",
                type: .used,
                price: 5,
                effects: [.currentEnergy: 10]
            ),
            Item(
                name: "book",
                description: "it increases your experience",
                type: .used,
                price: 10,
                effects: [.currentExperience: 10]
            ),
            Item(
                name: "knife",
                description: "it increases your damage",
                type: .equipped_hands,
                price: 100,
                effects: [.damage: 2]
            ),
            Item(
                name: "knife_extra",
                description: "it increases your damage",
                type: .equipped_hands,
                price: 150,
                effects: [.damage: 3]
            ),
            Item(
                name: "best knife",
                description: "it increases your damage",
                type: .equipped_hands,
                price: 200,
                effects: [.damage: 4]
            )
        ]
    }
    
    private init() {}
}
