//
//  BookView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/20/21.
//

import SwiftUI

struct BookView: View {
    
    @EnvironmentObject var model: BookModel
    @State var showAddBookView = false
    
    var body: some View {
        
        VStack {
            NavigationLink(isActive: $showAddBookView) {
                AddBookView(showAddBookView: $showAddBookView)
            } label: {
                Text("Add book")
            }
            
            ScrollView {
                if !model.genres.isEmpty {
                    ForEach(model.genres, id: \.self) { genre in
                        Text(genre).bold()
                        if !model.books.isEmpty {
                            ForEach(model.books) { book in
                                if book.genre == genre {
                                    NavigationLink {
                                        BookDetailView(book: book)
                                    } label: {
                                        Text(book.title)
                                            .foregroundColor(Color.black)
                                    }
                                }
                            }
                        }
                        Divider().padding()
                    }
                }
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView().environmentObject(BookModel())
    }
}
