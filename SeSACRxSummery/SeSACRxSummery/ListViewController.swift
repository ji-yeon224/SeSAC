//
//  ListViewController.swift
//  SeSACRxSummery
//
//  Created by 김지연 on 11/8/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

struct Ment {
    let word: String
    let count: Int
}

struct Mentor: SectionModelType {
    typealias Item = Ment
    
    var name: String
    var items: [Item]
    
}

extension Mentor {
    init(original: Mentor, items: [Ment]) {
        self = original
        self.items = items
    }
}

class ListViewController: UIViewController {
    
    let tableView = UITableView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mentors = [
                
                Mentor(name: "Jack", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ]),
                Mentor(name: "Hue", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ]),
                Mentor(name: "Bran", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ]),
                Mentor(name: "Koko", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ])
                
            ]
        
        // item
        let dataSource = RxTableViewSectionedReloadDataSource<Mentor>(
          configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
              cell.textLabel?.text = "\(item.word): \(item.count)"
            return cell
        })
        
        // header
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].name
        }
     
        Observable.just(mentors)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        
        
        
        configure()
    }
    
    func configure() {
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
}
