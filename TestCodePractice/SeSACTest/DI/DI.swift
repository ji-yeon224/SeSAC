//
//  DI.swift
//  SeSACTest
//
//  Created by 김지연 on 12/12/23.
//

import Foundation

protocol 중국집 {
    func 근사한점심메뉴() -> String
}

protocol 주방장레시피 {
    func 요리1() -> String
    func 요리2() -> String
    func 요리3() -> String
}

class 브랜: 주방장레시피 {
    func 요리1() -> String {
        return "브랜의 정성이 듬뿍 담긴 꿔바로우"
    }
    
    // 국밥 -> 돈까스
    func 요리2() -> String {
        return "브랜의 최애 국밥"
    }
    
    func 요리3() -> String {
        return "브랜의 을밀대"
    }
}

class 브랜반점: 중국집 { // 하위 모듈
    private var 주인: 주방장레시피!
    
    func 근사한점심메뉴() -> String {
        return 주인.요리1() + 주인.요리2() + 주인.요리3()
    }
}

class 코코종: 주방장레시피 {
    func 요리1() -> String {
        return "코종의 특별한 마법 소스가 들어간 탕수육"
    }
    
    func 요리2() -> String {
        return "마장동 한우 소머리국밥"
    }
    
    func 요리3() -> String {
        return "코종의 최애 밀면"
    }
}

class 코종반점: 중국집 {
    private var 주인: 주방장레시피
    
    init(주인: 주방장레시피) {
        self.주인 = 주인
    }
    
    func 근사한점심메뉴() -> String {
        return 주인.요리1() + 주인.요리2() + 주인.요리3()
    }
}

class 휴님 { // 상위 모듈
    var 중국집: 중국집
    
    init(중국집: 중국집) {
        self.중국집 = 중국집
    }
    
    func 점심밥() -> String {
        중국집.근사한점심메뉴()
    }
}

// 구현체가 아닌 인터페이스 추상화에 의존한다.


