//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import Foundation

class PokemonDetails: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let abilities: [AbilityEntry]
    let types: [TypeEntry]

    struct Sprites: Codable {
        let front_default: String?
        let other: OtherSprites?

        struct OtherSprites: Codable {
            let officialArtwork: OfficialArtWork?

            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }

            struct OfficialArtWork: Codable {
                let front_default: String
            }
        }

        enum CodingKeys: String, CodingKey {
            case front_default
            case other
        }
    }

    struct TypeEntry: Codable {
        let slot: Int
        let type: NamedAPIResource
    }

    struct AbilityEntry: Codable {
        let ability: NamedAPIResource
        let is_hidden: Bool
    }

    struct NamedAPIResource: Codable {
        let name: String
        let url: String
    }
}
