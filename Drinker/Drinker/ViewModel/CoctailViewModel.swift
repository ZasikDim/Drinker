//
//  CoctailViewModel.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 27.07.22.
//

import Foundation
import RealmSwift

final class CoctailViewModel {
    
    @ObservedRealmObject var coctail: CoctailfromRealm
    let networkManager: CoctailsNetworkManager
    
    init(coctail: CoctailfromRealm, networkManager: CoctailsNetworkManager){
        self.coctail = coctail
        self.networkManager = networkManager
    }
    
    @MainActor
    func getAllCoctailInfoById(id: Int) async throws {
        do {
            let item = try await networkManager.getAllCoctailInfoById(id: id)
            
            guard let thawed = coctail.thaw(), let realm = thawed.realm else {
                    return
                }
                try! realm.write {
                    
                    thawed.name = item.name
                    thawed.photo = item.photo
                    thawed.type = item.type.rawValue
                    
                    if let description = item.description {
                        thawed.coctailDescription = description
                    }
                    
                    if let ingredients = item.ingredients {
                        let realmm = try! Realm()  // TODO!!!!! убрать или сделать класс
                        for ingredient in ingredients {
                            var ingredientForRealm: IngredientFromRealm? = nil
                            
                            if let ingredientFromRealm = realmm.object(ofType: IngredientFromRealm.self, forPrimaryKey: ingredient.id) {
                                ingredientForRealm = ingredientFromRealm
                            } else {
                                let ingredientFromRealm = IngredientFromRealm()
                                ingredientFromRealm.id = ingredient.id
                                ingredientFromRealm.photo = ingredient.photo
                                ingredientFromRealm.name = ingredient.name
                                ingredientFromRealm.type = ingredient.type
                                ingredientFromRealm.unit = ingredient.unit

                                if let description = ingredient.description {
                                    ingredientFromRealm.ingredientDescription = description
                                }
                                ingredientForRealm = ingredientFromRealm
                            }

                            guard let ingredientForRealm = ingredientForRealm else { return }
                            guard let quantity = ingredient.quantity else { return }

                            
                            let coctailIngredient = CoctailIngredient(coctailId: item.id, ingredient: ingredientForRealm, quantity: quantity)
                            thawed.ingredients.append(coctailIngredient)
                        }
                        
                    }
                    
                    if let equipments = item.equipments {
                        let realmm = try! Realm() // TODO!!!!! убрать или сделать класс
                        for equipment in equipments {
                            var equipmentForRealm: EquipmentFromRealm? = nil
                            if let equipmentFromRealm = realmm.object(ofType: EquipmentFromRealm.self, forPrimaryKey: equipment.id) {
                                equipmentForRealm = equipmentFromRealm
                            } else {
                                let equipmentFromRealm = EquipmentFromRealm()
                                equipmentFromRealm.id = equipment.id
                                equipmentFromRealm.photo = equipment.photo
                                equipmentFromRealm.name = equipment.name
                                equipmentFromRealm.type = equipment.type
                                equipmentFromRealm.unit = equipment.unit
                                if let description = equipment.description {
                                    equipmentFromRealm.equipmentDescription = description
                                }
                                equipmentForRealm = equipmentFromRealm
                            }
                            guard let equipmentForRealm = equipmentForRealm else { return }
                            guard let quantity = equipment.quantity else { return }
                            let coctailEquipment = CoctailEquipment(coctailId: item.id, equipment: equipmentForRealm, quantity: quantity)
                            thawed.equipments.append(coctailEquipment)
                        }
                    }
                    
                    if let recipe = item.recipe {
                        
                        for step in recipe {
                            thawed.recipe.append(step)
                        }
                        
                    }
                    
                }
            
        } catch {
            print("Error:---", error)
        }
    }
    
    
    
    
}
