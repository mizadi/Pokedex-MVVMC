//
//  PokemonCache.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//
protocol PokemonCache {
    func getPokemon(withName name: String) -> PokemonDetails?
    func savePokemon(_ pokemon: PokemonDetails)
}
