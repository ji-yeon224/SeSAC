//
//  ToDoTableViewController.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/27.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var list = ["장보기", "영화보기", "잠자기", "코드보기", "운동하기", "복습하기", "쉬기", "눕기"]

    
    @IBOutlet var addListTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addListButtonClicked(_ sender: UIButton) {
        
        list.append(addListTextField.text!)
        tableView.reloadData()
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        showAlert()
        //1.list애 요소 추가
        list.append("추가")
        print(list)
        
        tableView.reloadData()
        
    }
    
    //1. 섹션 내 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function, indexPath)
        
        //Identifier는 인터페이스 빌더에서 설정
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")! //셀 재사용 (재사용 매커니즘)
        

        
        cell.textLabel?.text = list[indexPath.row]
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? .systemYellow : .white
        
        //cell.textLabel?.textColor = .brown
        //cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.textLabel?.configureTitleText()
        
        cell.detailTextLabel?.text = "디테일 텍스트"
        cell.detailTextLabel?.textColor = .blue
        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        
        cell.imageView?.image = UIImage(systemName: "star.fill")
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function)
        return 70
    }
}
