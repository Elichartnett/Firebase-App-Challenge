//
//  BookModel.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/19/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class BookModel: ObservableObject {
    
    @Published var genres = [String]()
    @Published var books = [Book]()
    
    init() {
        genreListener()
        bookListener()
    }
    
    // Listener to see if genres collection changes in remote data base
    func genreListener() {
        let db = Firestore.firestore()
        
        let collection = db.collection("genres")
        
        collection.document("Other").setData([:])
        
        let genreListener = collection.addSnapshotListener { QuerySnapshot, Error in
            if Error != nil {
                print(Error!.localizedDescription)
            }
            else if QuerySnapshot != nil {
                for docChanged in QuerySnapshot!.documentChanges {
                    
                    if docChanged.type == .added {
                        if !self.genres.contains(docChanged.document.documentID) {
                            self.genres.append(docChanged.document.documentID)
                        }
                    }
                    else if docChanged.type == .removed {
                        self.genres.remove(at: self.genres.firstIndex(of: docChanged.document.documentID)!)
                    }
                }
            }
        }
    }
    
    // Listener to see if books collection changes in remote data base
    func bookListener() {
        let db = Firestore.firestore()
        
        let collection = db.collection("books")
        
        let bookListener = collection.addSnapshotListener { QuerySnapshot, Error in
            if Error != nil {
                print(Error!.localizedDescription)
            }
            else if QuerySnapshot != nil {
                for docChanged in QuerySnapshot!.documentChanges {
                    
                    let id = docChanged.document.data()["id"] as? String ?? ""
                    let title = docChanged.document.data()["title"] as? String ?? ""
                    let author = docChanged.document.data()["author"] as? String ?? ""
                    let rating = docChanged.document.data()["rating"] as? Int ?? 0
                    let status = docChanged.document.data()["status"] as? String ?? ""
                    let genre = docChanged.document.data()["genre"] as? String ?? ""
                    let pages = docChanged.document.data()["pages"] as? Int ?? 0
                    
                    if docChanged.type == .added {
                        self.books.append(Book(id: id, title: title, author: author, rating: rating, status: status, genre: genre, pages: pages))
                    }
                    else if docChanged.type == .modified {
                        for book in self.books {
                            if book.id == id {
                                let updatedBook = Book(id: id, title: title, author: author, rating: rating, status: status, genre: genre, pages: pages)
                                let index = self.books.firstIndex(where: { book in
                                    book.id == id
                                })!
                                self.books.remove(at: index)
                                self.books.insert(updatedBook, at: index)
                                
                            }
                        }
                    }
                    else if docChanged.type == .removed {
                        for index in 0...self.books.count-1 {
                            if self.books[index].id == id {
                                self.books.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Add book to remote data base
    func addBook(book: Book) {
        
        let title = book.title
        let author = book.author
        let rating = book.rating
        let status = book.status
        let genre = book.genre
        let pages = book.pages
        
        let db = Firestore.firestore()
        let collection = db.collection("books")
        let addedBook = collection.document()
        addedBook.setData(["id" : addedBook.documentID, "title" : title, "author" : author, "rating" : rating, "status" : status, "genre" : genre, "pages" : pages])
    }
    
    // Add genre to remote data base
    func addGenre(genre: String) {
        if !genres.contains(where: { existingGenre in
            existingGenre == genre}) {
            let db = Firestore.firestore()
            let collection = db.collection("genres")
            collection.document(genre).setData([:])
        }
    }
}
