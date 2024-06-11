//
//  MainView.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

struct MainView: View {
    
    var sampleText = false
    
    var body: some View {
        NavigationWrapper {
            Text("이것이 네비게이션 래퍼다")
                .navigationTitle("메인")
                .navigationBar {
                    Image(systemName: "star")
                } trailing: {
                    Image(systemName: "pencil")
                }

            sample
        }
    }
    @ViewBuilder
    var sample: some View {
        if sampleText {
            Text("안녕하세요")
        } else {
            Text("안녕히가세요")
        }
    }
}

#Preview {
    MainView()
}
