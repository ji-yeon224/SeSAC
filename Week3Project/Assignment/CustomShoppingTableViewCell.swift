//
//  CustomShoppingTableViewCell.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/29.
//

import UIKit

class CustomShoppingTableViewCell: UITableViewCell {
    
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var checkboxImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var shoppingListLabel: UILabel!
    
    static let identifier = "ListCell"
    var listinfo: ListInfo!

    func configShoppingCell(list: ListInfo) {
        
        shoppingListLabel.text = list.shopping
        //changeCheckBox(list: list)
        //likeButton.setImage(UIImage(systemName: "star"), for: .normal)
        listinfo = list
        
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        print("star")
        listinfo.setLiked()
        if listinfo.like == true {
            likeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    
    func changeCheckBox(list: ListInfo) {
        
        if list.checked == true {
            
            checkboxImageView.image = UIImage(systemName: "checkmark.square.fill")
        } else {
            checkboxImageView.image = UIImage(systemName: "checkmark.square")
        }
        
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        print(listinfo)
        listinfo.setChecked()
        changeCheckBox(list: listinfo)
    }

}
