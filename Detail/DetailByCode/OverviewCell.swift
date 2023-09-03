//
//  OverviewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/04.
//

import UIKit

class OverviewCell: BaseTableViewCell {
    
    let overviewLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = "aaaaadfasdfjkfjkdfjkdjfdkfjkdjfdkfjdkfjdkfjdkfjkjfdkjfkdfjkdjfkdfjkdfdkfkdfjfkdfjkdfjkdjfkdjfkdjfkdjfkdjfkdjdkjlsa;dslkjfl;adjfl;adjfkdjfkdjfkdjfkdjfkdjfkjdkfjkdjfk"
        return view
    }()
    
    let moreImageView = {
        let view = UIImageView()
        //view.image = UIImage(systemName: "chevron.up")
        view.tintColor = .darkGray
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(overviewLabel)
        contentView.addSubview(moreImageView)
        
    }
    
    override func setConstraints() {
        overviewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(22)
            make.top.equalTo(contentView).inset(12)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(overviewLabel.snp.bottom).offset(5)
            make.size.equalTo(25)
            make.bottom.equalTo(contentView)
        }
    }
    
    func setOverViewCell(isExpand: Bool) {
        moreImageView.image = isExpand ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
    }
    
}
