//
//  SheetView.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/24/23.
//

import SwiftUI

struct SheetView: View {
    
    @State private var showSheet = false
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            VStack {
                ShareLink(item: URL(string: "https://www.naver.com")!) {
                    Text("링크 공유하기")
                }
                Text("Hello, World!")
                    .wrapToButton {
                        print("click")
                        showSheet = true
                }
            }
        }
        .sheet(isPresented: $showSheet, content: {
            Text("TEST")
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
        })
    }
}

extension PresentationDetent {
    static let small = Self.height(200)
}

#Preview {
    SheetView()
}
