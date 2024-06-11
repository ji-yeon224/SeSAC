//
//  ReusableProtocol.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/09/04.
//

import UIKit

protocol ReusableProtocol: AnyObject {
    static var identifier: String{ get }
}

extension UIViewController: ReusableProtocol {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {
    public static var identifier: String {
        return String(describing: self)
    }
}


