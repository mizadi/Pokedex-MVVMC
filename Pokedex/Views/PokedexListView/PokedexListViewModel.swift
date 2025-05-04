//
//  PokedexListViewModel.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import Foundation

protocol PokedexListViewModelDelegate: AnyObject {
    func didUpdatePokedexList()
    func didFailWithError(_ error: Error)
    func didChangeLoadingState(_ isLoading: Bool)
}


class PokedexListViewModel {

    weak var delegate: PokedexListViewModelDelegate?

    let service: PokemonApiServiceProtocol
    private(set) var pokemons: [PokemonListItem] = []

    private var offset = 0
    private let limit = 20
    private var canLoadMore = true

    private(set) var isLoading: Bool = false {
        didSet {
            delegate?.didChangeLoadingState(isLoading)
        }
    }


    init(service: PokemonApiServiceProtocol) {
        self.service = service
    }

    func fetchNextPage() {
        guard !isLoading && canLoadMore else { return }

        isLoading = true

        Task {
            do {
                let response = try await service.fetchPokemonList(offset: offset, limit: limit)
                await MainActor.run {
                    self.pokemons.append(contentsOf: response.results)
                    self.offset += self.limit
                    self.canLoadMore = response.next != nil
                    self.isLoading = false
                    self.delegate?.didUpdatePokedexList()
                }

            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.delegate?.didFailWithError(error)
                }
            }
        }
    }

    func pokemon(at index: Int) -> PokemonListItem? {
        guard index < pokemons.count else {
            return nil
        }
        return pokemons[index]
    }

    var numberOfPokemons: Int {
        return pokemons.count
    }

}
