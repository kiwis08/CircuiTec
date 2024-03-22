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
                    
                    Map()
                        .mapStyle(.standard)
                        .frame(width:350, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 10)
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
                
                if viewModel.isFollowingRoute {
                    Text("Following route: \(viewModel.activeRoute!.route.name)")
                }
                
                
                
                //Cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        FavoriteLocationCard(favoriteLoc: FavoriteLocation(name: "Parada", address: "Nuevo Sur", image: "revolucion"))
                        FavoriteLocationCard(favoriteLoc: FavoriteLocation(name: "Walmart Las Torres", address: "Eugenio Garza Sada 6110", image: "tienda"))
                        FavoriteLocationCard(favoriteLoc: FavoriteLocation(name: "IMSS Clínica 33", address: "Ruta Garza Sada 6110", image: "garza sada"))
                        FavoriteLocationCard(favoriteLoc: FavoriteLocation(name: "Oxxo Río Pánuco", address: "Nuevo Sur", image: "hospitales"))
                        FavoriteLocationCard(favoriteLoc: FavoriteLocation(name: "Casa Dani", address: "Junco de la Vega #2443", image: "mapa"))
                        FavoriteLocationCard(favoriteLoc: FavoriteLocation(name: "Casa", address: "Nuevo Sur", image: "casa"))
                    }
                }
                .frame(height: 100)
                .transition(.move(edge: .bottom))
                .padding(.horizontal, 10)
                
                Spacer()
                
                
            }
            .navigationTitle("¡Hola!")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}

#Preview {
    FirstView()
}
