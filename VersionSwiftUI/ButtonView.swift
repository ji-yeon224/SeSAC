//
//  ButtonView.swift
//  VersionSwiftUI
//
//  Created by 김지연 on 11/23/23.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack {
           text
                .wrapToButton {
                    print("==text==")
                }
            image
                .wrapToButton {
                    print("==image==")
                }
         rectangle
                .wrapToButton {
                    print("==rectangle==")
                }
        }
    }
    
    var text: some View {
        Text("Hello, world")
            .padding(30)
            .background(.black)
            .foreground(.white)
            .font(.largeTitle)
            
    }
    var image: some View {
        Image(systemName: "person.fill")
            .scaleEffect(2)
            .padding()
            
        
    }
    
    var rectangle: some View {
        Rectangle()
            .padding()
            .frame(height: 100)
            
    }
}

#Preview {
    ButtonView()
}
