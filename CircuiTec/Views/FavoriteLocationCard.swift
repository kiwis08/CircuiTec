//
//  FavoriteLocationCard.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 21/03/24.
//

import SwiftUI

struct FavoriteLocationCard: View {
    var favoriteLoc: FavoriteLocation
    
    
    var body: some View {
        VStack(spacing: 16.0) {
            Image(favoriteLoc.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 40)
                .padding(.top)
            
            //Card
            VStack(alignment: .leading, spacing: 3) {
                Text(favoriteLoc.name)
                    .font(.headline)

                Text(favoriteLoc.address)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)

            }
            .padding(.horizontal, 5)

            
        }
        .frame(width: 110, height: 120)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 4)
        .padding(.horizontal, 2)
        .padding(.vertical)
    }
}

#Preview {
    FavoriteLocationCard(favoriteLoc: FavoriteLocation(name: "Casa", address: "Nuevo Sur", image: "revolucion"))
}
