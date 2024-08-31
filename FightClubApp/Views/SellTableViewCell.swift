//
//  SellTableViewCell.swift
//  FightClubApp
//
//  Created by NikolayD on 31.08.2024.
//

import UIKit

class SellTableViewCell: UITableViewCell {
    
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    
    private var item: Item?
    
    private weak var delegate: CellInfoButtonDelegate?
    private var actionCompletion: (() -> Void)?

    @IBAction func sellButtonPressed() {
        actionCompletion?()
    }
    
    @IBAction func infoButtonPressed() {
        guard let item else { return }
        delegate?.showDetails(for: item)
    }
    
    func configure(
        with item: Item,
        andInfoDelegate delegate: CellInfoButtonDelegate,
        completion: @escaping () -> Void
    ) {
        self.item = item
        actionCompletion = completion
        self.delegate = delegate
        
        itemNameLabel.text = item.name
        itemPriceLabel.text = "sell price: \(item.price)"
    }
    
}
