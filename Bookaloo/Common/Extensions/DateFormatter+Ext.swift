//
//  DateFormatter+Ext.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import Foundation

extension DateFormatter {
    public static let jsonFormatter: DateFormatter = {
        let jsonFormatter = DateFormatter()
        jsonFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return jsonFormatter
    }()
}
