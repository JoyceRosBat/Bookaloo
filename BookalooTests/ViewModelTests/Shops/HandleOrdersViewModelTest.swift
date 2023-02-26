//
//  HandleOrdersViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest
@testable import Bookaloo

final class HandleOrdersViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockShopDependenciesResolver()
    var viewModel: HandleOrderViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
}
