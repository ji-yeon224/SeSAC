//
//  CustomTableViewController.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/28.
//

import UIKit




class CustomTableViewController: UITableViewController {
    
    
    let todo = ToDoInformation()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        
    }
    
    //1.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    //2.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        
        let row = todo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        
        
        
        
        return cell
        
    }
    
    //선택된 셀
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

   

   

}
