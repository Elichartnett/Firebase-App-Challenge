//
//  GenresView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/19/21.
//

import SwiftUI

struct GenreView: View {
    
    @EnvironmentObject var model: BookModel
    @State var newGenre = ""
    
    var body: some View {
        VStack {
            
            TextField("New genre", text: $newGenre).multilineTextAlignment(.center)
            
            Button {
                if newGenre != "" {
                    model.addGenre(genre: newGenre)
                    newGenre = ""
                }
            } label: { Text("Add genre") }
            
            ScrollView {
                ForEach(model.genres, id: \.self) { genre in
                    Text(genre)
                }
            }
        }
    }
}

struct GenresView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView().environmentObject(BookModel())
    }
}
