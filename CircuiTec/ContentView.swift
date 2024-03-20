//
//  ContentView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 19/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var router: Router
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        //        List {
        //            Text("First")
        //                .onTapGesture {
        //                    router.navigate(to: .routeMap(route: Route.samples.first!))
        //                }
        //            Text("Second")
        //        }
//        NavigationStack {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        AllRoutesView()
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        }
        TabView {
            MainView()
                .tabItem {
                    Label("Mi ruta", systemImage: "map")
                }
            AllRoutesView()
                .tabItem {
                    Label("Rutas", systemImage: "bus")
                }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
