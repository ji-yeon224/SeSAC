//
//  TabBadgeView.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

struct TabBadgeView: View {
    var body: some View {
        TabView {
            ForEach(TabItem.allCases, id: \.hashValue) { item in
                item.rootView
                    .tabItem { item.image }
            }
        }
    }
}

extension TabBadgeView {
    private enum TabItem: CaseIterable {
        case home
        case favorite
        case chat
        case setting
        
        var image: Image {
            switch self {
            case .home:
                Image(systemName: "house")
            case .favorite:
                Image(systemName: "star.fill")
            case .chat:
                Image(systemName: "character.bubble")
            case .setting:
                Image(systemName: "gear")
            }
        }
        
        @ViewBuilder
        var rootView: some View {
            
            switch self {
            case .home:
                ContentView()
            case .favorite:
                ZStack {
                    Color.green
                    Text("Favorite View")
                }
            case .chat:
                ZStack {
                    Color.gray
                    Text("Chat View")
                }
            case .setting:
                ZStack {
                    Color.purple
                    Text("Setting View")
                }
            }
            
        }
    }
    
    
    
}

#Preview {
    TabBadgeView()
}
