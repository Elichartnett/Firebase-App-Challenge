//
//  ContentView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/19/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: BookModel
    
    
    var body: some View {
        NavigationView {
            TabView {
                
                BookView()
                    .tabItem {
                        VStack {
                            Image(systemName: "book")
                            Text("Books")
                        }
                    }
                
                GenreView()
                    .tabItem {
                        VStack {
                            Image(systemName: "folder")
                            Text("Genres")
                        }
                    }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(BookModel())
    }
}
