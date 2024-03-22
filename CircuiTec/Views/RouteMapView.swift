//
//  RouteMapView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 20/03/24.
//

import SwiftUI
import MapKit

struct RouteMapView: View {
    @Environment(\.dismiss) private var dismiss
    
    var route: Route
    
    @State private var mapRoutes: [MKRoute] = []
    
    @State private var routesLoaded = false
    
    
    @State private var showActiveRouteMap = false
    
    @State private var showSheet = true
    
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
            if routesLoaded {
                ForEach(mapRoutes, id: \.self) { mapRoute in
                    MapPolyline(mapRoute)
                        .stroke(Color.blue, lineWidth: 5.0)
                }
            }
            
            if let busLocation = busCurrentLocation {
                Annotation("Bus Location", coordinate: busLocation, anchor: .bottom) {
                    Image(systemName: "bus.fill")
                        .padding(4)
                        .foregroundStyle(.white)
                        .background(Color("Bus\(route.color.rawValue.capitalized)"))
                        .cornerRadius(4)
                }
            }
        }
        .sheet(isPresented: $showSheet, content: {
            GeometryReader { geo in
                VStack(alignment: .center) {
                    Spacer()
                    HStack {
                        Image("BusIcon\(route.color.rawValue)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.leading)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(route.name)
                                .font(.title)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                            Text("Paradas")
                        }
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.separator)
                            .padding()
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    Spacer()
                }
                .presentationDetents([.fraction(0.15), .fraction(0.16)])
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
            }
        })
        .toolbar(.hidden)
        .task {
            showSheet = true
            routesLoaded = false
            mapRoutes = await route.getMKRoutes()
            simulateBusMovementAlongRoute()
            routesLoaded = true
        }
        .navigationDestination(isPresented: $showActiveRouteMap) {
            ActiveRouteMapView()
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

#Preview {
    RouteMapView(route: Route.samples.last!)
}
