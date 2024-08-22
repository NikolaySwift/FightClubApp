//
//  Character.swift
//  FightClubApp
//
//  Created by NikolayD on 19.08.2024.
//

import Foundation

struct Account {
    let login: String
    let password: String
    //let character: Character
}

struct ItemEffect {
    let type: EffectType
    let value: Int
}

enum EffectType: String {
    case strenght = "Strenght"
    case endurance = "Endurance"
    case health = "Health"
    case energy = "Energy"
}

struct ShopItem {
    let item: Item
    let quantity: Int
}

struct Statistics {
    let totalFights: Int
    let wins: Int
    let losses: Int
}

struct Inventory {
    private var equipment: [ItemType: Item?]
    private var items: [Item]
    
    init(items: [Item] = []) {
        equipment = [
            .equipped_head: nil,
            .equipped_body: nil,
            .equipped_legs: nil,
            .equipped_hands: nil
        ]
        self.items = items
    }
    
    mutating func addItem(_ item: Item) {
        items.append(item)
    }
    
    mutating func removeItem(at index: Int) {
        items.remove(at: index)
    }
}

struct Item {
    let name: String
    let description: String
    let type: ItemType
    let price: Int
    let effects: [SecondaryParameter: Int]
}

enum ItemType {
    case used
    case equipped_head
    case equipped_body
    case equipped_legs
    case equipped_hands
}

enum SecondaryParameter {
    case currentHealth
    case maximumHealth
    case currentEnergy
    case maximumEnergy
    case damage
    case defence
    case dodgeChance
}
