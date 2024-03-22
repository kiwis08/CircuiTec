//
//  FavoriteView.swift
//  CircuiTec
//
//  Created by Alumno on 21/03/24.
//

import SwiftUI
import MapKit
import UIKit
import CoreLocation

struct FavoriteView: View {
    @EnvironmentObject var viewModel: ActiveRouteViewModel
    
    var favoriteStop: FavoriteStop
    
    @State private var showActiveRouteView = false
    
    @State private var mapRoutes = [MKRoute]()
    
    func card(imageName: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 16.0) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 40)
                .padding(.top)
            
            //Card
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
            }
            .padding(.horizontal, 5)
            
            
        }
        .frame(width: 110, height: 120)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(radius: 6)
        .padding(.horizontal, 2)
        .padding(.vertical)
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                RouteMap(route: viewModel.getRouteFromStop(stop: favoriteStop.stop), showBusLocation: true, mapRoutes: $mapRoutes)
                    .mapStyle(.standard)
                    .frame(height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding()
                
                Button(action: {
                    if viewModel.isFollowing(route: viewModel.getRouteFromStop(stop: favoriteStop.stop)) {
                        viewModel.stopFollowingRoute()
                    } else {
                        viewModel.startFollowing(route: viewModel.getRouteFromStop(stop: favoriteStop.stop))
                        showActiveRouteView = true
                    }
                }) {
                    if viewModel.isFollowing(route: viewModel.getRouteFromStop(stop: favoriteStop.stop)) {
                        Text("Dejar de seguir")
                            .foregroundStyle(.red)
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                    } else {
                        Text("Seguir")
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                    }
                }
                .buttonStyle(.bordered)
                .padding(.horizontal)
                
            }
            
            //Información
            HStack {
                Text("Información de parada")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top)
            
            
            Spacer()
            
            //Cards
            HStack {
                card(imageName: "revolucion", title: "Parada", subtitle: favoriteStop.stop.name)
                card(imageName: "mapa", title: "Cómo llegar", subtitle: "Junco de la vega")
                card(imageName: "mapa", title: "Próximo", subtitle: "Llega en 7 mins")
                
            }
            .frame(height: 100)
            .padding(.horizontal, 10)
            .padding(.bottom)
            
            Spacer()
            
            
        }
        .task {
            mapRoutes = await viewModel.getRouteFromStop(stop: favoriteStop.stop).getMKRoutes()
        }
        .navigationDestination(isPresented: $showActiveRouteView, destination: {
            ActiveRouteMapView(mapRoutes: $mapRoutes)
        })
        .navigationTitle(favoriteStop.stop.name)
        .navigationBarTitleDisplayMode(.large)
    }
    
    
    
    
}


//#Preview {
//    FavoriteView(favoriteStop: FavoriteStop(stop: <#T##RouteStop#>, address: <#T##String#>, image: <#T##String#>))
//}
