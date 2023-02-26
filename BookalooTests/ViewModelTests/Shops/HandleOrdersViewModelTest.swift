//
//  HandleOrdersViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest
@testable import Bookaloo

@MainActor
final class HandleOrdersViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockShopDependenciesResolver()
    var viewModel: HandleOrderViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_get_all_orders_with_success() {
        // When
        viewModel?.getAll()
        // Then
        wait(self.viewModel?.searchOrders.isEmpty == false)
        wait(self.viewModel?.searchOrders.first?.email == "joyce.rosbat@gmail.com")
        wait(self.viewModel?.searchOrders.first?.status == .received)
        wait(self.viewModel?.ordersEmpty == false)
    }
    
    func test_get_orders_by_email_with_success() {
        // When
        viewModel?.getOrders(by: "joyce.admin@bookaloo.com")
        // Then
        wait(self.viewModel?.searchOrders.first?.status == .received)
        wait(self.viewModel?.searchOrders.first?.id == "06311252-884B-444A-BC45-701DE5BAAF7B")
    }
    
    func test_get_order_by_id_with_success() {
        // When
        viewModel?.getOrder(by: "8A48EFE1-A25A-4E34-BF4A-36A18D704763")
        // Then
        wait(self.viewModel?.searchOrders.first?.email == "joyce.admin@bookaloo.com")
        wait(self.viewModel?.searchOrders.first?.id == "8A48EFE1-A25A-4E34-BF4A-36A18D704763")
    }
    
    func test_modify_order_with_success() {
        // When
        viewModel?.getAll()
        // Then
        wait(self.viewModel?.searchOrders.first?.id == "DD85005F-A179-4FAB-B098-CE8A4A29FAB5")
        // When
        viewModel?.modify("DD85005F-A179-4FAB-B098-CE8A4A29FAB5", status: .canceled)
        // Then
        wait(self.viewModel?.searchOrders.first(where: { $0.id == "DD85005F-A179-4FAB-B098-CE8A4A29FAB5" }) != nil)
        if let order = viewModel?.searchOrders.first(where: { $0.id == "DD85005F-A179-4FAB-B098-CE8A4A29FAB5" }) {
            wait(order.status == .canceled)
        }
    }
    
    func test_clean_All_orders_with_success() {
        // When
        viewModel?.cleanSearchOrders()
        // Then
        XCTAssert(viewModel?.searchOrders.isEmpty == true)
    }
}
