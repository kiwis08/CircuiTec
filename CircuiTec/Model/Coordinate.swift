//
//  Coordinate.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import Foundation
import MapKit
struct Coordinate: Codable, Equatable, Hashable {
    let longitude: Double
    let latitude: Double
    
    var CLCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
