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
    let character: Character
}

struct Character {
    let name: String
    let level: Int
    let experience: ParametrValue
    let health: ParametrValue
    let energy: ParametrValue
    let strength: Int
    let agility: Int
    let endurance: Int
    let statistics: Statistics
    let inventory: Inventory
    let money: Int
}

struct ParametrValue {
    let current: Int
    let max: Int
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
    var quantity: Int
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
    case currentExperience
    case nextLevelExperience
    case damage
    case defence
    case dodgeChance
}
