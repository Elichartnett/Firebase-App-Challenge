//
//  Module_1_wrap_up_challengeApp.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/19/21.
//

import SwiftUI
import Firebase

@main
struct Module_1_wrap_up_challenge: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(BookModel())
        }
    }
}
