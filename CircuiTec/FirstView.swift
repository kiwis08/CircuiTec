//
//  FirstView.swift
//  CircuiTec
//
//  Created by Alumno on 21/03/24.
//

import SwiftUI
import MapKit

struct FirstView: View {
    
    func card(imageName: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 16.0) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 60)
                .padding(.top)
            
            //Card
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)

                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)

            }
        }
        .frame(width: 110, height: 160)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(radius: 6)
        .padding(.horizontal, 3)
    }

    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Mapa
                Map()
                    .mapStyle(.standard)
                    .frame(width:350, height: 450)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 10)
                
                HStack {
                    Text("Parada sugerida")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal, 20)

                    
                
                //Cards
                HStack{
                    card(imageName: "garza sada", title: "Parada", subtitle: "Parada sugerida")
                    card(imageName: "mapa", title: "Cómo llegar", subtitle: "Camina a tu parada")
                    card(imageName: "mapa", title: "Hora de llegada", subtitle: "7 minutos")
            
                }
                
            }
            .navigationTitle("¡Hola!")
            
        }
    }
    
    
    
}

#Preview {
    FirstView()
}
