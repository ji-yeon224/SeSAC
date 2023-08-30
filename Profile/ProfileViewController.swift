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
    
    var setting: ProfileSetting?
    let settingList = ProfileSetting.allCases
    var selectedCell: IndexPath?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(getChangeGenderObserver), name: .changeGender, object: nil)
    }
    
    @objc func getChangeGenderObserver(notification: NSNotification) {
        print("notification")
        if let indexPath = selectedCell {
            guard let cell = mainView.tableView.cellForRow(at: indexPath) as? ProfileTableViewCell else { return }
            if let gender = notification.userInfo?["gender"] as? String {
                cell.textField.text = gender
            }
            
        }
    }
    
    
    
    override func configureView() {
        super.configureView()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
}

extension ProfileViewController: PassNameDelegate {
    func receiveData(name: String) {
        print("protocol")
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
        
        guard let cell = mainView.tableView.cellForRow(at: indexPath) as? ProfileTableViewCell else { return }
        
        let vc = SettingViewController()
        
        
        selectedCell = indexPath
        setting = settingList[indexPath.row]
        
        if setting == .name {
            vc.completionHandler = { value in
                print("completion handler")
                cell.textField.text = value
            }
                
        }
        
        vc.delegate = self
        vc.title = setting!.rawValue
        vc.settingList = settingList[indexPath.row]
        
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
