//
//  MovieView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/14/23.
//

import SwiftUI

struct MovieView: View {
    @State private var isPresented = false
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Spacer()
                Button("SHOW") {
                    isPresented = true
                }
                .padding()
                
                
                Text("담곰!")
                    .fontWeight(.bold)
                Image("damgom")
                    .resizable()
                    .frame(width: 100 , height: 100)
                    .clipShape(Circle())
                    .ignoresSafeArea()
                Spacer()
                HStack {
                    //                    Circle()
                    //                        .foregroundStyle(.pink)
                    //                    Circle()
                    //                        .foregroundStyle(.pink)
                    //                    Circle()
                    //                        .foregroundStyle(.pink)
                    Image("damgom")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    Image("damgom")
                        .resizable()
                        .scaledToFit()
                        .border(Color.blue, width: 5)
                        .ignoresSafeArea()
                    Image("damgom")
                        .resizable()
                        .scaledToFit()
                        .border(Color.blue, width: 5)
                        .ignoresSafeArea()
                }
            }
            .background(.green)
            
        }
        .sheet(isPresented: $isPresented, content: {
            TamagotchiView()
        })
//        .fullScreenCover(isPresented: $isPresented, content: {
//            TamagotchiView()
//            Button(action: {
//                isPresented = false
//            }, label: {
//                Image(systemName: "xmark")
//            })
//        })
        
        
    }
        
}

#Preview {
    MovieView()
}
