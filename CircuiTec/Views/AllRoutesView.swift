//
//  AllRoutesView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 19/03/24.
//

import SwiftUI

struct AllRoutesView: View {
    @EnvironmentObject var viewModel: ActiveRouteViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.allRoutes) { route in
                    NavigationLink {
                        RouteMapView(route: route)
                    } label: {
                        HStack {
                            Image("BusIcon\(route.color.rawValue)")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(route.name)
                                .bold()
                        }
                    }
                    
                }
            }
            .listStyle(.insetGrouped)
            .listRowBackground(Color.clear)
            .listRowSpacing(20)
            .navigationTitle("Rutas")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

#Preview {
    AllRoutesView()
}
