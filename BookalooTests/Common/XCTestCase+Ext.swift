//
//  XCTestCase+Ext.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest

extension XCTestCase {
    /// Waits untill fullfill an expectation condition
    /// ```
    ///        wait(condition)
    /// ```
    /// - Parameters:
    ///   - condition: Condition  to fullfill.
    ///   - timeout: Timeout interval to wait until fullfill the condition
    func wait(
        _ condition: @escaping @autoclosure () -> (Bool),
        timeout: TimeInterval = 10)
    {
        wait(for: [XCTNSPredicateExpectation(
            predicate: NSPredicate(block: { _, _ in condition() }), object: nil
        )], timeout: timeout)
    }
}
