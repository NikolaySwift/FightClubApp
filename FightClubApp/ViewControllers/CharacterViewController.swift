//
//  CharacterViewController.swift
//  FightClubApp
//
//  Created by NikolayD on 31.08.2024.
//

import UIKit

protocol ShopViewControllerDelegate: AnyObject {
    var inventory: [Item] { get }
    var money: Int { get }
    
    func buy(_ item: Item, withPrice price: Int)
    func sell(_ item: Item, withPrice price: Int)
}

class CharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
