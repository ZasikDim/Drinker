//
//  Coctail.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 26.07.22.
//

import Foundation

typealias Coctails = [Coctail]
struct Coctail: Identifiable, Codable {
    let id: Int
    let name: String
    let photo: String
    let type: CoctailType
    
    let description: String?
    let photos: [String]?
    let tags: [String]?
    let ingredients: [Ingredient]?
    let equipments: [Equipment]?
    let recipe: [String]?
}

enum CoctailType: String, Codable {
    case alco = "alco"
    case nonAlco = "nonAlco"
}
typealias Ingredients = [Ingredient]
struct Ingredient: Identifiable, Codable {
    let id: Int
    let name: String
    let photo: String
    let description: String?
    let type: String
    let quantity: Int?
    let unit: String
}
typealias Equipments = [Equipment]
struct Equipment: Identifiable, Codable {
    let id: Int
    let name: String
    let photo: String
    let description: String?
    let type: String
    let quantity: Int?
    let unit: String
}
