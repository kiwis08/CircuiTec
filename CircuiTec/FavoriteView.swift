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
            ScrollView {
            
                           
                // Mapa
                VStack {
                    Spacer()
                    Map()
                        .mapStyle(.standard)
                        .frame(width:350, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 10)
                    
                    
                    HStack {
                        
                        
                        Button(action: {
                                    print("Botón presionado")
                                }) {
                                    Text("Seguir")
                                        .padding()
                                        .frame(width: 350)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .cornerRadius(10)
                                }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    
                    
                }
                
                
                //Información
                HStack {
                    Text("Información de parada más cerca")
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
                        card(imageName: "revolucion", title: "Parada", subtitle: "Nuevo Sur")
                        card(imageName: "mapa", title: "Cómo llegar", subtitle: "Junco de la vega")
                        card(imageName: "mapa", title: "Próximo", subtitle: "Llega en 7 mins")
                       
                }
                .frame(height: 100)
                .padding(.horizontal, 10)
                
                Spacer()
            
                
            }
            .navigationTitle("Casa")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
    
    
        
        
    }


#Preview {
    FavoriteView()
}
