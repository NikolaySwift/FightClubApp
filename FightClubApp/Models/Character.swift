//
//  Character.swift
//  FightClubApp
//
//  Created by NikolayD on 19.08.2024.
//

import Foundation
// Раскомментировать Statistics и Inventory как появятся соответствующие структуры
struct Character {
    let name: String
    let level: Int
    let experience: ParametrValue
    let health: ParametrValue
    let energy: ParametrValue
    let strength: Int
    let agility: Int
    let endurance: Int
    //let statistics: Statistics
    //let inventory: Inventory
    let money: Int
}

struct ParametrValue {
    let current: Int
    let max: Int
}
