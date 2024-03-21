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
        NavigationStack {
            VStack {
                
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

                    
                
                //Cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        card(imageName: "revolucion", title: "Parada", subtitle: "Nuevo Sur")
                        card(imageName: "casa", title: "Casa", subtitle: "Lazaro cárdenas #2525")
                        card(imageName: "tienda", title: "Walmart las Torres", subtitle: "Eugenio Garza Sada 6110")
                        card(imageName: "garza sada", title: "IMSS Clínica 33", subtitle: "Ruta Garza Sada")
                        card(imageName: "hospitales", title: "Oxxo Río Pánuco", subtitle: "Ruta Hospitales y Escuelas")
                        card(imageName: "mapa", title: "Casa Dani", subtitle: "Junco de la Vega #2443")
                    }
                }
                .frame(height: 100)
                .transition(.move(edge: .bottom))
                .padding(.horizontal, 10)
                
                Spacer()
            
                
            }
            .navigationTitle("¡Hola!")
            
        }
    }
    
    
    
}

#Preview {
    FirstView()
}
