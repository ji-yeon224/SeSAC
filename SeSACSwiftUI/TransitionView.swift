//
//  TransitionView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/15/23.
//

import SwiftUI

/*
 버튼 클릭해서 화면 dismiss / pop
 화면 전환 시 데이터 전달
 화면 전환 시 분기처리
 */

struct TransitionView: View {
    
    @State private var isFull = false
    @State private var isSheet = false
    
    
    var body: some View {
        NavigationView {
            HStack(spacing: 20) {
                Button("Full") {
                    isFull.toggle()
                }
                
                Button("Sheet") {
                    isSheet = true
                }
                NavigationLink("Push") {
                    RenderView()
                }
            }
            .fullScreenCover(isPresented: $isFull, content: {
                RenderView()
            })
            .sheet(isPresented: $isSheet, content: {
                RenderView()
        })
            
        }
    }
}

#Preview {
    TransitionView()
}
