//
//  AddBookView.swift
//  Module 1 wrap up challenge
//
//  Created by Eli Hartnett on 11/20/21.
//

import SwiftUI

struct AddBookView: View {
    
    @EnvironmentObject var model: BookModel
    @Binding var showAddBookView: Bool
    
    @State var book = Book()
    
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                TextField("Title", text: $book.title)
                TextField("Author", text: $book.author)
                TextField("Pages", value: $book.pages, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                
                Spacer()
            }
            
            VStack {
                Divider()
                Text("Rating:")
                Picker("Rating", selection: $book.rating) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                }.pickerStyle(SegmentedPickerStyle())
                
                Divider()
                
                Text("Status:")
                Picker("Status", selection: $book.status) {
                    Text("Plan to read").tag("Plan to read")
                    Text("Reading").tag("Reading")
                    Text("On hold").tag("On hold")
                    Text("Completed").tag("Completed")
                }.pickerStyle(SegmentedPickerStyle())
                
                Divider()
                
                Text("Genre:")
                Picker("Genre", selection: $book.genre) {
                    ForEach(model.genres, id: \.self) { genre in
                        Text(genre).tag(genre)
                    }
                }.pickerStyle(WheelPickerStyle())
                
                Divider()
            }
            
            Button {
                model.addBook(book: book)
                
                showAddBookView = false
            } label: {
                Text("Submit")
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView(showAddBookView: .constant(true)).environmentObject(BookModel())
    }
}
