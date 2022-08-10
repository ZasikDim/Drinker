//
//  CoctailsNetworkManager.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 26.07.22.
//

import Foundation

enum FetchError: Error {
    case statusNot200
    case decoderError
    case bedUrl
    case badServerResponse
}

class CoctailsNetworkManager {
    private let scheme = "https"
    private let host = "zasik.000webhostapp.com"
    
    func getAllCoctails() async throws -> Coctails {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/get_all_coctails.php"
            return components
        }
        guard let url = urlComponents.url else { throw FetchError.bedUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else { throw FetchError.badServerResponse }
        guard response.statusCode == 200 else { throw FetchError.statusNot200 }
        guard let decodedCoctails = try? JSONDecoder().decode(Coctails.self, from: data) else { throw FetchError.decoderError }
        return decodedCoctails
    }
    
    func getAllCoctailInfoById(id: Int) async throws -> Coctail {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/get_all_coctail_info_by_id.php"
            components.queryItems = [URLQueryItem(name: "id", value: String(id))]
            return components
        }
        guard let url = urlComponents.url else { throw FetchError.bedUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.statusNot200 }
        guard let decodedCoctail = try? JSONDecoder().decode(Coctail.self, from: data) else { throw FetchError.decoderError }
        return decodedCoctail
    }
    
    func addIngredient(name: String, description: String, photo: String, type: String, unit: String) async throws {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/add_ingredient.php"
            components.queryItems = [URLQueryItem(name: "name", value: name),
                                     URLQueryItem(name: "description", value: description),
                                     URLQueryItem(name: "photo", value: photo),
                                     URLQueryItem(name: "type", value: type),
                                     URLQueryItem(name: "unit", value: unit)]
            return components
        }
        guard let url = urlComponents.url else { throw FetchError.bedUrl }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            //TODO !!!!!!   приходит результат json
            guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) else {
                print("fuuuuuuuu")
                return
            }
            print(json)
            
            
            
        }
        task.resume()
    }
    
    func getAllIngredients() async throws -> Ingredients {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/get_all_ingredients.php"
            return components
        }
        guard let url = urlComponents.url else { throw FetchError.bedUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw FetchError.badServerResponse
        }
        guard response.statusCode == 200 else {
            throw FetchError.statusNot200
        }
        guard let decodedEquipments = try? JSONDecoder().decode(Ingredients.self, from: data) else {
            throw FetchError.decoderError
        }
        return decodedEquipments
    }
    
    
    func addEquipment(name: String, description: String, photo: String, type: String, unit: String) async throws {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/add_equipment.php"
            components.queryItems = [URLQueryItem(name: "name", value: name),
                                     URLQueryItem(name: "description", value: description),
                                     URLQueryItem(name: "photo", value: photo),
                                     URLQueryItem(name: "type", value: type),
                                     URLQueryItem(name: "unit", value: unit)]
            return components
        }
        guard let url = urlComponents.url else { throw FetchError.bedUrl }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            //TODO !!!!!!   приходит результат json
            guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) else {
                print("fuuuuuuuu")
                return
            }
            print(json)
            
            
        }
        task.resume()
    }
    
    func getAllEquipments() async throws -> Equipments {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/get_all_equipments.php"
            return components
        }
        guard let url = urlComponents.url else { throw FetchError.bedUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw FetchError.badServerResponse
        }
        guard response.statusCode == 200 else {
            throw FetchError.statusNot200
        }
        guard let decodedEquipments = try? JSONDecoder().decode(Equipments.self, from: data) else {
            throw FetchError.decoderError
        }
        return decodedEquipments
    }
    
}
