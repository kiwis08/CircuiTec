//
//  ActiveRoute.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import Foundation

class ActiveRoute: ObservableObject {
    let route: Route
    @Published var availableSeats: Int
    @Published var timeLeft: Int

    init(route: Route, availableSeats: Int, timeLeft: Int) {
        self.route = route
        self.availableSeats = availableSeats
        self.timeLeft = timeLeft
    }
}
