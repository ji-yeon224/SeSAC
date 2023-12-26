//
//  ContentView.swift
//  SeSACWebSocket
//
//  Created by 김지연 on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showNextPage = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("이동하기") {
                showNextPage = true
            }
        }
        .padding()
        .sheet(isPresented: $showNextPage, content: {
            SocketView()
        })
    }
}

#Preview {
    ContentView()
}
