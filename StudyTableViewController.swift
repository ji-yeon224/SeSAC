//
//  StudyTableViewController.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/27.
//

import UIKit

class StudyTableViewController: UITableViewController {

    
    let studyList = ["변수", "상수", "열거형", "옵셔널 바인딩", "메서드", "프로퍼티", "ㅏㅏㅏ"]
    let appleList = ["아이폰", "아이패드", "애플워치"] //두번째 섹션
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60 //높이 고정 프로퍼티
 
    }
    
    //디폴트는 섹션 1개
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //섹션의 헤더에 있는 타이틀
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "첫번째 섹션" : "두번째 섹션"
        
        
        
    }

    //1. 셀의 개수 (필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? studyList.count : appleList.count
    }
    
    //2. 셀 데이터 및 디자인 처리 (필수)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //identifier에 맞는 셀이 있을 수 있기 때문에 옵셔널로 반환을 해줌 -> 해제 필요!
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        
        
        if indexPath.section == 0 {
            cell.textLabel?.text = studyList[indexPath.row]
        } else {
            cell.textLabel?.text = appleList[indexPath.row]
        }
        
        
        return cell
        
    }
    
    //3. 셀 높이: 서비스 구현에 따라 필요한 경우가 많지만, 항상 같은 높이를 셀에서 사용한다면 비효율적일 수 있음!
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if indexPath.row == 0 {
//            return 50
//        } else {
//            return 100
//        }
//
//    }

   

}
