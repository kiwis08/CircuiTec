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
    
    @State private var mapRoutes = [MKRoute]()
    
    
    var body: some View {
        RouteMap(route: route, showBusLocation: true, mapRoutes: $mapRoutes)
        .sheet(isPresented: .constant(true), content: {
            GeometryReader { geo in
                VStack(alignment: .center) {
                    Spacer()
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
                    Spacer()
                }
                .presentationDetents([.fraction(0.15), .fraction(0.16)])
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
            }
        })
        .task {
            mapRoutes = await route.getMKRoutes()
        }
        .toolbar(.hidden)
    }
    
}

#Preview {
    RouteMapView(route: ActiveRouteViewModel.sampleRoutes.last!)
}
