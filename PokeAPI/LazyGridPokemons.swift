//
//  LazyGridPokemons.swift
//  PokeAPI
//
//  Created by Fabiola Correa Padilla.
//

import SwiftUI

struct LazyGridPokemons: View {
    @ObservedObject var viewModel: PokemonsViewModel

    // Define el layout de la cuadrícula
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.filteredPokemons) { pokemon in
                    VStack {
                        // Carga la imagen desde la URL
                        AsyncImage(url: URL(string: pokemon.imageUrl)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else if phase.error != nil {
                                Text("Error loading image")
                                    .foregroundColor(.red)
                            } else {
                                ProgressView()
                            }
                        }

                        Text(pokemon.name.capitalized)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

struct LazyGridPokemons_Previews: PreviewProvider {
    static var previews: some View {
        // Crear una instancia de vista previa con datos de ejemplo
        let samplePokemons = [
            PokemonModel(id: 1, name: "bulbasaur", type: "poison", description: "", attack: 0, defense: 0, height: 0, weight: 0, imageUrl: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334", evolutionChain: []),
            PokemonModel(id: 2, name: "ivysaur", type: "poison", description: "", attack: 0, defense: 0, height: 0, weight: 0, imageUrl: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F62294490-1131-48DD-81E3-D328E54FAD12?alt=media&token=8aa9f6b8-3ee2-43a1-a48e-6e2218afc528", evolutionChain: [])
        ]
        
        let viewModel = PokemonsViewModel()
        viewModel.pokemons = samplePokemons
        viewModel.filteredPokemons = samplePokemons
        
        return LazyGridPokemons(viewModel: viewModel)
    }
}
