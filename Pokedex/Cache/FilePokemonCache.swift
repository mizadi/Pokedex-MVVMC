//
//  FilePokemonCache.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//
import Foundation

class FilePokemonCache: PokemonCache {
    private let directory: URL = {
        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let path = url.appendingPathComponent("PokemonCache")
        try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
        return path
    }()

    func getPokemon(withName name: String) -> PokemonDetails? {
        let fileURL = directory.appendingPathComponent("\(name).json")
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode(PokemonDetails.self, from: data)
    }

    func savePokemon(_ pokemon: PokemonDetails) {
        let fileURL = directory.appendingPathComponent("\(pokemon.name).json")
        if let data = try? JSONEncoder().encode(pokemon) {
            try? data.write(to: fileURL)
        }
    }
}
