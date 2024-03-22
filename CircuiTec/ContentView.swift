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
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
