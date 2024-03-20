//
//  MainView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 20/03/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            Text("Tu ruta mas cercana...")
                .navigationTitle("Mi Ruta")
        }
    }
}

#Preview {
    MainView()
}
