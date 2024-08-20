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
    //let item: Item
    let quantity: Int
}
