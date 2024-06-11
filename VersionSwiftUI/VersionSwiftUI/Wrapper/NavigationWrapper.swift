//
//  NavigationWrapper.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

struct NavigationWrapper<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
        }
    }
    
}
