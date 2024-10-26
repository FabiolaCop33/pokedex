//
//  PokemonModel.swift
//  PokeAPI
//
//  Created by Fabiola Correa Padilla.
//

import Foundation

struct PokemonModel: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let type: String
    let description: String
    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int
    let imageUrl: String
    let evolutionChain: [Evolution]?
}

struct Evolution: Decodable, Hashable {
    let id: String
    let name: String
}


