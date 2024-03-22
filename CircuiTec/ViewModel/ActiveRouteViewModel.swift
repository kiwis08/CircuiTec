//
//  ActiveRouteViewModel.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import Foundation
import MapKit
class ActiveRouteViewModel: ObservableObject {
    @Published var activeRoute: ActiveRoute?
    @Published var favoriteStops = [FavoriteStop]()
    
    var allRoutes = [
        Route(name: "Ruta Revolución", color: RouteColor.red, stops: [
            RouteStop(name: "CETEC", coordinates: Coordinate(longitude: -100.291688, latitude: 25.650910)),
            RouteStop(name: "Stop 2", coordinates: Coordinate(longitude: -100.290930, latitude: 25.652513)),
            RouteStop(name: "Stop 3", coordinates: Coordinate(longitude: -100.287809, latitude: 25.653731)),
            RouteStop(name: "Stop 4", coordinates: Coordinate(longitude: -100.286225, latitude: 25.653685)),
            RouteStop(name: "Stop 5", coordinates: Coordinate(longitude: -100.280617, latitude: 25.652196)),
            RouteStop(name: "Nuevo Sur", coordinates: Coordinate(longitude: -100.276207, latitude: 25.653184)),
            RouteStop(name: "Stop 7", coordinates: Coordinate(longitude: -100.281807, latitude: 25.659549)),
            RouteStop(name: "Stop 8", coordinates: Coordinate(longitude: -100.284142, latitude: 25.655453)),
            RouteStop(name: "Stop 9", coordinates: Coordinate(longitude: -100.284166, latitude: 25.654945)),
            RouteStop(name: "Stop 10", coordinates: Coordinate(longitude: -100.284265, latitude: 25.652740)),
            RouteStop(name: "Stop 11", coordinates: Coordinate(longitude: -100.286297, latitude: 25.650791)),
            RouteStop(name: "Stop 12", coordinates: Coordinate(longitude: -100.288817, latitude: 25.648863)),
            RouteStop(name: "Stop 13", coordinates: Coordinate(longitude: -100.290625, latitude: 25.648967))
        ]),
        Route(name: "Ruta Valle Alto", color: RouteColor.blue, stops: []),
        Route(name: "Ruta Garza Sada", color: RouteColor.darkRed, stops: []),
        Route(name: "Ruta Hospitales y Escuelas", color: RouteColor.orange, stops: [
            RouteStop(name: "tec cetec", coordinates: Coordinate(longitude: -100.290885, latitude: 25.650398)),
            RouteStop(name: "metrorrey estación Zaragoza", coordinates: Coordinate(longitude: -100.310304, latitude: 25.667856)),
            RouteStop(name: "San Jose", coordinates: Coordinate(longitude: -100.351589, latitude: 25.668528)),
            RouteStop(name: "Zambrano", coordinates: Coordinate(longitude: -100.334144, latitude: 25.647061)),
            RouteStop(name: "EGADE escuela gobierno", coordinates: Coordinate(longitude: -100.325174, latitude: 25.644196)),
            RouteStop(name: "Farmacias Guadalajara rio nazas", coordinates: Coordinate(longitude: -100.309874, latitude: 25.637066)),
            RouteStop(name: "rio aguanaval rio nazar", coordinates: Coordinate(longitude: -100.296733, latitude: 25.641952)),
            RouteStop(name: "oxxo rio panuco", coordinates: Coordinate(longitude: -100.289555, latitude: 25.653800))
        ])
    ]
    
    static var sampleRoutes = [
        Route(name: "Ruta Revolución", color: RouteColor.red, stops: [
            RouteStop(name: "CETEC", coordinates: Coordinate(longitude: -100.291688, latitude: 25.650910)),
            RouteStop(name: "Stop 2", coordinates: Coordinate(longitude: -100.290930, latitude: 25.652513)),
            RouteStop(name: "Stop 3", coordinates: Coordinate(longitude: -100.287809, latitude: 25.653731)),
            RouteStop(name: "Stop 4", coordinates: Coordinate(longitude: -100.286225, latitude: 25.653685)),
            RouteStop(name: "Stop 5", coordinates: Coordinate(longitude: -100.280617, latitude: 25.652196)),
            RouteStop(name: "Nuevo Sur", coordinates: Coordinate(longitude: -100.276207, latitude: 25.653184)),
            RouteStop(name: "Stop 7", coordinates: Coordinate(longitude: -100.281807, latitude: 25.659549)),
            RouteStop(name: "Stop 8", coordinates: Coordinate(longitude: -100.284142, latitude: 25.655453)),
            RouteStop(name: "Stop 9", coordinates: Coordinate(longitude: -100.284166, latitude: 25.654945)),
            RouteStop(name: "Stop 10", coordinates: Coordinate(longitude: -100.284265, latitude: 25.652740)),
            RouteStop(name: "Stop 11", coordinates: Coordinate(longitude: -100.286297, latitude: 25.650791)),
            RouteStop(name: "Stop 12", coordinates: Coordinate(longitude: -100.288817, latitude: 25.648863)),
            RouteStop(name: "Stop 13", coordinates: Coordinate(longitude: -100.290625, latitude: 25.648967))
        ]),
    ]
    
    func startFollowing(route: Route) {
        // Get current route data from backend
        activeRoute = ActiveRoute(route: route, availableSeats: 10, timeLeft: 10)
    }
    
    func stopFollowingRoute() {
        activeRoute = nil
    }
    
    func isFollowing(route: Route) -> Bool {
        return activeRoute?.route == route
    }
    
    var isFollowingRoute: Bool {
        return activeRoute != nil
    }
    
    func getRouteFromStop(stop: RouteStop) -> Route {
        return allRoutes.first { r in
            r.stops.contains(stop)
        }!
    }
    
}
