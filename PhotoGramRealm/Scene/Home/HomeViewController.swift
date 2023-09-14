//
//  HomeViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
//    lazy var tableView: UITableView = {
//        let view = UITableView()
//        view.rowHeight = 100
//        view.delegate = self
//        view.dataSource = self
//        view.backgroundColor = Constants.BaseColor.background
//        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
//        return view
//    }()
    
    var tasks: Results<DiaryTable>!
    let realm = try! Realm()
    let repository = DiaryTableRepository()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, DiaryTable>!
    
    var editBool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfig()
        tasks = repository.fetch()
        repository.checkSchemaVersion()
        //print(tasks)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(realm.configuration.fileURL!)
        
        collectionView.reloadData()
        
    }
    
    func collectionViewConfig() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.diaryTitle
            content.secondaryText = itemIdentifier.contents
            content.secondaryTextProperties.alignment = .natural
            content.prefersSideBySideTextAndSecondaryText = false
            
            
            
            content.image = self.loadImageFromDocument(fileName: "jy_\(itemIdentifier._id).jpg")
            content.imageProperties.maximumSize.height = 80
            content.imageProperties.maximumSize.width = 80
            content.imageProperties.reservedLayoutSize.height = 80
            content.imageProperties.reservedLayoutSize.width = 80
            
            
            content.imageProperties.cornerRadius = 10
            content.textProperties.color = .white
            
            cell.contentConfiguration = content
            cell.accessories = [
                .delete(
                displayed: .whenEditing,
                actionHandler: {
                    self.removeImageFromDocument(fileName: "jy_\(itemIdentifier._id).jpg")
                    self.repository.deleteItem(itemIdentifier)
                    self.collectionView.reloadData()
                }
            )
            ]
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = Constants.BaseColor.background
            cell.backgroundConfiguration = backgroundConfig

        })
    }
  
    

 
    
    static private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = Constants.BaseColor.background
        configuration.separatorConfiguration.color = .lightGray
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    override func configure() {
        //view.addSubview(tableView)
        view.addSubview(collectionView)
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItems = [editButton, plusButton]
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
        
        
        
        
    }
    
    
    
    
    override func setConstraints() {
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func editButtonTapped() {
        editBool.toggle()
        collectionView.isEditing = editBool
    }
    
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func backupButtonClicked() {
        navigationController?.pushViewController(BackupViewController(), animated: true)
    }
    
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func filterButtonClicked() {
       
        let result = repository.fetchFilterPhoto()
        
        
        
        tasks = result
        //tableView.reloadData()
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = DetailViewController()
        vc.data = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else { return UITableViewCell() }
//
//        let data = tasks[indexPath.row]
//
//        cell.titleLabel.text = data.diaryTitle
//        cell.contentLabel.text = data.contents
//        cell.dateLabel.text = "\(data.diaryDate)"
//
//        cell.diaryImageView.image = loadImageFromDocument(fileName: "jy_\(data._id).jpg")
//        cell.diaryImageView.tintColor = .lightGray
//
////        let value = URL(string: data.diaryPhoto ?? "")
////
////        //셀 서버 통신
////        DispatchQueue.global().async {
////            if let url = value, let data = try? Data(contentsOf: url) {
////
////                DispatchQueue.main.async {
////                   cell.diaryImageView.image = UIImage(data: data)
////                }
////            }
////        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let vc = DetailViewController()
//        vc.data = tasks[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//
//    }
//
//    //스와이프 삭제
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //Realm delete
//            let data = tasks[indexPath.row]
//
//            removeImageFromDocument(fileName: "jy_\(data._id).jpg")
//
//            repository.deleteItem(data)
//
//            tableView.reloadData()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let like = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
//            print("좋아요 선택됨")
//        }
//
//        like.backgroundColor = .orange
//        like.image = tasks[indexPath.row].diaryLike ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
//
//
//        let sample = UIContextualAction(style: .normal, title: "테스트") { action, view, completionHandler in
//            print("테스트 선택됨")
//        }
//
//
//
//        return UISwipeActionsConfiguration(actions: [like, sample])
//    }
//
//}
