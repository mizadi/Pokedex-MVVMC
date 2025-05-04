//
//  PokedexCoordinator.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import UIKit


class PokedexCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = PokedexListViewModel(service: PokemonApiService(session: .shared))
        let storyboard = UIStoryboard(name: "PokedexListView", bundle: nil)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController,
              let pokedexVC = navController.topViewController as? PokedexListViewController else {
            fatalError("Initial VC not set or not a UINavigationController with PokedexListViewController")
        }

        pokedexVC.viewModel = viewModel
        pokedexVC.coordinator = self
        pokedexVC.onPokemonSelected = { [weak self] name in
            self?.showDetails(for: name)
        }
        navigationController.pushViewController(pokedexVC, animated: false)
    }

    func showDetails(for name: String) {
        let api = PokemonApiService(session: .shared)
        let cache = FilePokemonCache()
        let repository = DefaultPokemonRepository(api: api, cache: cache)
        let detailsVM = PokemonDetailsViewModel(repository: repository, pokemonName: name)

        let detailsVC = UIStoryboard(name: "PokemonDetails", bundle: nil).instantiateInitialViewController() as! PokemonDetailsViewController
        detailsVC.viewModel = detailsVM
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
