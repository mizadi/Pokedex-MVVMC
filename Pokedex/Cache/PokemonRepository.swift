//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

protocol PokemonRepository {
    func getPokemonDetails(name: String) async throws -> PokemonDetails
}
