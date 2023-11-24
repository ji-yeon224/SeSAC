//
//  ComponentView.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/24/23.
//

import SwiftUI

struct ComponentView: View {
    
    let apple = ["iOS", "iPadOS", "macOS", "watchOS", "visionOS"]
    
    @State var selectedIndex = 3
    
    var body: some View {
        
        List {
            Section {
                Picker(selection: $selectedIndex) {
                    ForEach(apple, id: \.self) { item in
                        Text(item)
                    }
                } label: {
                    Text("Apple")
                }
            .pickerStyle(.menu)
            }
            
            Section {
                Picker(selection: $selectedIndex) {
                    ForEach(apple, id: \.self) { item in
                        Text(item)
                    }
                } label: {
                    Text("Apple")
                }
            .pickerStyle(.menu)
            }
            
        }
    }
}

#Preview {
    ComponentView()
}
