//
//  ContentView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/19/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var model: BookModel
    
    var body: some View {
        
        if model.loggedIn == false {
            LoginView()
                .onAppear {
                    model.loggedIn = Auth.auth().currentUser != nil ? true : false
                    if model.loggedIn {
                        model.genreListener()
                        model.bookListener()
                    }
                }
        }
        else {
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
                    
                    ProfileView()
                        .tabItem {
                            VStack {
                                Image(systemName: "person.crop.circle")
                                Text("Profile")
                            }
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
