//
//  OverviewTableViewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/16.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    var buttonClicked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreButton.tintColor = .black
    }
    
    func setOverviewCell() {
        moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        overviewLabel.numberOfLines = 2
    }
    
    

    @IBAction func buttonClicked(_ sender: UIButton) {
        
        buttonClicked.toggle()
        if buttonClicked {
            moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            overviewLabel.numberOfLines = 0

        } else {
            moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            overviewLabel.numberOfLines = 2
        }


    }
    
    func setChangeOverviewCell() {
        buttonClicked.toggle()
        if buttonClicked {
            moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            overviewLabel.numberOfLines = 0
            
        } else {
            moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            overviewLabel.numberOfLines = 2
        }
    }
    
    
}
