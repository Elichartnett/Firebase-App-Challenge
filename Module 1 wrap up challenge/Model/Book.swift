//
//  Book.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/19/21.
//

import Foundation
import SwiftUI

struct Book: Identifiable {
    
    init(id: String = "", title: String = "", author: String = "", rating: Int = 0, status: String = "", genre: String = "Other", pages: Int? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.rating = rating
        self.status = status
        self.genre = genre
        self.pages = pages
    }
    
    var id: String?
    var title: String
    var author: String
    var rating: Int
    var status: String
    var genre: String
    var pages: Int?
}


