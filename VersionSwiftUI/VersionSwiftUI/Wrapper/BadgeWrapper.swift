//
//  BadgeWrapper.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

private struct BadgeWrapper: ViewModifier {
    
    let count: Int
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .badge(count)
        } else { // badge 사용 안함
            content
        }
    }
}

extension View {
    func foreground(_ count: Int) -> some View {
        modifier(BadgeWrapper(count: count))
    }
}
