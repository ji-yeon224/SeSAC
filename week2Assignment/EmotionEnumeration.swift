//
//  EmotionEnumeration.swift
//  week2Assignment
//
//  Created by 김지연 on 2023/07/25.
//

import Foundation

enum Emotion: Int, CaseIterable {
    case happy = 0
    case good
    case soso
    case notbad
    case sad
    
    var mood: String {
            String(describing: self)
        }
}


