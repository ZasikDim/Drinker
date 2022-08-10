//
//  AllIngredientsView.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 28.07.22.
//

import SwiftUI

struct AllIngredientsView: View {
    let viewModel: IngredientsViewModel
    
    var body: some View {
        VStack {
            Text("All equipments")
            // .foregroundStyle( gradient)
                .font(.title.bold())
            ScrollView {
            
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: 12) {
                    ForEach(viewModel.ingredients) { ingredient in
                        IngredientRoundView(ingredient: ingredient)
                    }
                }
            }
            
            
        }
        .task {
            do {
                try await viewModel.getAllIngredients()
            } catch {
                print("Error", error) // TODO!!!!
            }
        }
    }
}

//struct AllIngredientsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllIngredientsView()
//    }
//}
