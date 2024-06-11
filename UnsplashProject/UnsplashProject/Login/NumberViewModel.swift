//
//  NumberViewModel.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/18.
//

import Foundation

class NumberViewModel {
    
    var number: Observable<String?> = Observable("1000")
    var result = Observable("1,327,000")
    
    func convertNumber() {
        //빈 값, 문자열, 백만원 내에서 가능
        guard let text = number.value else {
            result.value = "값을 입력해주세요"
            return
        }
        
        guard let textToNumber = Int(text) else {
            result.value = "100만원 이하의 숫자를 입력해주세요"
            return
        }
        
        guard textToNumber > 0, textToNumber <= 1000000 else {
            result.value = "환전 범주는 100만원 이하입니다."
            return
        }
        
        let numberFomatter = NumberFormatter()
        numberFomatter.numberStyle = .decimal
        
        let decimalNumber = numberFomatter.string(for: textToNumber * 1327) ?? "0"
        
        result.value = "환전 금액은 \(decimalNumber)입니다."
    }
    
}
