//
//  PosterView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/15/23.
//

import SwiftUI

struct PosterView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            LazyVStack {
                ForEach(0..<40) { item in
                    AsyncImageView()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            isPresented.toggle()
                        }
                }
            }
//            .frame(maxWidth: .infinity)
        }
        .background(.green)
        .sheet(isPresented: $isPresented, content: {
            CategoryView()
        })
//        .contentMargins(50, for: .scrollContent)
        
        
    }
}


struct AsyncImageView: View {
    
    let url = URL(string: "https://picsum.photos/200")
    
    var body: some View {
        
       
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            case .failure(_):
                Image(systemName: "star")
            @unknown default:
                Image(systemName: "star")
            }
        }
        
    }
}

#Preview {
    PosterView()
}

/*
 //AsyncImage(url: url)
 AsyncImage(url: url) { image in
     image
         .scaledToFit()
         .frame(width: 200, height: 200)
         .clipShape(RoundedRectangle(cornerRadius: 20))
//                .cornerRadius(30)
         
 } placeholder: {
     //Image(systemName: "star")
     ProgressView()
 }
 */
