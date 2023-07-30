//
//  CustomShoppingListTableViewController.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/28.
//

import UIKit

class CustomShoppingListTableViewController: UITableViewController {
    
    @IBOutlet var addButton: UIButton!
    var shoppingList = ShoppingList()
    @IBOutlet var shoppingListTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
    }

    @IBAction func returnKeyClicked(_ sender: UITextField) {
        addButtonClicked(addButton)
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let word = shoppingListTextField.text!
        
        if word.trimmingCharacters(in: .whitespaces).count == 0 {
            textFieldAlert()
            return
        }
        shoppingList.list.append(ListInfo(shopping: word, checked: true, like: false))
        shoppingListTextField.text = ""
       
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomShoppingTableViewCell.identifier) as! CustomShoppingTableViewCell

        let list = shoppingList.list[indexPath.row]
        cell.configShoppingCell(list: list)
        
        return cell
        
    }
    



   
}
