//
//  ContentView.swift
//  PokeAPI
//
//  Created by Fabiola Correa Padilla.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Usar la vista LazyGridPokemons y pasarle el ViewModel
                LazyGridPokemons(viewModel: viewModel)
                    .navigationTitle("Pokedex")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

