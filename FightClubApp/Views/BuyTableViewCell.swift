//
//  BuyTableViewCell.swift
//  FightClubApp
//
//  Created by NikolayD on 31.08.2024.
//

import UIKit

class BuyTableViewCell: UITableViewCell {
    
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    
    private var shopItem: ShopItem?
    
    private weak var delegate: CellInfoButtonDelegate?
    private var actionCompletion: (() -> Void)?
    
    @IBAction func buyButtonPressed() {
        actionCompletion?()
    }
    
    @IBAction func infoButtonPressed() {
        guard let item = shopItem?.item else { return }
        delegate?.showDetails(for: item)
    }

    func configure(
        with shopItem: ShopItem,
        andInfoDelegate delegate: CellInfoButtonDelegate,
        completion: @escaping () -> Void
    ) {
        self.shopItem = shopItem
        self.delegate = delegate
        actionCompletion = completion
        
        itemNameLabel.text = shopItem.item.name
        itemCountLabel.text = "quantity: \(shopItem.quantity)"
        itemPriceLabel.text = "price: \(shopItem.item.price)"
    }
}
