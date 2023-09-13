//
//  LottoViewModel.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/13.
//

import Foundation


class LottoViewModel {
    
    var lottoNoList: [Int] = Array(1...1084).reversed()
    
    var drwNo = LottoObservable(1084)
    var total = LottoObservable(0)
    var num1 = LottoObservable(1)
    var num2 = LottoObservable(2)
    var num3 = LottoObservable(3)
    var num4 = LottoObservable(4)
    var num5 = LottoObservable(5)
    var num6 = LottoObservable(6)
    var bnsNo = LottoObservable(7)
    
    var totalText = LottoObservable("당첨금")
    var titleText = LottoObservable("1084")
    
    func fetchLottoNum() {
        
        
        LottoAPI.shared.lottoNumRequest(drwNo: "\(drwNo.value)") { data in
            self.num1.value = data.drwtNo1
            self.num2.value = data.drwtNo2
            self.num3.value = data.drwtNo3
            self.num4.value = data.drwtNo4
            self.num5.value = data.drwtNo5
            self.num6.value = data.drwtNo6
            self.bnsNo.value = data.bnusNo
            self.total.value = data.totSellamnt
            self.presentTotal()
            self.presentTitle()
        }
        
        
    }
    
    func presentTitle() {
        titleText.value = "\(drwNo.value)회차 당첨번호"
    }
    
    func presentTotal() {
        totalText.value = "총 당첨 금액은 \(format(for: total.value))원 입니다."
    }
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    
    
}
