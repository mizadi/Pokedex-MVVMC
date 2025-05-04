//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import Foundation

class PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}
