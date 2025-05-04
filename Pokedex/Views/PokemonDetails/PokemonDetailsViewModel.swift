//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

class PokemonDetailsViewModel {
    private let repository: PokemonRepository
    let pokemonName: String

    var pokemon: PokemonDetails?
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(repository: PokemonRepository, pokemonName: String) {
        self.repository = repository
        self.pokemonName = pokemonName
    }

    func fetchDetails() {
        Task {
            do {
                let result = try await repository.getPokemonDetails(name: pokemonName)
                self.pokemon = result
                onDataUpdate?()
            } catch {
                onError?(error)
            }
        }
    }
}

