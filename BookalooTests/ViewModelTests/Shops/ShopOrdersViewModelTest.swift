//
//  ShopOrdersViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest
@testable import Bookaloo

final class ShopOrdersViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockShopDependenciesResolver()
    var viewModel: ShopOrdersViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
}
