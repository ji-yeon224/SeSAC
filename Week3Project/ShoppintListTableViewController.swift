//
//  ShoppintListTableViewController.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/27.
//

import UIKit

class ShoppintListTableViewController: UITableViewController {

    var shoppingList: [String] = []
    @IBOutlet var addButton: UIButton!
    @IBOutlet var shoppingTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.rowHeight = 60
        
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        addButtonClicked(addButton)
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let word = shoppingTextField.text!
        if word.trimmingCharacters(in: .whitespaces).count == 0 {
            textFieldAlert()
            return
        }
        
        shoppingList.append(shoppingTextField.text!)
        shoppingTextField.text = ""
        tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell")!
        cell.accessoryView = UIImageView(image: UIImage(systemName: "star"))
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
        
    }
    
    
    
  

}
