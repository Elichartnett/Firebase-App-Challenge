//
//  ProfileView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/29/21.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @EnvironmentObject var model: BookModel
    
    @State var name: String?
    
    var body: some View {
        VStack {
            
            if model.loggedIn {
                let db = Firestore.firestore()
                let userDoc = db.collection("users").document(Auth.auth().currentUser!.uid)
                let snapshot = userDoc.getDocument { docSnapshot, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    if let docSnapshot = docSnapshot {
                        self.name = docSnapshot.data()?["name"] as? String ?? ""
                    }
                }
                
                if let name = name {
                    Text(name)
                }
                
                Button {
                    try! Auth.auth().signOut()
                    model.loggedIn = false
                    model.genres.removeAll()
                    model.books.removeAll()
                } label: {
                    Text("Sign out")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
