//
//  BookDetailView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/22/21.
//

import SwiftUI
import Firebase

struct BookDetailView: View {
    
    @EnvironmentObject var model: BookModel
    
    @State var book: Book?
    @State var updatedBook = Book()
    
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                TextField("Title", text: $updatedBook.title)
                TextField("Author", text: $updatedBook.author)
                TextField("Pages", value: $updatedBook.pages, formatter: NumberFormatter(), prompt: Text("")).keyboardType(.numberPad)
                
                Spacer()
            }
            
            VStack {
                Divider()
                Text("Rating:")
                Picker("Rating", selection: $updatedBook.rating) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                }.pickerStyle(SegmentedPickerStyle())
                
                Divider()
                
                Text("Status:")
                Picker("Status", selection: $updatedBook.status) {
                    Text("Plan to read").tag("Plan to read")
                    Text("Reading").tag("Reading")
                    Text("On hold").tag("On hold")
                    Text("Completed").tag("Completed")
                }.pickerStyle(SegmentedPickerStyle())
                
                Divider()
                
                Text("Genre:")
                Picker("Genre", selection: $updatedBook.genre) {
                    ForEach(model.genres, id: \.self) { genre in
                        Text(genre).tag(genre)
                    }
                }.pickerStyle(WheelPickerStyle())
                
                Divider()
            }
            
            Button {
                let db = Firestore.firestore()
                let collection = db.collection("books")
                
                collection.getDocuments { (QuerySnapshot, Error) in
                    if Error != nil {
                        print(Error!.localizedDescription)
                    }
                    else if QuerySnapshot != nil {
                        for doc in QuerySnapshot!.documents {
                            if doc.data()["id"] as? String == book!.id {
                                let book = collection.document(doc.documentID)
                                book.setData(["title" : updatedBook.title, "author": updatedBook.author, "rating": updatedBook.rating, "status" : updatedBook.status, "genre" : updatedBook.genre, "pages" : updatedBook.pages], merge: true)
                            }
                            
                        }
                    }
                }
            }
        label: {
            Text("Save Changes")
        }
            
            Button {
                let db = Firestore.firestore()
                let collection = db.collection("books")
                
                collection.getDocuments { QuerySnapshot, Error in
                    if Error != nil {
                        print(Error!.localizedDescription)
                    }
                    else if QuerySnapshot != nil {
                        for doc in QuerySnapshot!.documents {
                            if doc.data()["id"] as? String == book!.id {
                                let book = collection.document(doc.documentID)
                                book.delete()
                            }
                        }
                    }
                }
                
            } label: {
                Text("Delete")
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .onAppear {
            updatedBook.title = book!.title
            updatedBook.author = book!.author
            updatedBook.rating = book!.rating
            updatedBook.status = book!.status
            updatedBook.genre = book!.genre
            updatedBook.pages = book!.pages
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let book = Book(id: "id", title: "Title", author: "Author", rating: 1, status: "Reading", genre: "Comedy", pages: 1)
        BookDetailView(book: book).environmentObject(BookModel())
    }
}
