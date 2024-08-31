//
//  ShopViewController.swift
//  FightClubApp
//
//  Created by NikolayD on 31.08.2024.
//

import UIKit

protocol CellInfoButtonDelegate: AnyObject {
    func showDetails(for item: Item)
}

final class ShopViewController: UIViewController {
    
    @IBOutlet var buySellSegmentControl: UISegmentedControl!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    weak var inventoryDelegate: InventoryDelegate?
    
    private var shopItems: [ShopItem] = DataStorage.shared.getShopItems()
    private var money: Int {
        inventoryDelegate?.money ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMoneyToLabel()
        setupTableView()
    }
    
    @IBAction func segmentControlAction() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ShopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch buySellSegmentControl.selectedSegmentIndex {
        case 0:
            return shopItems.isEmpty ? 1 : shopItems.count
        default:
            guard let inventoryDelegate, !inventoryDelegate.inventory.isEmpty else { return 1 }
            return inventoryDelegate.inventory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch buySellSegmentControl.selectedSegmentIndex {
        case 0:
            if shopItems.isEmpty {
                let emptyCell = setupEmptyCell(
                    forTableView: tableView,
                    andIndexPath: indexPath,
                    withText: "There's nothing to buy"
                )
                return emptyCell
            } else {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "buyCell",
                    for: indexPath
                )
                guard let buyCell = cell as? BuyTableViewCell else {
                    return UITableViewCell()
                }
                
                let shopItem = shopItems[indexPath.row]
                buyCell.configure(
                    with: shopItem,
                    andInfoDelegate: self) { [unowned self] in
                        guard money > shopItem.item.price else {
                            showAlert(withTitle: "You can't buy it", andMessage: "You need much money")
                            return
                        }
                        inventoryDelegate?.buy(shopItem.item, withPrice: shopItem.item.price)
                        setMoneyToLabel()
                        shopItems[indexPath.row].quantity -= 1
                        if shopItems[indexPath.row].quantity == 0 {
                            shopItems.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .automatic)
                        } else {
                            tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }
                
                return buyCell
            }
        default:
            guard let inventoryDelegate, !inventoryDelegate.inventory.isEmpty else {
                let emptyCell = setupEmptyCell(
                    forTableView: tableView,
                    andIndexPath: indexPath,
                    withText: "Your inventory is empty"
                )
                return emptyCell
            }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "sellCell",
                for: indexPath
            )
            guard let sellCell = cell as? SellTableViewCell else {
                return UITableViewCell()
            }
            
            let item = inventoryDelegate.inventory[indexPath.row]
            sellCell.configure(
                with: item,
                andInfoDelegate: self) { [unowned self] in
                    inventoryDelegate.sell(item, withPrice: item.price)
                    setMoneyToLabel()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            
            return sellCell
        }
    }
}

// MARK: - UITableViewDelegate
extension ShopViewController: UITableViewDelegate{
    
}

// MARK: - Alert Controller
extension ShopViewController {
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
}

// MARK: - CellInfoButtonDelegate
extension ShopViewController: CellInfoButtonDelegate {
    func showDetails(for item: Item) {
        showAlert(withTitle: item.name, andMessage: item.description)
    }
}

// MARK: - Private
private extension ShopViewController {
    func setupEmptyCell(
        forTableView tableView: UITableView,
        andIndexPath indexPath: IndexPath,
        withText text: String
    ) -> UITableViewCell {
        let emptyCell = tableView.dequeueReusableCell(
            withIdentifier: "emptyCell",
            for: indexPath
        )
        
        var content = emptyCell.defaultContentConfiguration()
        content.text = text
        emptyCell.contentConfiguration = content
        
        return emptyCell
    }
    
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
    }
    
    private func setMoneyToLabel() {
        moneyLabel.text = "Money: \(money)"
    }
}

