//
//  SearchView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/16/23.
//

import SwiftUI

//struct SearchView: View {
//    @State var randomNumber = 0
//    
//    init(randomNumber: Int = 0) {
//        self.randomNumber = randomNumber
//        print("SearchView Init")
//    }
//    
//    var body: some View {
//        VStack {
//            HueView()
//            jackView
//            kokoView()
//            Text("Bran \(randomNumber)")
//                .background(Color.random())
//            Button(action: {
//                randomNumber = Int.random(in: 1...100)
//            }, label: {
//                Text("클릭")
//            })
//        }
//    }
//    
//    var jackView: some View {
//        Text("Jack")
//            .background(Color.random())
//    }
//    
//    func kokoView() -> some View {
//        Text("koko")
//            .background(Color.random())
//    }
//    
//}

struct Movie: Hashable {
    let name: String
    let color = Color.random()
    let count = Int.random(in: 1...100)
}


struct SearchView: View {
    
    @State private var searchQuery = ""
    @State private var showChart = false
    
    let movie = [
        Movie(name: "어벤져스"), Movie(name: "어벤져스2"),
        Movie(name: "엑스맨"), Movie(name: "어벤져스3"),
        Movie(name: "해리포터"), Movie(name: "해리포터2"),
        Movie(name: "aa"), Movie(name: "ff")
    ]
    
    var filterMovie: [Movie] {
        return searchQuery.isEmpty ? movie : movie.filter {
            $0.name.contains(searchQuery)
        }
    }
    
    //let movie = ["ABC", "AB", "아이언맨", "엑스맨", "해리포터"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterMovie, id: \.self) { item in

                    NavigationLink(destination: {
                        SearchDetailView(movie: item)
                    }, label: {
                        HStack {
                            Circle()
                                .foregroundStyle(item.color)
                            Text(item.name)
                            
                        }
                        
                    .frame(height: 60)
                    })
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: {
                        showChart.toggle()
                    }, label: {
                        Image(systemName: "star.fill")
                    })
                }
            }
            .navigationDestination(for: Movie.self) { item in
                SearchDetailView(movie: item)
            }
        }
        
//        NavigationStack {
//            List {
//                ForEach(filterMovie, id: \.self) { item in
//                    
//                    NavigationLink(value: item) {
//                        HStack {
//                            Circle()
//                                .foregroundStyle(item.color)
//                            Text(item.name)
//
//                        }
//
//                    .frame(height: 60)
//                    }
//                    
//                }
//            }
//            .navigationTitle("검색")
//            .navigationDestination(for: Movie.self) { item in
//                SearchDetailView(movie: item)
//            }
//        }
        
        
        .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "검색플레이스 홀더임")
        .onSubmit(of: .search) { // search button clicked
            print("검색 결과~")
        }
        .sheet(isPresented: $showChart, content: {
            ChartView(movie: movie)
        })
    }
    
}


struct SearchDetailView: View {
    @State var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
//        print("cell init")
    }
    
    
    var body: some View {
        Text("\(movie.name)")
            .background(movie.color)
        
    
        VStack {
            Button("버튼") {
                print("aaa")
            }
            Button(action: {
                print("aa")
            }, label: {
                HStack {
                    Circle().foregroundStyle(Color.red)
                    Text("Button")
                }
            })
            .frame(width: 100, height: 40)
        }
    }
    
}


#Preview {
    SearchView()
}

struct HueView: View {
    
    
    init() {
        print("HueView init")
    }
    
    var body: some View {
        Text("Hue")
            .background(Color.random())
    }
}


extension Color {
    
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    
}
