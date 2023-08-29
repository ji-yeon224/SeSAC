//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

protocol PassNameDelegate {
    func receiveData(name: String)
}

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    let settingList = ProfileSetting.allCases
    var selectedCell: IndexPath?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(selectedCell)
        
    }
    
    override func configureView() {
        super.configureView()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
}

extension ProfileViewController: PassNameDelegate {
    func receiveData(name: String) {
        if let indexPath = selectedCell {
            guard let cell = mainView.tableView.cellForRow(at: indexPath) as? ProfileTableViewCell else { return }
            cell.textField.text = name
        }
        
        
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as! ProfileTableViewCell
        
        cell.label.text = settingList[indexPath.row].rawValue
        cell.textField.placeholder = settingList[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SettingViewController()
        selectedCell = indexPath
        vc.delegate = self
        vc.title = settingList[indexPath.row].rawValue
        vc.settingList = settingList[indexPath.row]
        
        print(indexPath)
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
