//
//  EquipmentsViewModel.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 29.07.22.
//

import Foundation
import RealmSwift

final class EquipmentsViewModel {
    
    @ObservedResults(EquipmentFromRealm.self) var equipments
    
    private let networkManager: EquipmentsNetworkManager
    private let realmManager: RealmManager
    
    init(networkManager: EquipmentsNetworkManager, realmManager: RealmManager) {
        self.networkManager = networkManager
        self.realmManager = realmManager
    }
    
    @MainActor
    func getAllEquipments() async throws {
        do {
            let items = try await networkManager.getAllEquipments()
        
            for item in items {
                if equipments.first(where: {$0.id == item.id}) != nil {
                    
                } else {
                    let equipment = covertEquipmentToEquipmentFromRealm(equipment: item)
                    self.$equipments.append(equipment)
                }
            }
        } catch {
            print("Error:---", error)
        }
    }
    
    @MainActor
    func addEquipment(name: String, description: String, photo: String, type: String, unit: String) async throws {
        do {
            try await networkManager.addEquipment(name: name, description: description, photo: photo, type: type, unit: unit)
        } catch {
            print("Error:---", error)
        }
    }
    
    private func covertEquipmentToEquipmentFromRealm(equipment: Equipment) -> EquipmentFromRealm {
        return EquipmentFromRealm(id: equipment.id, name: equipment.name, photo: equipment.photo, type: equipment.type, unit: equipment.unit)
    }

}
