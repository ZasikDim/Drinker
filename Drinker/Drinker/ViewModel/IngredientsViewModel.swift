//
//  IngredientViewModel.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 30.07.22.
//

import Foundation
import RealmSwift

final class IngredientsViewModel {
    
    @ObservedResults(IngredientFromRealm.self) var ingredients
        
    private let networkManager: IngredientsNetworkManager
    private let realmManager: RealmManager
    
    init(networkManager: IngredientsNetworkManager, realmManager: RealmManager) {
        self.networkManager = networkManager
        self.realmManager = realmManager
    }
    
    @MainActor
    func getAllIngredients() async throws {
        do {
            let items = try await networkManager.getAllIngredients()
            for item in items {

                if ingredients.first(where: {$0.id == item.id}) != nil {
                    
                } else {
                    let ingredient = covertIngredientToIngredientFromRealm(ingredient: item)
                    self.$ingredients.append(ingredient)
                }
            }
        } catch {
            print("getAllIngredients Error:---", error)
        }
    }
    
    @MainActor
    func addIngredient(name: String, description: String, photo: String, type: String, unit: String) async throws {
        do {
            try await networkManager.addIngredient(name: name, description: description, photo: photo, type: type, unit: unit)
        } catch {
            print("addIngredient Error:---", error)
        }
    }
    
    private func covertIngredientToIngredientFromRealm(ingredient: Ingredient) -> IngredientFromRealm {
        return IngredientFromRealm(id: ingredient.id, name: ingredient.name, photo: ingredient.photo, type: ingredient.type, unit: ingredient.unit)
    }

}
