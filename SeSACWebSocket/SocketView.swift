//
//  SocketView.swift
//  SeSACWebSocket
//
//  Created by 김지연 on 12/26/23.
//

import SwiftUI

struct SocketView: View {
    
    @StateObject
    private var viewModel = SocketViewModel()
    
    
    var body: some View {
        VStack {
            ForEach(viewModel.askOrderBook, id: \.id) { item in
                Text("\(item.price)")
            }
        }
    }
}

#Preview {
    SocketView()
}
