//
//  LoginView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/29/21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @EnvironmentObject var model: BookModel
    
    @State var selectedTab = "existingUser"
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var errorLabel: String?
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Picker("Tab", selection: $selectedTab) {
                Text("Login").tag("existingUser")
                Text("New account").tag("newUser")
            }
            .padding()
            .pickerStyle(.segmented)
            
            VStack {
                if selectedTab == "newUser" {
                    TextField("Name", text: $name, prompt: Text("Name"))
                }
                TextField("Email", text: $email, prompt: Text("Email"))
                    .autocapitalization(UITextAutocapitalizationType.none)
                    .disableAutocorrection(true)
                SecureField("Password", text: $password, prompt: Text("Password"))
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if errorLabel != nil {
                Text(errorLabel!)
                    .padding()
                    .foregroundColor(Color.red)
            }
            
            Button {
                if selectedTab == "existingUser" {
                    login()
                }
                else {
                    newAccount()
                }
            } label: {
                Text("Submit")
            }
            
            Spacer()
            
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorLabel = error.localizedDescription
            }
            else {
                model.loggedIn = true
                model.genreListener()
                model.bookListener()
            }
        }
    }
    
    func newAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorLabel = error.localizedDescription
            }
            else {
                model.loggedIn = true
                
                let db = Firestore.firestore()
                let doc = db.collection("users").document(Auth.auth().currentUser!.uid).setData(["name" : name], merge: true)
                
                model.genreListener()
                model.bookListener()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
