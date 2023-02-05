//
//  Book.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

import Foundation

// MARK: - Book
struct Book: Codable, Identifiable, Hashable {
    let pages: Int?
    let year: Int
    let id: Int
    let rating: Double?
    let cover: URL?
    let summary: String?
    var author: String
    let isbn: String?
    let title: String
    let plot: String?
    
    static let test: Book = .init(
        pages: 100,
        year: 1985,
        id: 1,
        rating: 5,
        cover: URL(string: "https://images.gr-assets.com/books/1488137288l/10150.jpg"),
        summary: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras in lobortis enim. Ut lobortis at urna sed imperdiet. Fusce sagittis molestie orci vel pretium. Nunc volutpat justo laoreet aliquet fermentum. Donec non augue odio. Phasellus eget nunc ante. Curabitur fermentum vitae magna at porta. Vestibulum convallis pellentesque dolor, ut elementum sapien dignissim a. Praesent sed dignissim justo, sit amet dapibus elit. Ut sit amet commodo ex, at tempus risus. Maecenas blandit, mauris quis lobortis aliquet, nibh nisi hendrerit turpis, sit amet elementum tortor nibh sit amet ligula. Ut in dolor facilisis, sagittis magna a, ullamcorper ipsum. Mauris facilisis mi eu orci pharetra rhoncus. Nam vitae porttitor urna, eget pretium mauris.
    
Sed efficitur libero id mollis condimentum. In consequat, mauris non convallis interdum, elit sem auctor odio, id facilisis ipsum velit eget lectus. Sed nulla dolor, vulputate nec tellus id, lobortis venenatis lectus. Nunc molestie lorem vitae arcu tristique, fringilla tristique leo posuere. Cras lacus ipsum, imperdiet eu ligula id, vehicula dapibus quam. Integer semper ornare facilisis. Nunc dolor ante, vulputate vel quam in, varius commodo urna. Vivamus sed malesuada nisl. Sed et justo et sapien vehicula lobortis sit amet vitae arcu. Vivamus non euismod nunc, in pharetra nibh. Cras tempus, ligula sed volutpat euismod, justo nisl auctor nisl, a convallis nulla enim vel magna. Sed placerat, orci vitae sagittis bibendum, nisl lacus efficitur nisi, non gravida metus ligula vitae felis. Aenean feugiat facilisis suscipit.
""",
        author: "Isaac Asimov",
        isbn: "1853262455",
        title: "The Lost World",
        plot: """
"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras in lobortis enim. Ut lobortis at urna sed imperdiet. Fusce sagittis molestie orci vel pretium. Nunc volutpat justo laoreet aliquet fermentum. Donec non augue odio. Phasellus eget nunc ante. Curabitur fermentum vitae magna at porta. Vestibulum convallis pellentesque dolor, ut elementum sapien dignissim a. Praesent sed dignissim justo, sit amet dapibus elit. Ut sit amet commodo ex, at tempus risus. Maecenas blandit, mauris quis lobortis aliquet, nibh nisi hendrerit turpis, sit amet elementum tortor nibh sit amet ligula. Ut in dolor facilisis, sagittis magna a, ullamcorper ipsum. Mauris facilisis mi eu orci pharetra rhoncus. Nam vitae porttitor urna, eget pretium mauris.
        
"""
    )
}

struct AsyncBooks: AsyncSequence {
    typealias AsyncIterator = BooksIterator
    typealias Element = Book
    
    let books: [Book]
    
    struct BooksIterator: AsyncIteratorProtocol {
        typealias Element = Book
        var books: IndexingIterator<[Book]>
        
        mutating func next() async throws -> Book? {
            guard let nextBook = books.next() else { return nil }
            return nextBook
        }
    }
    
    func makeAsyncIterator() -> BooksIterator {
        BooksIterator(books: books.makeIterator())
    }
}