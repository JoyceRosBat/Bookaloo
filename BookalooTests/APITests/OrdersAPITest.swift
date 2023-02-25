//
//  OrdersAPITest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import XCTest
@testable import Bookaloo

final class OrdersAPITest: XCTestCase {
    var mockDependenciesResolver = MockNetworkRequestDependenciesResolver()
    var ordersRepository: ShopRepositoryProtocol?
    
    override func setUpWithError() throws {
        ordersRepository = mockDependenciesResolver.resolve()
    }

    override func tearDownWithError() throws {
        ordersRepository = nil
    }
    
    func test_new_order_with_sucess() async throws {
        let newOrder = Order(email: "joyce.admin@bookaloo.com", order: [8,9,2])
        let order = try await ordersRepository?.new(newOrder)
        XCTAssert(order?.id == "8A48EFE1-A25A-4E34-BF4A-36A18D704763")
        XCTAssert(order?.books?.isEmpty == false)
    }
    
    func test_new_order_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            let order = Order(email: "joyce.admin@bookaloo.com", order: [8,9,2])
            _ = try await ordersRepository?.new(order)
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_check_order_with_sucess() async throws {
        let order = try await ordersRepository?.checkOrder(by: "8A48EFE1-A25A-4E34-BF4A-36A18D704763")
        XCTAssert(order?.status == .received)
        XCTAssert(order?.books?.isEmpty == false)
    }
    
    func test_check_order_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await ordersRepository?.checkOrder(by: "8A48EFE1-A25A-4E34-BF4A-36A18D704763")
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_modify_order_with_sucess() async throws {
        let orderModify = OrderModify(id: "8A48EFE1-A25A-4E34-BF4A-36A18D704763", status: .sent, admin: "joyce.admin@bookaloo.com")
        let order = try await ordersRepository?.modify(orderModify)
        XCTAssert(order != nil)
    }
    
    func test_modify_order_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            let orderModify = OrderModify(id: "8A48EFE1-A25A-4E34-BF4A-36A18D704763", status: .sent, admin: "joyce.admin@bookaloo.com")
            _ = try await ordersRepository?.modify(orderModify)
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_order_status_with_sucess() async throws {
        let order = try await ordersRepository?.getStatus(of: "8A48EFE1-A25A-4E34-BF4A-36A18D704763")
        XCTAssert(order?.status == .sent)
    }
    
    func test_order_status_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await ordersRepository?.getStatus(of: "8A48EFE1-A25A-4E34-BF4A-36A18D704763")
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_user_orders_with_sucess() async throws {
        let order = try await ordersRepository?.getOrders(of: "joyce.admin@bookaloo.com")
        XCTAssert(order?.first?.status == .received)
    }
    
    func test_user_orders_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await ordersRepository?.getOrders(of: "joyce.admin@bookaloo.com")
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_get_all_orders_with_success() async throws {
        let orders = try await ordersRepository?.getAll("joyce.admin@bookaloo.com")
        XCTAssert(orders?.first?.email == "joyce.rosbat@gmail.com")
        XCTAssert(orders?.first?.id == "DD85005F-A179-4FAB-B098-CE8A4A29FAB5")
        XCTAssert(orders?.first?.status == .received)
        XCTAssert(orders?.first?.books?.count == 2)
    }
    
    func test_get_all_orders_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await ordersRepository?.getAll("joyce.admin@bookaloo.com")
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
}
