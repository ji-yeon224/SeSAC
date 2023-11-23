//
//  ContentView.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color.brown.ignoresSafeArea()
            VStack {
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foreground(.red) // 버전 대응은 내부에서 처리 됨
               
                Text("iOS")
                    .asPointBackgroundText()
                Text("SwiftUI")
                    .asPointBackgroundText()
                Text("UIKit")
                    .asPointBackgroundText()
                
                Button(action: {
                    
                }, label: {
                    Text("Button")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                })
                
                
            }
            .padding()
        }
        
    }

        
}


#Preview {
    ContentView()
}
