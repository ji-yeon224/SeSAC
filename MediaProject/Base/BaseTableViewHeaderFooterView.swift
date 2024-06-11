//
//  BaseTableViewHeaderFooterView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/30.
//

import UIKit

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
    }
    
    func setConstraints() {
        
    }
    
}
