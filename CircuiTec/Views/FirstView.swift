//
//  FirstView.swift
//  CircuiTec
//
//  Created by Alumno on 21/03/24.
//

import SwiftUI
import MapKit
import UIKit
import CoreLocation

struct FirstView: View {
    @EnvironmentObject var viewModel: ActiveRouteViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @StateObject private var activityManager = ActivityManager.shared
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var mapRoutes = [MKRoute]()

    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                //Barra de busqueda
                HStack {
                    Text("Buscar destino")
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        // Acción que quieres que ocurra cuando se presiona el botón
                        print("Botón presionado")
                    }) {
                        Image(systemName: "magnifyingglass")
                            .padding(.horizontal)
                    }
                }
                .frame(width: 350, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .shadow(radius: 10)
                .padding(.horizontal, 2)
                .padding(.vertical)
                
                
                
                
                // Mapa
                VStack {
                    HStack {
                        Text("Parada más cercana")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                        .mapStyle(.standard)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                    if viewModel.isFollowingRoute {
                        NavigationLink {
                            ActiveRouteMapView(mapRoutes: $mapRoutes)
                        } label: {
                            FollowingRouteCard(route: viewModel.activeRoute!.route)
                        }
                        .buttonStyle(.plain)
                        .task {
                            await activityManager.start(route: viewModel.activeRoute?.route ?? ActiveRouteViewModel.sampleRoutes.first!)
                        }
                        .onAppear {
                            Task {
                                await activityManager.updateActivityRandomly()
                                print(activityManager.activityToken)
                            }
                        }
                    }
                }
                
                
                //Favoritos
                HStack {
                    Text("Favoritos")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button(action: {
                        // Acción que quieres que ocurra cuando se presiona el botón
                        print("Botón presionado")
                    }) {
                        Image(systemName: "plus.circle")
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .padding(.top, 20)
                
                
                
                //Cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.favoriteStops, id: \.stop.id) { favorite in
                            NavigationLink {
                                FavoriteView(favoriteStop: favorite)
                            } label: {
                                FavoriteLocationCard(favoriteLoc: favorite)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(height: 100)
                .transition(.move(edge: .bottom))
                .padding(.horizontal, 10)
                
                Spacer()
                
                
            }
            .task {
                if viewModel.isFollowingRoute {
                    mapRoutes = await viewModel.activeRoute!.route.getMKRoutes()
                } else {
                    await activityManager.cancelAllRunningActivities()
                }
            }
            .navigationTitle("Bienvenido")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}

#Preview {
    FirstView()
        .environmentObject(ActiveRouteViewModel())
}
