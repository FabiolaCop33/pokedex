//
//  Networking.swift
//  PokeAPI
//
//  Created by Fabiola Correa Padilla.
//

import Foundation

struct Networking {
    static let shared = Networking()
    
    init() {}
    
     enum ClientErrorPokemon: Error {
        case invalidURL
        case unableToComplete
        case invalidResponse
        case invalidData
        case decoding(Error)
    }
}

// Declaración de la extensión fuera de la estructura original
extension Networking {
     func fetchPokemons(completion: @escaping (Result<[PokemonModel], ClientErrorPokemon>) -> Void) {
        let url = Constants.Urls.pokemons
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode([PokemonModel].self, from: data)
                completion(.success(pokemons))
            } catch {
                completion(.failure(.decoding(error)))
            }
        }
        
        task.resume()
    }
}
