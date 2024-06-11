//
//  NewWordEnum.swift
//  NewlyCoinedWord
//
//  Created by 김지연 on 2023/07/26.
//

import Foundation
enum NewWord: String, CaseIterable {
    case 별다줄 = "별걸 다 줄임"
    case 자강두천 = "자존심 강한 두 천재"
    case 분좋카 = "분위기 좋은 카페"
    case 내봬누 = "내일 봬요 누나"
    case 완내스 = "완전 내 스타일"
    case 오저치고 = "오늘 저녁 치킨 고?"
    case 저메추 = "저녁 메뉴 추천"
    
    var wordString: String {
            String(describing: self)
    }
    
}
