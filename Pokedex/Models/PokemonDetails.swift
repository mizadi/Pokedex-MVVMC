//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import Foundation

class PokemonDetails: Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let abilities: [AbilityEntry]
    let types: [TypeEntry]

    struct Sprites: Decodable {
        let front_default: String?
        let other: OtherSprites?

        struct OtherSprites: Decodable {
            let officialArtwork: OfficialArtWork?

            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }

            struct OfficialArtWork: Decodable {
                let front_default: String
            }
        }

        enum CodingKeys: String, CodingKey {
            case front_default
            case other
        }
    }

    struct TypeEntry: Decodable {
        let slot: Int
        let type: NamedAPIResource
    }

    struct AbilityEntry: Decodable {
        let ability: NamedAPIResource
        let is_hidden: Bool
    }

    struct NamedAPIResource: Decodable {
        let name: String
        let url: String
    }
}
