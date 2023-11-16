//
//  SearchView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/16/23.
//

import SwiftUI

struct SearchView: View {
    @State var randomNumber = 0
    
    init(randomNumber: Int = 0) { 
        self.randomNumber = randomNumber
        print("SearchView Init")
    }
    
    var body: some View {
        VStack {
            HueView()
            jackView
            kokoView()
            Text("Bran \(randomNumber)")
                .background(Color.random())
            Button(action: {
                randomNumber = Int.random(in: 1...100)
            }, label: {
                Text("클릭")
            })
        }
    }
    
    var jackView: some View {
        Text("Jack")
            .background(Color.random())
    }
    
    func kokoView() -> some View {
        Text("koko")
            .background(Color.random())
    }
    
}

#Preview {
    SearchView()
}

struct HueView: View {
    
    init() {
        print("HueView init")
    }
    
    var body: some View {
        Text("Hue")
            .background(Color.random())
    }
}


extension Color {
    
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    
}
