//
//  PurchaseStatus.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 14/2/23.
//

import Foundation

enum PurchaseStatus: String, CaseIterable {
    case inProgress = "procesando"
    case delivered = "entregado"
    case cancelled = "anulado"
}
