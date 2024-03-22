//
//  ActiveRouteMapView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import SwiftUI
import MapKit

struct ActiveRouteMapView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ActiveRouteViewModel
    
    @State private var mapRoutes: [MKRoute] = []
    
    @State private var routesLoaded = false
    
    @State private var busCurrentLocation: CLLocationCoordinate2D?
    
    @State private var currentCoordinateIndex = 0
    
    var body: some View {
        Map {
            ForEach(viewModel.activeRoute!.route.stops, id: \.self) { stop in
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
            
            if let busLocation = busCurrentLocation { // Assuming busCurrentLocation is an optional CLLocationCoordinate2D
                Annotation("Bus Location", coordinate: busLocation, anchor: .bottom) {
                    Image(systemName: "bus.fill")
                        .padding(4)
                        .foregroundStyle(.white)
                        .background(Color("Bus\(viewModel.activeRoute!.route.color.rawValue.capitalized)"))
                        .cornerRadius(4)
                }
            }
        }
            .sheet(isPresented: .constant(true), content: {
                GeometryReader { geo in
                    VStack(alignment: .center) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color("Bus\(viewModel.activeRoute!.route.color.rawValue.capitalized)"))
                                    .frame(width: 50, height: 50)
                                VStack(spacing: 0) {
                                    Text("\(viewModel.activeRoute!.timeLeft)")
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, -5)
                                    Text("min")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                }
                                .bold()
                            }
                            Text(viewModel.activeRoute!.route.name)
                                .font(.title)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
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
                        .padding(.top)
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Asientos disponibles")
                                .bold()
                            Spacer()
                            Text("\(viewModel.activeRoute!.availableSeats)")
                                .bold()
                        }
                        .padding(.horizontal)
                        
                        
                        Button(action: {}, label: {
                            Text("Dejar de seguir")
                                .font(.headline)
                        })
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .padding()
                        
                        Spacer()
                        
                        HStack {
                            RouteProgressView(orientation: .vertical, color: Color("Bus\(viewModel.activeRoute!.route.color.rawValue.capitalized)"))
                                .frame(width: geo.size.width / 4)
                            Spacer()
                        }
                
                    }
                    .presentationDetents([.fraction(0.2), .large])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()}
            })
            .toolbar(.hidden)
            .task {
                routesLoaded = false
                mapRoutes = await viewModel.activeRoute!.route.getMKRoutes()
                routesLoaded = true
                simulateBusMovementAlongRoute()
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
    ActiveRouteMapView()
}
