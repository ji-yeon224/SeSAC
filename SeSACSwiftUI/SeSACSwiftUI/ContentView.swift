//
//  ContentView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        
       
//        Button("클릭하기") {
//            let value = type(of: self.body)
//            print(value)
//        }
//        .foregroundStyle(.yellow)
//        .background(.green)
        
        VStack {
            Text("안녕하세요")
                .font(.largeTitle)
                .background(Color.black)
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.red)
                .border(.green, width: 10)
            Text("안녕하세요")
                .font(.largeTitle)
                .background(Color.black)
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.red)
                .border(.green, width: 10)
        }
        
    }
}

#Preview {
    ContentView()
}
