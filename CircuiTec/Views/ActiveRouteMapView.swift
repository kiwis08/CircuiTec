//
//  ActiveRouteMapView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import SwiftUI
import MapKit

struct ActiveRouteMapView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ActiveRouteViewModel
    
    
    @Binding var mapRoutes: [MKRoute]
    
    
    var body: some View {
        let route = viewModel.activeRoute?.route ?? ActiveRouteViewModel.sampleRoutes.first!
        return RouteMap(route: route, showBusLocation: true, mapRoutes: $mapRoutes)
            .sheet(isPresented: .constant(true), content: {
                GeometryReader { geo in
                    VStack(alignment: .center) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color("Bus\(route.color.rawValue.capitalized)"))
                                    .frame(width: 50, height: 50)
                                VStack(spacing: 0) {
                                    Text("\(viewModel.activeRoute?.timeLeft ?? 0)")
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, -5)
                                    Text("min")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                }
                                .bold()
                            }
                            Text(route.name)
                                .font(.title)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
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
                        .padding(.top)
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Asientos disponibles")
                                .bold()
                            Spacer()
                            Text("\(viewModel.activeRoute?.availableSeats ?? 15)")
                                .bold()
                        }
                        .padding(.horizontal)
                        
                        
                        Button(action: {
                            dismiss()
                            viewModel.stopFollowingRoute()
                        }, label: {
                            Text("Dejar de seguir")
                                .font(.headline)
                        })
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .padding()
                        
                        
                        HStack {
                            RouteProgressView(orientation: .vertical, color: Color("Bus\(route.color.rawValue.capitalized)"), route: route)
                                .frame(height: geo.size.height * 0.7)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                    }
                    .presentationDetents([.fraction(0.2), .large])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
                }
            })
            .toolbar(.hidden)
    }
}

//#Preview {
//    ActiveRouteMapView()
//}
