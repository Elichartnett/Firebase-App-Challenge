//
//  GenresView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/19/21.
//

import SwiftUI

struct GenreView: View {
    
    @EnvironmentObject var model: BookModel
    
    
    var body: some View {
        VStack {
            ForEach(model.genres, id: \.self) { genre in
                Text(genre)
            }
        }
    }
}

struct GenresView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView().environmentObject(BookModel())
    }
}
