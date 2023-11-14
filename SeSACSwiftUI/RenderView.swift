//
//  RenderView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/13/23.
//

import SwiftUI

struct RenderView: View {
    
    @State var age = 10
    
    var body: some View {
       
        NavigationView { // navigation controller
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.blue]), startPoint: .bottomLeading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [Color.yellow, Color.orange, Color.purple]), center: .topLeading, startRadius: 20, endRadius: 50)
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            AngularGradient(colors: [.yellow, .blue], center: .leading, angle: .degrees(200))
                        
                        
                        )
                }
                .frame(width: .infinity, height: 100)
                NavigationLink("Push") { // 버튼과 같은 역할
                    MenuView()
                }
                Text("Hue: \(age) \(Int.random(in: 1...100))")
                Text("Jack: \(Int.random(in: 1...100))")
                bran
                kokoView()
                Button("클릭") {
                    age = Int.random(in: 1...100)
                }
            }
            .navigationTitle("네비게이션 타이틀")
            .navigationBarItems(leading: Button("버튼", action: {
                
            }))
        }
        
        
    }
    
    var bran: some View {
        Text("Bran: \(Int.random(in: 1...100))")
    }
}

#Preview {
    RenderView()
}


struct kokoView: View {
    var body: some View {
        Text("Koko: \(Int.random(in: 1...100))")
    }
    
}
