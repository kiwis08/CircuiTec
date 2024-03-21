//
//  Route.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 19/03/24.
//

import Foundation
import SwiftUI
import MapKit

enum RouteColor: String, Codable {
    case red = "Red", blue = "Blue", darkRed = "DarkRed", orange = "Orange"
    
}


struct Route: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let name: String
    let color: RouteColor
    
    init(id: UUID = UUID(), name: String, color: RouteColor) {
        self.id = id
        self.name = name
        self.color = color
    }
    
    static var samples: [Route] = [Route(name: "Ruta Revolución", color: .red), Route(name: "Ruta Valle Alto", color: .blue), Route(name: "Ruta Garza Sada", color: .darkRed), Route(name: "Ruta Hospitales y Escuelas", color: .orange)]
}
