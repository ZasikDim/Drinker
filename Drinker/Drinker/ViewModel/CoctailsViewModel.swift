//
//  CoctailsViewModel.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 26.07.22.
//

import Foundation
import RealmSwift

final class CoctailsViewModel {
    
    
    @ObservedResults(CoctailfromRealm.self) var coctails
    
    let networkManager: CoctailsNetworkManager
    let realmManager: RealmManager
    
    init(networkManager: CoctailsNetworkManager, realmManager: RealmManager) {
        self.networkManager = networkManager
        self.realmManager = realmManager
    }
    
    @MainActor
    func getAllCoctails() async throws {
        do {
            let items = try await networkManager.getAllCoctails()
            for item in items {
                if coctails.first(where: {$0.id == item.id}) != nil {
                    return
                } else {
                    let coctail = CoctailfromRealm()
                    coctail.id = item.id
                    coctail.name = item.name
                    coctail.photo = item.photo
                    coctail.type = item.type.rawValue
                    self.$coctails.append(coctail)
                }
            }
        } catch {
            print("Error:---", error)
        }
    }
}
