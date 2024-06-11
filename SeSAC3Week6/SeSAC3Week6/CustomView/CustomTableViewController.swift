//
//  CustomTableViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/24.
//

import UIKit
import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
    
}

class CustomTableViewController: UIViewController {
    
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        
        view.delegate = self // 자기 자신의 인스턴스
        view.dataSource = self
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        return view
    }()
    
    let imageView = {
        let view = PosterImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        print("initial")
        return view
    }()
    
    var list = [Sample(text: "테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트", isExpand: false), Sample(text: "테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트", isExpand: false), Sample(text: "테스트 셀 텍스트", isExpand: false)]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                print("constraints")
                make.size.equalTo(200)
                make.center.equalTo(view)
            }
            
        }
        
        

    }
    

}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.label.text = list[indexPath.row].text
        cell.label.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        list[indexPath.row].isExpand.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
        //tableView.reloadRows(at: IndexPath(row: 3, section: 0), with: .automatic)
        
    }
}
