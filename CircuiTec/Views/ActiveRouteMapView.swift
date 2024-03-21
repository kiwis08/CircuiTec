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
    @Binding var activeRoute: ActiveRoute
    
    var body: some View {
        Map()
            .sheet(isPresented: .constant(true), content: {
                VStack(alignment: .center) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("Bus\(activeRoute.route.color.rawValue.capitalized)"))
                                .frame(width: 50, height: 50)
                            VStack(spacing: 0) {
                                Text("\(activeRoute.timeLeft)")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .padding(.vertical, -5)
                                Text("min")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                            }
                            .bold()
                        }
                        Text(activeRoute.route.name)
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
                    .padding(.top, 30)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Asientos disponibles")
                            .bold()
                        Spacer()
                        Text("\(activeRoute.availableSeats)")
                            .bold()
                    }
                    .padding(.horizontal)
                    
                    
                    Button(action: {}, label: {
                        Text("Dejar de seguir")
                            .font(.headline)
                    })
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .padding()
                    
                    Spacer()
                }
                .presentationDetents([.fraction(0.2), .large])
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
            })
            .toolbar(.hidden)
    }
}

#Preview {
    ActiveRouteMapView(activeRoute: .constant(ActiveRoute(route: Route.samples.first!, availableSeats: 10, timeLeft: 8)))
}
