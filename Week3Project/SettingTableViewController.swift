//
//  SettingTableViewController.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/27.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    let settingHeader = ["전체 설정", "개인 설정", "기타"]
    let allSetting = ["공지사항", "실험실", "버전 정보"]
    let personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let etcSetting = ["고객센터/도움말"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 40
    }
    
    //헤더
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return settingHeader[section]
        } else if section == 1 {
            return settingHeader[section]
        } else {
            return settingHeader[section]
        }
    }
    
    //섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingHeader.count
    }
    
    //셀 개수(필)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allSetting.count
        } else if section == 1 {
            return personalSetting.count
        } else {
            return etcSetting.count
        }
    }
    
    //셀 디자인 및 데이터(필)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        cell.textLabel?.configureTitleText()
        
        if indexPath.section == 0 {
            cell.textLabel?.text = allSetting[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = personalSetting[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = etcSetting[indexPath.row]
        }
        
        return cell
        
    }
    
    
    
    
    

    
}
