//
//  ActiveRouteViewModel.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import Foundation
class ActiveRouteViewModel: ObservableObject {
    @Published var activeRoute: ActiveRoute?
    
    func startFollowing(route: Route) {
        // Get current route data from backend
        activeRoute = ActiveRoute(route: route, availableSeats: 10, timeLeft: 10)
    }
    
    func stopFollowingRoute() {
        activeRoute = nil
    }
    
    var isFollowingRoute: Bool {
        return activeRoute != nil
    }
}
