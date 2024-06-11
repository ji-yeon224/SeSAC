//
//  OverviewTableViewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/16.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    @IBOutlet var overviewLabel: UILabel!
    
    var buttonClicked = false
    
    @IBOutlet var moreImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        moreImageView.tintColor = .black
    }
    
    func setOverviewCell(isExpand: Bool) {
        //moreImageView.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        
        moreImageView.image = isExpand ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        
        
        //print(#function)
    }
    
    



    
}
