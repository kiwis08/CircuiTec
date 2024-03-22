//
//  FollowingRouteCard.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import SwiftUI

struct FollowingRouteCard: View {
    var route: Route
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .center) {
                Image("BusIcon\(route.color.rawValue.capitalized)")
                    .resizable()
                    .frame(width: 30, height: 30)
                VStack {
                    Text("Siguiendo: ") +
                    Text(route.name).foregroundStyle(Color("Bus\(route.color.rawValue.capitalized)"))
                        .bold()
                }
            }
            .padding(.bottom)
            RouteProgressView(orientation: .horizontal, color: Color("Bus\(route.color.rawValue.capitalized)"), route: route)
                .padding(.bottom)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(radius: 6)
        .padding(.horizontal)
    }
}

#Preview {
    FollowingRouteCard(route: ActiveRouteViewModel.sampleRoutes.first!)
}
