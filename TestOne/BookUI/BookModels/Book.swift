//
//  Book.swift
//  TestOne
//
//  Created by Emmanuel Nollase on 3/16/23.
//

import SwiftUI

struct Book: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var imageName: String
    var author: String
    var rating: Int
    var bookView: Int
}

var sampleBooks: [Book] = [
    .init(title: "Five Feet Apart: Part 1", imageName: "book_1", author: "Rachel Lippincott", rating: 4, bookView: 1023),
    .init(title: "The Alchemist", imageName: "book_2", author: "William Irvine", rating: 5, bookView: 1024),
    .init(title: "Book of Happines", imageName: "book_3", author: "Anne Hattaway", rating: 6, bookView: 1025),
    .init(title: "Living Alone", imageName: "book_4", author: "Julia Roberts", rating: 7, bookView: 1026),
    .init(title: "Five Feet Apart: Part 2", imageName: "book_5", author: "Jack Black", rating: 8, bookView: 1027)
]
