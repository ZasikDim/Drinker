//
//  CoctailFromRealm .swift
//  Drinker
//
//  Created by Dmitry Zasenko on 26.07.22.
//

import Foundation
import RealmSwift

final class CoctailfromRealm: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var photo: String = ""
    @Persisted var type: CoctailType.RawValue = CoctailType.alco.rawValue
    
    @Persisted var coctailDescription: String = ""
    @Persisted var notes: String = ""
    @Persisted var photos = List<String>()
    @Persisted var tags = List<String>()
    @Persisted var ingredients: List<CoctailIngredient>
    @Persisted var equipments = List<CoctailEquipment>()
    @Persisted var recipe = List<String>()
    
    @Persisted var isLiked: Bool = false
}

final class CoctailIngredient: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var coctailId: Int = 0 /// Coctail id
    @Persisted var ingredient: IngredientFromRealm?
    @Persisted var quantity: Int = 0

  //  @Persisted(originProperty: "ingredients") var ingredients: LinkingObjects<CoctailfromRealm>
    convenience init(coctailId: Int, ingredient: IngredientFromRealm, quantity: Int) {
        self.init()
        self.id = id
        self.ingredient = ingredient
        self.quantity = quantity
    }
}
//
final class IngredientFromRealm: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var photo: String = ""
    @Persisted var ingredientDescription: String = ""
    @Persisted var type: String = ""
    @Persisted var unit: String = ""

    @Persisted(originProperty: "ingredient") var ingredient: LinkingObjects<CoctailIngredient>
    
    convenience init(id: Int, name: String, photo: String, type: String, unit: String) {
        self.init()
        self.id = id
        self.name = name
        self.photo = photo
        self.type = type
        self.unit = unit
    }
}

final class CoctailEquipment: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var coctailId: Int = 0 /// Coctail id
    @Persisted var equipment: EquipmentFromRealm?
    @Persisted var quantity: Int = 0

 //   @Persisted(originProperty: "equipments") var equipments: LinkingObjects<CoctailfromRealm>
    
    convenience init(coctailId: Int, equipment: EquipmentFromRealm, quantity: Int) {
        self.init()
        self.id = id
        self.equipment = equipment
        self.quantity = quantity
    }
}

final class EquipmentFromRealm: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var photo: String = ""
    @Persisted var equipmentDescription: String = ""
    @Persisted var type: String = ""
    @Persisted var unit: String = ""

    @Persisted(originProperty: "equipment") var equipment: LinkingObjects<CoctailEquipment>
    
    convenience init(id: Int, name: String, photo: String, type: String, unit: String) {
        self.init()
        self.id = id
        self.name = name
        self.photo = photo
        self.type = type
        self.unit = unit
    }
}
