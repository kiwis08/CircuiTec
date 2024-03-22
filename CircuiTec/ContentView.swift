//
//  ContentView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 19/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ActiveRouteViewModel()
    @StateObject private var locationManager = LocationManager()
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        TabView {
            FirstView()
                .tabItem {
                    Label("Mi ruta", systemImage: "map")
                }
            AllRoutesView()
                .tabItem {
                    Label("Rutas", systemImage: "bus")
                }
        }
        .onAppear {
            viewModel.favoriteStops.append(FavoriteStop(stop: viewModel.allRoutes.first!.stops.first!, address: "Plaza Nuevo Sur", image: "revolucion"))
            viewModel.favoriteStops.append(FavoriteStop(stop: viewModel.allRoutes.last!.stops[3], address: "Hospital", image: "garza sada"))
        }
        .environmentObject(viewModel)
        .environmentObject(locationManager)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
