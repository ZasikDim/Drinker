//
//  ContentView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 26.07.22.
//

import SwiftUI

struct ContentView: View {

    private let coctailsViewModel = CoctailsViewModel(networkManager: CoctailsNetworkManager(), realmManager: RealmManager())
    private let equipmentsViewModel = EquipmentsViewModel(networkManager: EquipmentsNetworkManager(), realmManager: RealmManager())

    private let ingredientsViewModel = IngredientsViewModel(networkManager: IngredientsNetworkManager(), realmManager: RealmManager())
    
    var body: some View {
        TabView {
            AllCoctailsView(viewModel: coctailsViewModel)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("All Coctails")
                }
                .tag(1)
            AllIngredientsView(viewModel: ingredientsViewModel)
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("All In")
                }
                .tag(5)
            AllEquipmentsView(viewModel: equipmentsViewModel)
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("All Equipment")
                }
                .tag(2)
            AddIngredientView(viewModel: ingredientsViewModel)
                .tabItem {
                    /// another way: Label("First", systemImage: "1.circle")
                    Image(systemName: "4.circle")
                    Text("Add Ingredient")
                }
                .tag(3)
            AddEquipmentView(viewModel: equipmentsViewModel)
                .tabItem {
                    Image(systemName: "5.circle")
                    Text("Add Equipment")
                }
                .tag(4)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
