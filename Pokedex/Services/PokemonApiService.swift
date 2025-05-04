//
//  PokemonApiService.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import Foundation

protocol PokemonApiServiceProtocol {
    func fetchPokemonList(offset: Int, limit: Int) async throws -> PokemonListResponse
    func fetchPokemonDetails(name: String) async throws -> PokemonDetails
}


class PokemonApiService: PokemonApiServiceProtocol {

    private let session: URLSession
    private let baseURL = "https://pokeapi.co/api/v2/"

    init(session: URLSession) {
        self.session = session
    }

    func fetchPokemonList(offset: Int, limit: Int) async throws -> PokemonListResponse {
        let urlString = "\(baseURL)pokemon?offset=\(offset)&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }


        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(PokemonListResponse.self, from: data)
    }
    
    func fetchPokemonDetails(name: String) async throws -> PokemonDetails {
        let urlString = "\(baseURL)pokemon/\(name)"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(PokemonDetails.self, from: data)
    }


    enum APIError: Error {
            case invalidURL
            case noData
    }

}
