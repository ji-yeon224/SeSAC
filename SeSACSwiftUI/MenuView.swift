//
//  MenuView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/13/23.
//

import SwiftUI

struct MenuView: View {
    
    var cardProperty: some View {
        VStack(spacing: 10) {
            Image(systemName: "star")
                .background(.red)
            Text("text")
                .background(.green)
        }
        .padding()
        .background(.yellow)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            cardProperty
            //CardView(image: "star", text: "토스뱅크")
            CardView(image: "person", text: "고객센터")
            CardView(image: "pencil", text: "토스증권")
            
        }
        List {
            Section {
                Text("보안과 인증")
                    .modifier(PointBorderText())
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text("날짜") })
                ColorPicker("컬러 설정", selection: /*@START_MENU_TOKEN@*/.constant(.red)/*@END_MENU_TOKEN@*/)
                Text("내 신용점수")
                    .asPointBorderText()
                Text("진행 중인 이벤트")
            }
            
            Section("자산") {
                Text("내 자산")
                Text("송금")
                Text("투자 모아보기")
            }
            
        }
        .listStyle(.plain)
    }
}

#Preview {
    MenuView()
}

struct CardView: View {
    let image: String
    let text: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: image)
                .background(.red)
            Text(text)
                .background(.green)
                .underline()
                .strikethrough()
        }
        .padding()
        .background(.yellow)
    }
}

// custom modifier
struct PointBorderText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(10)
            .foregroundStyle(.white)
            .background(.purple)
            .clipShape(.capsule) // iOS 17+
    }
    
    
}

extension View {
    
    func asPointBorderText() -> some View {
        modifier(PointBorderText())
    }
}
