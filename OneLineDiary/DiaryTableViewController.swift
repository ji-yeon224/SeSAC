//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    var list = ["테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1테스트 1", "테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2테스트 2", "테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3테스트 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //XIB로 테이블 뷰셀을 생성할 경우, 테이블 뷰에 사용할 셀을 등록해주는 과정 필요
        let nib = UINib(nibName: "DiaryTableViewCell", bundle: nil) //nil로 설정하면 메인 번들로 설정됨
        tableView.register(nib, forCellReuseIdentifier: "DiaryTableViewCell")

        //Dynamic Height: 1. automaticDimension 2. label numberOfLines 3. AutoLayout(여백)
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryTableViewCell") as? DiaryTableViewCell else {
            return UITableViewCell()
        } //nil값 발생하면 빈 테이블 뷰 셀 리턴하도록
        
        cell.contentLabel.text = list[indexPath.row]
        cell.contentLabel.numberOfLines = 0
        
        return cell
    }

    //1. canEditRowAt
    //편집 가능한 상태로 쓰겠다. 편집상태 -> true
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //2. commit editingStyle
    // 삭제, 편집, alert창
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        list.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    
//    
//    //leading swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
//        //스와이프 했을 때 나오는 액션이 여러개가 될 수 있기 때문에 배열! 해당 액션들이 uicontextualAction 타입이다.
//    }
//    
//    //trailing swipe
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
//  

}
