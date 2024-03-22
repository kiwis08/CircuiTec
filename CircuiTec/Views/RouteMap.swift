//
//  RouteMap.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import SwiftUI
import MapKit

struct RouteMap: View {
    var route: Route
    var showBusLocation: Bool
    
    @Binding var mapRoutes: [MKRoute]
    
    
    @State private var busCurrentLocation: CLLocationCoordinate2D?
    
    @State private var currentCoordinateIndex = 0
    
    var body: some View {
        Map {
            ForEach(route.stops, id: \.self) { stop in
                Annotation(stop.name, coordinate: stop.coordinates.CLCoordinate) {
                    Image(systemName: "figure.wave")
                        .padding(4)
                        .foregroundStyle(.white)
                        .background(Color.indigo)
                        .cornerRadius(4)
                }
            }
            ForEach(mapRoutes, id: \.self) { mapRoute in
                MapPolyline(mapRoute)
                    .stroke(Color.blue, lineWidth: 5.0)
            }
            
            if let busLocation = busCurrentLocation, showBusLocation {
                Annotation("Bus Location", coordinate: busLocation, anchor: .bottom) {
                    Image(systemName: "bus.fill")
                        .padding(4)
                        .foregroundStyle(.white)
                        .background(Color("Bus\(route.color.rawValue.capitalized)"))
                        .cornerRadius(4)
                }
            }
        }
        .task {
            if showBusLocation {
                simulateBusMovementAlongRoute()
            }
        }
        .onChange(of: mapRoutes) { oldValue, newValue in
            if showBusLocation {
                simulateBusMovementAlongRoute()
            }
        }
    }
    
    
    private func simulateBusMovementAlongRoute() {
        let routeCoordinates = extractCoordinates(from: mapRoutes)
        
        // Check if there are coordinates to follow
        guard !routeCoordinates.isEmpty else { return }
        
        // Initialize bus location to the first coordinate
        busCurrentLocation = routeCoordinates.first
        
        // Timer to update location along the route
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            // Increment the coordinate index to move to the next point
            if currentCoordinateIndex < routeCoordinates.count - 1 {
                currentCoordinateIndex += 1
                busCurrentLocation = routeCoordinates[currentCoordinateIndex]
            } else {
                timer.invalidate() // Stop the timer when we reach the end of the route
            }
        }
    }
    
    private func extractCoordinates(from routes: [MKRoute]) -> [CLLocationCoordinate2D] {
        var coordinates = [CLLocationCoordinate2D]()
        
        for route in routes {
            let polyline = route.polyline
            let pointCount = polyline.pointCount
            
            // Extract the coordinates from the polyline
            var routeCoordinates = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
            polyline.getCoordinates(&routeCoordinates, range: NSRange(location: 0, length: pointCount))
            
            coordinates.append(contentsOf: routeCoordinates)
        }
        
        return coordinates
    }
}
//
//#Preview {
//    RouteMap(route: ActiveRouteViewModel.sampleRoutes.first!, showBusLocation: false)
//}
