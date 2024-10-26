//
//  PokemonsViewModel.swift
//  PokeAPI
//
//  Created by Fabiola Correa Padilla.
//

import Foundation

class PokemonsViewModel: ObservableObject {
    @Published var pokemons: [PokemonModel] = []
    @Published var filteredPokemons: [PokemonModel] = []

    
    init () {
        fetchPokemons()
    }

    
     func fetchPokemons() {
           Networking.shared.fetchPokemons { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let pokemons):
                       self?.pokemons = pokemons
                       self?.filteredPokemons = pokemons // Inicialmente no se aplica filtro
                   case .failure(let error):
                       print("Error fetching pokemons: \(error)")
                   }
               }
           }
       }
    
    // Función para filtrar los Pokémon basados en un criterio
       func filterByTypePokemons(by type: String) {
           if type.isEmpty {
               // Si no hay filtro, mostramos todos los Pokémon
               filteredPokemons = pokemons
           } else {
               // Filtrar los Pokémon según el tipo especificado
               filteredPokemons = pokemons.filter { $0.type == type }
           }
       }
    // Otra función para filtrar por nombre, si se necesita
       func filterByNamePokemons(by name: String) {
           if name.isEmpty {
               // Si no hay filtro, mostramos todos los Pokémon
               filteredPokemons = pokemons
           } else {
               // Filtrar los Pokémon según el nombre
               filteredPokemons = pokemons.filter { $0.name.lowercased().contains(name.lowercased()) }
           }
       }
}
