//
//  RouteMapView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 20/03/24.
//

import SwiftUI
import MapKit

struct RouteMapView: View {
    @Environment(\.dismiss) private var dismiss
    
    var route: Route
    var body: some View {
        Map()
            .sheet(isPresented: .constant(true), content: {
                VStack(alignment: .center) {
                    HStack {
                        Image("BusIcon\(route.color.rawValue)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.leading)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(route.name)
                                .font(.title)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                            Text("Paradas")
                        }
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.separator)
                            .padding()
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    .padding(.top, 30)
                    Button(action: {}, label: {
                        Text("Seguir")
                            .font(.headline)
                    })
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .padding()
                }
                .presentationDetents([.fraction(0.2), .fraction(0.21)])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
            })
            .toolbar(.hidden)
    }
}

#Preview {
    RouteMapView(route: Route(name: "Ruta Hospitales y Escuelas y Directo San Jose", color: .red))
}
