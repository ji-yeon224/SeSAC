//
//  PointBackgroundText.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

private struct PointBackgroundText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding(10)
            .foregroundStyle(.white)
            .background(.purple)
            .clipShape(.capsule)
    }
    
}

extension View {
    func asPointBackgroundText() -> some View {
        modifier(PointBackgroundText())
    }
}
