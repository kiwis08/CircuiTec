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
    let stops: [RouteStop]
    
    init(id: UUID = UUID(), name: String, color: RouteColor, stops: [RouteStop]) {
        self.id = id
        self.name = name
        self.color = color
        self.stops = stops
    }
    
    func getMKRoutes() async -> [MKRoute] {
        var mapRoutes = [MKRoute]()
        let request = MKDirections.Request()
        for i in 0...stops.count - 1 {
            
            let stop = stops[i]
            
            var nextStop = stops[0]
            if i != stops.count - 1 {
                nextStop = stops [i + 1]
            }
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: stop.coordinates.CLCoordinate))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: nextStop.coordinates.CLCoordinate))
            
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            guard let foundRoute = response?.routes.first else { continue }
            mapRoutes.append(foundRoute)
        }
        return mapRoutes
    }
}
