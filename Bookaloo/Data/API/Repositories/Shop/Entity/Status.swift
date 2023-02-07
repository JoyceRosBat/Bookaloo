//
//  Status.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 7/2/23.
//

import Foundation

enum Status: String, Codable {
    case received = "recibido"
    case processing = "procesando"
    case sent = "enviado"
    case delivered = "entregado"
    case returned = "devuelto"
    case canceled = "anulado"
}
