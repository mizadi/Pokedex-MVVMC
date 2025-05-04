//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

class PokemonDetailsViewModel {
    private let service: PokemonApiServiceProtocol
    private let pokemonName: String

    var pokemon: PokemonDetails? // Your model
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(service: PokemonApiServiceProtocol, pokemonName: String) {
        self.service = service
        self.pokemonName = pokemonName
    }

    func fetchDetails() {
        Task {
            do {
                let result = try await service.fetchPokemonDetails(name: pokemonName)
                self.pokemon = result
                onDataUpdate?()
            } catch {
                onError?(error)
            }
        }
    }
}
