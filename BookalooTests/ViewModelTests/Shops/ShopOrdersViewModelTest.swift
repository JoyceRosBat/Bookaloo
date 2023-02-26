//
//  ShopOrdersViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest
@testable import Bookaloo

@MainActor
final class ShopOrdersViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockShopDependenciesResolver()
    var viewModel: ShopOrdersViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_get_user_orders_with_success() {
        // When
        viewModel?.getOrders()
        // Then
        wait(self.viewModel?.userOrders.isEmpty == false)
        wait(self.viewModel?.deliveredList.isEmpty == false)
        wait(self.viewModel?.cancelledList.isEmpty == false)
        wait(self.viewModel?.inProgressList.isEmpty == false)
    }
}
