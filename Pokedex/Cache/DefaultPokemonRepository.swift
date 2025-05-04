//
//  DefaultPokemonRepository.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//


class DefaultPokemonRepository: PokemonRepository {
    func getPokemonDetails(name: String) async throws -> PokemonDetails {
        if let cached = cache.getPokemon(withName: name) {
            return cached
        }

        do {
            let details = try await api.fetchPokemonDetails(name: name)
            cache.savePokemon(details)
            return details
        } catch {
           throw error
        }
    }
    
    private let api: PokemonApiService
    private let cache: PokemonCache

    init(api: PokemonApiService, cache: PokemonCache = FilePokemonCache()) {
        self.api = api
        self.cache = cache
    }
}
