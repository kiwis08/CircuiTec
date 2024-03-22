//
//  CircuiTecApp.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 19/03/24.
//

import SwiftUI
import SwiftData

@main
struct CircuiTecApp: App {
    
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
//            NavigationStack(path: $router.navPath) {
//                ContentView()
//                    .navigationDestination(for: Router.Destination.self) { destination in
//                        switch destination {
//                        case .routeMap(let route):
//                            AllRoutesView()
//                        }
//                    }
//            }
//            .environmentObject(router)
        }
        .modelContainer(sharedModelContainer)
    }
}
