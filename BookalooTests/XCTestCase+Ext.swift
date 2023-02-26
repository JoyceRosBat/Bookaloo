//
//  XCTestCase+Ext.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest

extension XCTestCase {
    func wait(
        _ condition: @escaping @autoclosure () -> (Bool),
        timeout: TimeInterval = 10)
    {
        wait(for: [XCTNSPredicateExpectation(
            predicate: NSPredicate(block: { _, _ in condition() }), object: nil
        )], timeout: timeout)
    }
}
