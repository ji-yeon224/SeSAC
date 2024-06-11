//
//  ButtonWrapper.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(
            action: action
        , label: {
            content
        })
        .buttonStyle(.plain)
    }
    
}

extension View {
    func wrapToButton(_ action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action) )
    }
}
