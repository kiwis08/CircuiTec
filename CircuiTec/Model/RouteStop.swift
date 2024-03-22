//
//  RouteStop.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import Foundation
import MapKit

struct RouteStop: Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var name: String
    var coordinates: Coordinate
}
