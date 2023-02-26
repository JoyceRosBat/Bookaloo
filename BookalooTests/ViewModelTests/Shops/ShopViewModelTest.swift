//
//  ShopViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest
@testable import Bookaloo

final class ShopViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockShopDependenciesResolver()
    var viewModel: ShopViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_update_cart_with_success() {
        // When
        viewModel?.updateCart()
        // Then
        XCTAssert(self.viewModel?.viewDidLoad == true)
    }
    
    func test_add_to_cart_with_success() {
        // Given
        let book: Book = .test
        viewModel?.booksToShop.removeAll()
        // When
        viewModel?.addToCart(book)
        // Then
        wait((self.viewModel!.booksOrdered > 0))
        
        // When
        viewModel?.removeFromCart(book)
        // Then
        wait((self.viewModel!.booksOrdered == 0))
    }
    
    func test_remove_selected_book_with_success() {
        // Given
        let book: Book = .test
        viewModel?.booksToShop.removeAll()
        // When
        viewModel?.addToCart(book)
        // Then
        wait((self.viewModel!.booksOrdered > 0))
        // Given
        viewModel?.bookSelected = book
        // When
        viewModel?.removeBookSelected()
        // Then
        wait((self.viewModel!.booksOrdered == 0))
        wait(self.viewModel?.bookSelected == nil)
    }
    
    @MainActor
    func test_finish_shopping_with_success() {
        // When
        viewModel?.finishShop()
        // Then
        wait(self.viewModel?.booksOrdered == 0)
        wait(self.viewModel?.shopCompleteAlert == true)
    }
}
