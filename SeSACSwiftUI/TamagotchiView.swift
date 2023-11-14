//
//  TamagotchiView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/14/23.
//

import SwiftUI

struct User {
    var nickname = "고래밥"
    
    var introduce: String {
        mutating get {
            nickname = "칙촉"
            return "안녕하세요 \(nickname)입니다."
        }
        
    }
    
    mutating func changeNickname() {
        
        nickname = "칙촉"
    }
}

struct TamagotchiView: View {
    
    @State private var waterCount = 0
    @State private var riceCount = 0
    @State private var isOn = false
    @State private var inputText = ""
    
    var body: some View { // 연산 프로퍼티
        VStack(spacing: 8) {
            TextField("밥알 개수 입력하기", text: $inputText)
                //.padding()
            Toggle("스위치", isOn: $isOn)
                //.padding()
            
            ExtractedView(title: "물방울", count: $waterCount)
            Button("물방울 개수") {
                waterCount += 1
                isOn.toggle()
                
            }
            .padding(50)
            .background(.red)
            
            ExtractedView(title: "밥알", count: $riceCount)
            Button(action: {
                riceCount += 1
            }, label: {
                Text("밥알 개수")
                    .foregroundStyle(.black)
                    .padding(50)
                    .background(.brown)
                Image(systemName: "star")
                    .foregroundStyle(.yellow)
            })
            .border(.black)
            
//            Button("밥알 개수") {
//                riceCount += 1
//
            
        }
        .padding()
    }
}

#Preview {
    TamagotchiView()
}

struct ExtractedView: View {
    
    let title: String
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text("\(title): \(count)개")
                .background(.black)
                .foregroundStyle(.white)
            .font(.title)
            
            Button("하위 뷰 버튼") {
                count += 1
            }
        }
    }
}
